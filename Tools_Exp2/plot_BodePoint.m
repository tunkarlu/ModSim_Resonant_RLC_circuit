function  plot_BodePoint(Freq, Amp, Phase )
%Funktion tr�gt einzelnen Punkt in das BodeDiagramm ein

%% Achsensysteme identifizieren
Achse_Amp = findobj('type','axes','tag','Achse_Amp');
Achse_Phase = findobj('type','axes','tag','Achse_Phase');

%% Plotten, wenn Achsen vorhanden
Farbe = [0.25 0.25 0.25];

if ~isempty(Achse_Amp)
    if isscalar(Achse_Amp)
        Punkt_Amp = plot(Achse_Amp,Freq,Amp);
        Punkt_Amp.Marker = 'o';
        Punkt_Amp.MarkerFaceColor = Farbe;
        Punkt_Amp.MarkerEdgeColor = Farbe;

        Punkt_Phase = plot(Achse_Phase,Freq,Phase);
        Punkt_Phase.Marker = 'o';
        Punkt_Phase.MarkerFaceColor = Farbe;
        Punkt_Phase.MarkerEdgeColor = Farbe;
    else
        errordlg('Obviously multiple Bode Diagrams exist','Error')    
    end
else
    errordlg('There was no Bode Diagram plotted so far','Error')
end
