%zunächst Workspace leeren
clear all

%aktuellen Arbeitspfad bestimmen und Pfade zufügen bzw ändern
ActPath = pwd;
addpath([pwd '\Functions'])

cd ../Data

%Auswählen der Daten
[Files,Path] = uigetfile({'*.mat;*.csv','Data-Files (*.mat,*.csv)';'*.*','All Files (*.*)'}, ...
   'Select measurement files','MultiSelect','on');
cd(ActPath)
if ~isnumeric(Files)
    Fig = figure;
    set(Fig,'Color',[1 1 1],'Units','normalized','Position',[0.1 0.1 0.8 0.8])
    Achse = axes;
    set(Achse,'NextPlot','add','Xgrid','on','Ygrid','on','Box','on')
    set(get(Achse,'YLabel'),'String','output voltage U_o [V]');
    set(get(Achse,'XLabel'),'String','time [s]');
    
    Farben{1} = [0 0 1];        %blau
    Farben{2} = [1 0 0];        %rot
    Farben{3} = [0 0.5 0];      %grün
    Farben{4} = [0.9 0.5 0];    %orange
    Farben{5} = [1 0 1];        %magenta
    Farben{6} = [0 1 1];        %cyan
    Farben{7} = [0 0 0];        %schwarz
    FarbCode = 0;
    
    if iscell(Files)
        Laenge = length(Files);
    else
        Laenge = 1;
    end
    
    for i = 1:Laenge
        FarbCode = FarbCode + 1; 
        %Laden der einzelnen Datenfiles
        if iscell(Files)
            [Time,Input,Output] = V2_func_Daten_Import_RLC(Files{i},Path);
        else
            [Time,Input,Output] = V2_func_Daten_Import_RLC(Files,Path);
        end
        %Plotten des Ausgangssignalverlaufs 
        plot(Time,Output,'Color',Farben{FarbCode})
        %Legenden-Einträge erzeugen
        if iscell(Files)
            Legenden_Eintraege{i} = strrep(Files{i},'_','\_');
        else
            Legenden_Eintraege{i} = strrep(Files,'_','\_');
        end
        if FarbCode == length(Farben)
            FarbCode = 0;
        end
    end 
    Legende = legend(Achse,Legenden_Eintraege);
    zoom xon
end