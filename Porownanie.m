clear; clc; close all;

disp('=== PORÓWNANIE: Wartości rzeczywiste vs Predykcje ANFIS ===');

disp(' ');

% Wczytaj system FIS

disp('Wczytywanie systemu FIS...');

fis = readfis('MocnaProba.fis');

disp('✓ System FIS wczytany pomyślnie');

disp(' ');

% Wczytaj dane sprawdzające (checking data)

disp('Wczytywanie danych sprawdzających...');

checkData = readmatrix('TestData.dat');

% Usuń nagłówek jeśli istnieje

if any(isnan(checkData(1,:)))

    checkData = checkData(2:end, :);

end


% Dane wejściowe i wyjściowe

% Kolumny: Alcohol, Kwasowosc_Lotna, Siarczany, Kwas_Cytrynowy, Jakosc

checkInputs = checkData(:, 1:4);    % 4 kolumny wejściowe

checkOutputs = checkData(:, 5);     % Kolumna jakości (rzeczywiste)


fprintf('✓ Wczytano %d próbek\n', size(checkData, 1));

disp(' ');


% Oblicz predykcje ANFIS

disp('Obliczanie predykcji...');

predictions = evalfis(fis, checkInputs);

disp('✓ Predykcje obliczone');

disp(' ');


% Oblicz błędy

rmse = sqrt(mean((checkOutputs - predictions).^2));

mae = mean(abs(checkOutputs - predictions));

r2 = 1 - sum((checkOutputs - predictions).^2) / sum((checkOutputs - mean(checkOutputs)).^2);


% Wyświetl statystyki

disp('--- STATYSTYKI BŁĘDÓW ---');

fprintf('RMSE (Root Mean Square Error): %.4f\n', rmse);

fprintf('MAE  (Mean Absolute Error):    %.4f\n', mae);

fprintf('R²   (Coefficient of determination): %.4f\n', r2);

disp(' ');


% Tworzenie wykresów

figure('Position', [100, 100, 1400, 600], 'Name', 'Porównanie: Rzeczywiste vs Predykcje');


% Wykres 1: Porównanie wartości w sekwencji

subplot(1, 2, 1);

plot(checkOutputs, 'b-o', 'LineWidth', 2, 'MarkerSize', 5, 'DisplayName', 'Wartości rzeczywiste');

hold on;

plot(predictions, 'r-x', 'LineWidth', 2, 'MarkerSize', 5, 'DisplayName', 'Predykcje ANFIS');

xlabel('Numer próbki', 'FontSize', 11, 'FontWeight', 'bold');

ylabel('Jakość wina', 'FontSize', 11, 'FontWeight', 'bold');

legend('show', 'Location', 'best', 'FontSize', 10);

title('Porównanie wartości rzeczywistych i przewidywanych', 'FontSize', 12, 'FontWeight', 'bold');

grid on;

% Dodaj tekst z RMSE

text(0.05, 0.95, sprintf('RMSE = %.4f', rmse), 'Units', 'normalized','FontSize', 10, 'FontWeight', 'bold', 'BackgroundColor', 'white','EdgeColor', 'black', 'VerticalAlignment', 'top');


% Wykres 2: Scatter plot - dokładność predykcji

subplot(1, 2, 2);

scatter(checkOutputs, predictions, 50, 'filled', 'MarkerFaceAlpha', 0.6);

hold on;

% Linia idealna (y = x)

minVal = min([checkOutputs; predictions]);

maxVal = max([checkOutputs; predictions]);

plot([minVal maxVal], [minVal maxVal], 'r--', 'LineWidth', 2.5, 'DisplayName', 'Idealna predykcja');

xlabel('Wartości rzeczywiste', 'FontSize', 11, 'FontWeight', 'bold');

ylabel('Predykcje ANFIS', 'FontSize', 11, 'FontWeight', 'bold');

title('Dokładność predykcji - dane sprawdzające', 'FontSize', 12, 'FontWeight', 'bold');

legend('show', 'Location', 'best', 'FontSize', 10);

grid on;

axis equal;

xlim([minVal-0.5 maxVal+0.5]);

ylim([minVal-0.5 maxVal+0.5]);

% Dodaj tekst z R²

text(0.05, 0.95, sprintf('R² = %.4f', r2), 'Units', 'normalized','FontSize', 10, 'FontWeight', 'bold', 'BackgroundColor', 'white','EdgeColor', 'black', 'VerticalAlignment', 'top');


% Dodaj tytuł główny

sgtitle('Analiza dokładności systemu ANFIS na danych sprawdzających', 'FontSize', 14, 'FontWeight', 'bold');


% Zapisz wykres w wysokiej jakości

disp('Zapisywanie wykresu...');

set(gcf, 'Color', 'white');

print('Porownanie_Predykcje', '-dpng', '-r300');

fprintf('✓ Zapisano: Porownanie_Predykcje.png (300 DPI)\n');

disp(' ');


% Analiza rozkładu błędów

errors = checkOutputs - predictions;

figure('Position', [100, 100, 1200, 500], 'Name', 'Analiza błędów');


% Histogram błędów

subplot(1, 2, 1);

histogram(errors, 30, 'FaceColor', [0.3 0.6 0.9], 'EdgeColor', 'black');

xlabel('Błąd predykcji (rzeczywiste - predykcja)', 'FontSize', 11, 'FontWeight', 'bold');

ylabel('Liczba próbek', 'FontSize', 11, 'FontWeight', 'bold');

title('Rozkład błędów predykcji', 'FontSize', 12, 'FontWeight', 'bold');

grid on;

hold on;


% Linia dla błędu zerowego

xline(0, 'r--', 'LineWidth', 2, 'Label', 'Brak błędu');


% Wykres błędów względem wartości rzeczywistych

subplot(1, 2, 2);

scatter(checkOutputs, errors, 50, 'filled', 'MarkerFaceAlpha', 0.6);

hold on;

yline(0, 'r--', 'LineWidth', 2);

xlabel('Wartości rzeczywiste', 'FontSize', 11, 'FontWeight', 'bold');

ylabel('Błąd predykcji', 'FontSize', 11, 'FontWeight', 'bold');

title('Błędy predykcji vs wartości rzeczywiste', 'FontSize', 12, 'FontWeight', 'bold');

grid on;


% Dodaj tytuł główny

sgtitle('Analiza błędów systemu ANFIS', 'FontSize', 14, 'FontWeight', 'bold');


% Zapisz wykres błędów

disp('Zapisywanie wykresu błędów...');

set(gcf, 'Color', 'white');

print('Porownanie_Bledy', '-dpng', '-r300');

fprintf('✓ Zapisano: Porownanie_Bledy.png (300 DPI)\n');

disp(' ');


% === DODATKOWE METRYKI WYDAJNOŚCI ===

disp('=== METRYKI WYDAJNOŚCI ===');

fprintf('RMSE: %.4f\n', rmse);

fprintf('MAE:  %.4f\n', mae);

fprintf('R²:   %.4f\n', r2);


% Oblicz dokładność w zakresie ±1 punkt

accuracy_1point = 100 * sum(abs(checkOutputs - predictions) <= 1) / length(checkOutputs);

fprintf('Dokładność w zakresie ±1 punkt: %.2f%%\n', accuracy_1point);


% Średni błąd bezwzględny w procentach

mean_error_percent = 100 * mae / mean(checkOutputs);

fprintf('Średni błąd w procentach: %.2f%%\n', mean_error_percent);


disp(' ');

disp('=== ANALIZA ZAKOŃCZONA ===');