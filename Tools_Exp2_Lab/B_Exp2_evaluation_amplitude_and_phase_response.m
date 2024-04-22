%zunächst Workspace leeren
clear all

%aktuellen Arbeitspfad bestimmen und Pfade zufügen bzw ändern
ActPath = pwd;
addpath([pwd '\Functions'])

cd ../Data

%Laden der Daten
[File,Path] = uigetfile({'*.mat;*.csv','Data-Files(*.mat,*.csv)';'*.*',  'All Files (*.*)'}, ...
   'Select a measurement file');
cd(ActPath)

if ~isnumeric(File)
    Infos.fileName = File;
    [Time,channel_A,channel_B] = V2_func_Daten_Import_RLC(File,Path);
    V2_GUI_Amplitudengang_Phasengang(Time,channel_A,channel_B,Infos)
end

clear File Path ActPath