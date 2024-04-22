%zunächst Workspace leeren
clear all

%aktuellen Arbeitspfad bestimmen und Pfade zufügen bzw ändern
ActPath = pwd;
addpath([pwd '\Functions'])

cd ../Data

%Laden der Daten
[File,Path] = uigetfile({'*.mat;*.csv','Data-Files (*.mat,*.csv)';'*.*',  'All Files (*.*)'}, ...
   'Select a neasurement file (capacitor)');
cd(ActPath)

if ~isnumeric(File)
    Infos.fileName = File;
    [Time,channel_A,channel_B] = V2_func_Daten_Import_RLC(File,Path);
    voltage_1 = channel_A-min(channel_A);
    voltage_2 = channel_B-min(channel_B);
    V2_GUI_Zeitkonstante_Kondensator(Time,voltage_1,voltage_2,Infos)
end

clear File Path ActPath