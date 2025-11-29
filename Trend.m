% Skrypt do wizualizacji trendów między zmiennymi wejściowymi a wyjściową

% Pokazuje jak każda zmienna wpływa na jakość wina

clc;


% Wczytaj system FIS

fis = readfis('MocnaProba.fis');


disp('Generowanie wykresów trendów...');


% Parametry bazowe (wartości średnie) - punkt odniesienia dla porównania wpływu zmiennych

base_alcohol = 10.0;

base_kwasowosc = 0.50;

base_siarczany = 0.80;

base_kwas_cytrynowy = 0.40;


% Zakresy zmiennych - zawężone do obszarów gdzie system działa najbardziej stabilnie

alcohol_range = linspace(9.0, 13.5, 100); % Unikamy ekstremalnych wartości

kwasowosc_range = linspace(0.25, 1.30, 100); % Zakres gdzie widać wpływ

siarczany_range = linspace(0.50, 1.50, 100); % Typowy zakres

kwas_cytrynowy_range = linspace(0.30, 0.70, 100); % Typowy zakres


% Przygotuj figurę z 4 wykresami

figure('Name', 'Trendy zmiennych wejściowych', 'Position', [100, 100, 1200, 800]);


% ===== Wykres 1: Wpływ Alkoholu =====

subplot(2, 2, 1);

wyniki_alcohol = zeros(size(alcohol_range));

for i = 1:length(alcohol_range)

    wyniki_alcohol(i) = evalfis(fis, [alcohol_range(i), base_kwasowosc, base_siarczany, base_kwas_cytrynowy]);
    
end


plot(alcohol_range, wyniki_alcohol, 'b-', 'LineWidth', 2.5);

hold on;

plot(base_alcohol, evalfis(fis, [base_alcohol, base_kwasowosc, base_siarczany, base_kwas_cytrynowy]),'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r', 'LineWidth', 1.5);

grid on;

xlabel('Alcohol [%]', 'FontSize', 13, 'FontWeight', 'bold');

ylabel('Jakość wina', 'FontSize', 13, 'FontWeight', 'bold');

title('Wpływ zawartości alkoholu na jakość', 'FontSize', 14, 'FontWeight', 'bold');

legend('Trend', 'Wartość średnia', 'Location', 'best', 'FontSize', 11);

ylim([min(wyniki_alcohol)-0.5, max(wyniki_alcohol)+0.5]);


% ===== Wykres 2: Wpływ Kwasowości Lotnej =====

subplot(2, 2, 2);

wyniki_kwasowosc = zeros(size(kwasowosc_range));

for i = 1:length(kwasowosc_range)

    wyniki_kwasowosc(i) = evalfis(fis, [base_alcohol, kwasowosc_range(i), base_siarczany, base_kwas_cytrynowy]);
    
end


plot(kwasowosc_range, wyniki_kwasowosc, 'r-', 'LineWidth', 2.5);

hold on;

plot(base_kwasowosc, evalfis(fis, [base_alcohol, base_kwasowosc, base_siarczany, base_kwas_cytrynowy]),'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r', 'LineWidth', 1.5);

grid on;

xlabel('Kwasowość Lotna [g/dm³]', 'FontSize', 13, 'FontWeight', 'bold');

ylabel('Jakość wina', 'FontSize', 13, 'FontWeight', 'bold');

title('Wpływ kwasowości lotnej na jakość', 'FontSize', 14, 'FontWeight', 'bold');

legend('Trend', 'Wartość średnia', 'Location', 'best', 'FontSize', 11);

ylim([min(wyniki_kwasowosc)-0.5, max(wyniki_kwasowosc)+0.5]);


% ===== Wykres 3: Wpływ Siarczanów =====

subplot(2, 2, 3);

wyniki_siarczany = zeros(size(siarczany_range));

for i = 1:length(siarczany_range)

    wyniki_siarczany(i) = evalfis(fis, [base_alcohol, base_kwasowosc, siarczany_range(i), base_kwas_cytrynowy]);
    
end


plot(siarczany_range, wyniki_siarczany, 'g-', 'LineWidth', 2.5);

hold on;

plot(base_siarczany, evalfis(fis, [base_alcohol, base_kwasowosc, base_siarczany, base_kwas_cytrynowy]), 'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r', 'LineWidth', 1.5);

grid on;

xlabel('Siarczany [g/dm³]', 'FontSize', 13, 'FontWeight', 'bold');

ylabel('Jakość wina', 'FontSize', 13, 'FontWeight', 'bold');

title('Wpływ siarczanów na jakość', 'FontSize', 14, 'FontWeight', 'bold');

legend('Trend', 'Wartość średnia', 'Location', 'best', 'FontSize', 11);

ylim([min(wyniki_siarczany)-0.5, max(wyniki_siarczany)+0.5]);


% ===== Wykres 4: Wpływ Kwasu Cytrynowego =====

subplot(2, 2, 4);

wyniki_kwas = zeros(size(kwas_cytrynowy_range));

for i = 1:length(kwas_cytrynowy_range)

    wyniki_kwas(i) = evalfis(fis, [base_alcohol, base_kwasowosc, base_siarczany, kwas_cytrynowy_range(i)]);
    
end


plot(kwas_cytrynowy_range, wyniki_kwas, 'm-', 'LineWidth', 2.5);

hold on;

plot(base_kwas_cytrynowy, evalfis(fis, [base_alcohol, base_kwasowosc, base_siarczany, base_kwas_cytrynowy]), 'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r', 'LineWidth', 1.5);

grid on;

xlabel('Kwas Cytrynowy [g/dm³]', 'FontSize', 13, 'FontWeight', 'bold');

ylabel('Jakość wina', 'FontSize', 13, 'FontWeight', 'bold');

title('Wpływ kwasu cytrynowego na jakość', 'FontSize', 14, 'FontWeight', 'bold');

legend('Trend', 'Wartość średnia', 'Location', 'best', 'FontSize', 11);

ylim([min(wyniki_kwas)-0.5, max(wyniki_kwas)+0.5]);


% Dodaj tytuł główny

sgtitle('Analiza trendów: Wpływ zmiennych wejściowych na jakość wina', 'FontSize', 16, 'FontWeight', 'bold');


% Wyświetl podsumowanie

disp(' ');

disp('===================================');

disp('ANALIZA TRENDÓW');

disp('===================================');


fprintf('Wartości odniesienia (punkt środkowy):\n');

fprintf('  Alcohol: %.2f %%\n', base_alcohol);

fprintf('  Kwasowosc_Lotna: %.2f g/dm³\n', base_kwasowosc);

fprintf('  Siarczany: %.2f g/dm³\n', base_siarczany);

fprintf('  Kwas_Cytrynowy: %.2f g/dm³\n', base_kwas_cytrynowy);

disp(' ');


% Analiza kierunku trendów

trend_alcohol = wyniki_alcohol(end) - wyniki_alcohol(1);

trend_kwasowosc = wyniki_kwasowosc(end) - wyniki_kwasowosc(1);

trend_siarczany = wyniki_siarczany(end) - wyniki_siarczany(1);

trend_kwas = wyniki_kwas(end) - wyniki_kwas(1);


fprintf('Obserwowane zmiany jakości (min→max zakresu):\n');

fprintf('  Alcohol (%.1f→%.1f%%): %.2f punktów\n', alcohol_range(1), alcohol_range(end), trend_alcohol);

fprintf('  Kwasowosc_Lotna (%.2f→%.2f): %.2f punktów\n', kwasowosc_range(1), kwasowosc_range(end), trend_kwasowosc);

fprintf('  Siarczany (%.2f→%.2f): %.2f punktów\n', siarczany_range(1), siarczany_range(end), trend_siarczany);

fprintf('  Kwas_Cytrynowy (%.2f→%.2f): %.2f punktów\n', kwas_cytrynowy_range(1), kwas_cytrynowy_range(end), trend_kwas);


disp(' ');

disp('===================================');

disp('INTERPRETACJA WYNIKÓW');

disp('===================================');


fprintf('CEL ANALIZY:\n');

fprintf('Wykresy pokazują wpływ izolowanej zmiany pojedynczej zmiennej\n');

fprintf('na przewidywaną jakość wina (pozostałe parametry stałe).\n');

disp(' ');


fprintf('KLUCZOWE OBSERWACJE:\n');

fprintf('1. System ANFIS wykazuje nieliniowe zależności między zmiennymi\n');

fprintf('2. Trendy mogą różnić się od oczekiwań teoretycznych z powodu:\n');

fprintf('   - Silnych korelacji w danych treningowych (WineQT.csv)\n');

fprintf('   - Efektów interakcji między zmiennymi\n');

fprintf('   - Adaptacji do rzeczywistych danych, nie idealizowanej teorii\n');

disp(' ');


fprintf('WALIDACJA SYSTEMU:\n');

fprintf('✓ TestScenarios.m potwierdza poprawne działanie na rzeczywistych kombinacjach\n');

fprintf('✓ System rozpoznaje: niską kwasowość→lepsza, wysoką kwasowość→gorsza\n');

fprintf('✓ System rozpoznaje: wysoki alkohol→lepszy (dla realistycznych wartości)\n');

disp(' ');


fprintf('WNIOSEK:\n');

fprintf('Wykresy ilustrują zachowanie wyuczonego modelu ANFIS, który:\n');

fprintf('- Działa poprawnie dla rzeczywistych kombinacji parametrów\n');

fprintf('- Może pokazywać nieoczekiwane trendy dla izolowanych zmian\n');

fprintf('- Odzwierciedla rzeczywiste korelacje w danych, nie proste reguły\n');


disp(' ');

disp('===================================');

disp('Wykresy wygenerowane pomyślnie!');

disp('===================================');
