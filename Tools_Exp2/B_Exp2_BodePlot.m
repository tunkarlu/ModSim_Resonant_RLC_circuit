% Figure nur erzeugen, wenn eine �bertragungsfunktion G vorhanden ist
if exist('G','var') 
    if isobject(G)
        %% Daten f�r Bode-Diagramm berechnen
        freq = [100:10:10000];
        omega = 2*pi*freq;
        [mag,phase] = bode(G,omega);
        mag = squeeze(mag);
        phase = squeeze(phase);
        
        %% Figure und Achsen erzeuge
        BodeFig = figure;
        BodeFig.Tag = 'BodeFig';
        BodeFig.Name = 'Bode Diagram';
        BodeFig.Color = [1 1 1];
        BodeFig.Units = 'normalized';
        BodeFig.Position = [0.25 0.05 0.5 0.88];
        BodeFig.ToolBar = 'none';
        %BodeFig.MenuBar = 'none';
        
        Amplitudengang = axes;
        Amplitudengang.Tag = 'Achse_Amp';
        Amplitudengang.Position = [0.1 0.55 0.85 0.4];
        Amplitudengang.Box = 'on';
        Amplitudengang.XGrid = 'on';
        Amplitudengang.YGrid = 'on';
        Amplitudengang.NextPlot = 'add';
        Amplitudengang.XScale = 'log';
        Amplitudengang.YLabel.String = 'amplitude response [abs]';
        
        Phasengang = axes;
        Phasengang.Tag = 'Achse_Phase';
        Phasengang.Position = [0.1 0.07 0.85 0.4];
        Phasengang.Box = 'on';
        Phasengang.XGrid = 'on';
        Phasengang.YGrid = 'on';
        Phasengang.NextPlot = 'add';
        Phasengang.XScale = 'log';
        Phasengang.XLabel.String = 'frequency [Hz]';
        Phasengang.YLabel.String = 'phase response [�]';
        
        %% Linken der Achsen
        linkaxes([Amplitudengang,Phasengang],'x');
        
        Amplitudengang.XLim = [freq(1) freq(end)];
        
        %% Zomm-Einstellungen festlegen
        ZoomHandle = zoom(BodeFig);
        ZoomHandle.Enable = 'on';
        
        %% Linien plotten
        LinienBreite = 2;
        
        Linie_Amp = line(Amplitudengang,freq,mag);
        Linie_Amp.LineWidth = LinienBreite;
        Linie_Amp.Color = 'b';
        
        Linie_Phase = line(Phasengang,freq,phase);
        Linie_Phase.LineWidth = LinienBreite;
        Linie_Phase.Color = 'b';
    else
        errordlg('G is not a transfer function','Error');
    end
else
    errordlg('No variable G exists in the MATLAB workspace','Error');
end
    
        
    