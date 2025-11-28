% Wczytaj wytrenowany system FIS
fis = readfis('MocnaProba.fis');

disp('===================================');
disp('WIZUALIZACJA FUNKCJI PRZYNALEŻNOŚCI');
disp('===================================');

num_inputs = length(fis.Inputs);

for i = 1:num_inputs
    input_name = char(fis.Inputs(i).Name);
    
    % MNIEJSZA figura o lepszych proporcjach
    fig = figure('Position', [100, 100, 800, 500], ...
                 'Color', 'white');
    
    plotmf(fis, 'input', i);
    
    % BEZ tytułu
    title('');
    
    % Mniejsze, czytelniejsze czcionki
    xlabel(input_name, 'FontSize', 11, 'Interpreter', 'none');
    ylabel('Stopien przynaleznosci', 'FontSize', 11);
    
    % Delikatna siatka
    grid on;
    ax = gca;
    ax.FontSize = 10;
    ax.LineWidth = 1;
    ax.GridAlpha = 0.15;
    ax.Box = 'off';
    
    % Cieńsze linie funkcji przynależności
    lines = findobj(ax, 'Type', 'line');
    for j = 1:length(lines)
        lines(j).LineWidth = 1.8;
    end
    
    % USUŃ LEGENDĘ
    legend('off');
    
    % Dopasuj osie do danych (usunięcie nadmiernych marginesów)
    axis tight;
    ylim([0 1.05]);  % Oś Y od 0 do 1 (stopień przynależności)
    
    % ZAPISZ W SUPER WYSOKIEJ JAKOŚCI
    filename = sprintf('MF_%s.png', input_name);
    print(fig, filename, '-dpng', '-r600');  % 600 DPI - bardzo wysoka jakość
    
    disp(['✓ Zapisano: ', filename]);
end

disp(' ');
disp('===================================');
disp('ZAKOŃCZONO - pliki w jakości 600 DPI');
disp('===================================');