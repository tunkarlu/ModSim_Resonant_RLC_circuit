function main()

    ActPath = pwd;


    %Laden der Daten
    [File,Path] = uigetfile({'*.mat;*.csv','Data-Files (*.mat,*.csv)';'*.*',  'All Files (*.*)'}, ...
       'Select a measurement file');
    cd(ActPath)

    if ~isnumeric(File)
        [Time,Input,Output] = V2_func_Daten_Import_RLC(File,Path);
        % Bei vertauschten Messkan�len die untenstehende Funktion aktivieren
        % [Time,Input,Output] = V2_func_Daten_Import_RLC_Messkanaele_vertauscht(File,Path);
        
        %Variablen im Base Workspace anlegen (wird f�r Modell ben�tigt)
        assignin('base', 'Time', Time)
        assignin('base', 'Input', Input)
        assignin('base', 'Output', Output)
    end

    clear File Path ActPath
end

%% Funktionen

function [Zeit,Eingang,Ausgang] = V2_func_Daten_Import_RLC(File,Path)

    [pathstr,name,ext] = fileparts(fullfile(Path,File));
    clear pathstr name
        switch ext
            case '.mat'
                load(fullfile(Path,File))
                Zeit = ([0:Length-1]*Tinterval)';
                tstop = Zeit(end);
                Ausgang = B;
                Eingang = A(1:Length);
                clear Tinterval Tstart Length A B
            case '.csv'
                %File �ffnen und Einheiten einlesen
                FID = fopen(fullfile(Path,File));
                Variablen_str = fgetl(FID);
                Einheiten_str = fgetl(FID);
                ID = fclose(FID);

                Index_auf = findstr(Einheiten_str,'(');
                Index_zu = findstr(Einheiten_str,')');

                if length(Index_auf) == length(Index_zu)
                    for i = 1:length(Index_auf)
                        Einheiten{i} = Einheiten_str(Index_auf(i)+1:Index_zu(i)-1);
                    end
                else
                    disp('Fehler')
                end
                %numerische Daten einlesen
                TempData = csvread(fullfile(Path,File),3,0);
                if strmatch(Einheiten{1},'us')
                    Zeit = (TempData(:,1)-TempData(1,1))/1e6;
                else 
                    Zeit = (TempData(:,1)-TempData(1,1))/1e3;
                end
                tstop = Zeit(end);
                Eingang = TempData(:,2);
                if strmatch(Einheiten{3},'mV')
                    Ausgang = TempData(:,3)/1000;
                else 
                    Ausgang = TempData(:,3);
                end
                clear TempData Einheiten Einheiten_str FID FileType i Index_auf ...
                      Index_zu Variablen_str ID
        end
end

function [Zeit,Eingang,Ausgang] = V2_func_Daten_Import_RLC_Messkanaele_vertauscht(File,Path)

    [pathstr,name,ext] = fileparts(fullfile(Path,File));
    clear pathstr name
        switch ext
            case '.mat'
                load(fullfile(Path,File))
                Zeit = ([0:Length-1]*Tinterval)';
                tstop = Zeit(end);
                Eingang = B;
                Ausgang = A(1:Length);
                clear Tinterval Tstart Length A B
            case '.csv'
                %File �ffnen und Einheiten einlesen
                FID = fopen(fullfile(Path,File));
                Variablen_str = fgetl(FID);
                Einheiten_str = fgetl(FID);
                ID = fclose(FID);

                Index_auf = findstr(Einheiten_str,'(');
                Index_zu = findstr(Einheiten_str,')');

                if length(Index_auf) == length(Index_zu)
                    for i = 1:length(Index_auf)
                        Einheiten{i} = Einheiten_str(Index_auf(i)+1:Index_zu(i)-1);
                    end
                else
                    disp('Fehler')
                end
                %numerische Daten einlesen
                TempData = csvread(fullfile(Path,File),3,0);
                if strmatch(Einheiten{1},'us')
                    Zeit = (TempData(:,1)-TempData(1,1))/1e6;
                else 
                    Zeit = (TempData(:,1)-TempData(1,1))/1e3;
                end
                tstop = Zeit(end);
                Ausgang = TempData(:,2);
                if strmatch(Einheiten{3},'mV')
                    Eingang = TempData(:,3)/1000;
                else 
                    Eingang = TempData(:,3);
                end
                clear TempData Einheiten Einheiten_str FID FileType i Index_auf ...
                      Index_zu Variablen_str ID
        end
end

