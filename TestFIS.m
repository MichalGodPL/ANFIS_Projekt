% Wczytaj wytrenowany system FIS

fis = readfis('MocnaProba.fis');


% Wyświetl informacje o systemie

disp('===================================');

disp('INFORMACJE O SYSTEMIE FIS');

disp('===================================');

disp(['Liczba wejść: ', num2str(length(fis.Inputs))]);

for i = 1:length(fis.Inputs)

    disp(['  Wejście ', num2str(i), ': ', fis.Inputs(i).Name]);

end

disp(['Liczba wyjść: ', num2str(length(fis.Outputs))]);

disp(['Liczba reguł: ', num2str(length(fis.Rules))]);


% Wyświetl reguły

disp(' ');

disp('===================================');

disp('REGUŁY SYSTEMU FIS');

disp('===================================');

showrule(fis);


% Wizualizacja funkcji przynależności dla wszystkich wejść

figure('Name', 'Funkcje przynależności wejść', 'Position', [100 100 1200 800]);

for i = 1:length(fis.Inputs)

    subplot(2, 2, i);

    plotmf(fis, 'input', i);

    title(['Wejście ', num2str(i), ': ', fis.Inputs(i).Name]);

    grid on;

end


% Generuj powierzchnie 3D dla różnych par wejść

num_inputs = length(fis.Inputs);

input_names = cell(1, num_inputs);

for i = 1:num_inputs

    input_names{i} = fis.Inputs(i).Name;

end


% Wczytaj dane do określenia zakresów

data = readmatrix('GotowyDatWynik.dat', 'FileType', 'text');


% Powierzchnie 3D - wszystkie kombinacje par wejść

pair_count = 0;

for i = 1:num_inputs-1

    for j = i+1:num_inputs

        pair_count = pair_count + 1;
        
        figure('Name', sprintf('Powierzchnia 3D: %s vs %s', input_names{i}, input_names{j}));
        
        % Generuj powierzchnię dla wybranej pary (output index = 1)

        gensurf(fis, [i j], 1);

        title(sprintf('Powierzchnia FIS: %s vs %s', input_names{i}, input_names{j}));

        xlabel(input_names{i});

        ylabel(input_names{j});

        zlabel('Quality');

        % zlim([1 10]);  % Ustaw zakres osi Z od 1 do 10


        colorbar;

        grid on;

        view(45, 30);

        rotate3d on;  % Włącz swobodną rotację 3D

    end

end


% Testuj system na danych treningowych

disp(' ');

disp('===================================');

disp('TESTOWANIE SYSTEMU FIS');

disp('===================================');


inputs = data(:, 1:end-1);

expected_output = data(:, end);

predicted_output = zeros(size(expected_output));


for i = 1:size(inputs, 1)

    raw_output = evalfis(fis, inputs(i, :));

    % Ograniczenie do zakresu 1-10

    predicted_output(i) = min(max(raw_output, 1), 10);

end


% Oblicz błędy

errors = predicted_output - expected_output;

mae = mean(abs(errors));

rmse = sqrt(mean(errors.^2));


disp(['Liczba testowanych próbek: ', num2str(length(predicted_output))]);

disp(['MAE (Mean Absolute Error): ', num2str(mae)]);

disp(['RMSE (Root Mean Square Error): ', num2str(rmse)]);


% Wyświetl przykładowe predykcje

disp(' ');

disp('Przykładowe predykcje (pierwsze 10):');

disp('Oczekiwane | Predykcja | Błąd');

disp('-----------|-----------|------');

for i = 1:min(10, length(predicted_output))

    fprintf('%10.2f | %9.2f | %5.2f\n', expected_output(i), predicted_output(i), errors(i));

end


% Wizualizacja porównania predykcji

figure('Name', 'Porównanie predykcji', 'Position', [100 100 1200 600]);

subplot(2,2,1);

plot(expected_output, 'b-', 'LineWidth', 1.5);

hold on;

plot(predicted_output, 'r--', 'LineWidth', 1.5);

hold off;

legend('Oczekiwane', 'Predykcja');

xlabel('Numer próbki');

ylabel('Quality');

title('Porównanie wartości oczekiwanych i predykcji');

grid on;


subplot(2,2,2);

histogram(errors, 30);

xlabel('Błąd predykcji');

ylabel('Liczba próbek');

title(['Rozkład błędów (MAE: ', num2str(mae, '%.4f'), ')']);

grid on;


subplot(2,2,3);

scatter(expected_output, predicted_output, 20, 'filled', 'MarkerFaceAlpha', 0.6);

hold on;

plot([min(expected_output) max(expected_output)], [min(expected_output) max(expected_output)], 'r--', 'LineWidth', 2);

hold off;

xlabel('Wartość oczekiwana');

ylabel('Predykcja');

title('Scatter plot: Predykcja vs Oczekiwana');

grid on;

axis equal;


subplot(2,2,4);

plot(errors, 'LineWidth', 1.5);

xlabel('Numer próbki');

ylabel('Błąd');

title('Błędy predykcji w kolejności próbek');

grid on;

yline(0, 'r--', 'LineWidth', 1.5);


disp(' ');

disp('===================================');

disp('GOTOWE!');

disp('===================================');