%zunächst Workspace leeren
clear all

%aktuellen Arbeitspfad bestimmen und Pfade zufügen bzw ändern
ActPath = pwd;
addpath([pwd '\Functions'])

cd ../Data

%Laden der Daten
[File,Path] = uigetfile({'*.mat;*.csv','Data-Files(*.mat,*.csv)';'*.*',  'All Files (*.*)'}, ...
   'Select a measurement file (coil)');
cd(ActPath)

if ~isnumeric(File)
    Infos.fileName = File;
    [Time,channel_A,channel_B] = V2_func_Daten_Import_RLC(File,Path);
    current = (channel_B-2.5097)/0.186;
    
    %Nullpunktskorrektur
    Korr_on = 1;
    if Korr_on == 1
        Index = find(Time > 4.5e-3,1); % Bei 5e-3 sollte 1V erreicht sein, bei 4.5e-3 also sicher noch keine Spannung anliegen
        AVG_current = mean(current(1:Index));
        current = current - AVG_current;
        clear MW_Strom
    end
    
    V2_GUI_Zeitkonstante_Spule(Time,channel_A,current,Infos)
end

clear File Path ActPath