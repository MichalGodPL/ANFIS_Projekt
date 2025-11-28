% Wczytaj wytrenowany system FIS

fis = readfis('MocnaProba.fis');


% Wyświetl informacje o systemie

disp('===================================');

disp('WIZUALIZACJA SYSTEMU FIS');

disp('===================================');

disp(['Liczba wejść: ', num2str(length(fis.Inputs))]);

for i = 1:length(fis.Inputs)

    disp('  Wejście ' + string(i) + ': ' + string(fis.Inputs(i).Name));

end

disp(['Liczba wyjść: ', num2str(length(fis.Outputs))]);

disp(['Wyjście: ', fis.Outputs(1).Name]);

disp(['Liczba reguł: ', num2str(length(fis.Rules))]);


% Wyświetl reguły

disp(' ');

disp('===================================');

disp('REGUŁY SYSTEMU FIS');

disp('===================================');

showrule(fis);


% Wizualizacja funkcji przynależności dla wszystkich wejść

disp(' ');

disp('===================================');

disp('WIZUALIZACJA FUNKCJI PRZYNALEŻNOŚCI');

disp('===================================');

figure('Name', 'Funkcje przynależności wejść', 'Position', [100 100 1200 800]);

for i = 1:length(fis.Inputs)

    subplot(2, 2, i);

    plotmf(fis, 'input', i);

    title(['Wejście ', num2str(i), ': ', fis.Inputs(i).Name]);

    grid on;

end


% Generuj powierzchnie 3D dla różnych par wejść

disp(' ');

disp('===================================');

disp('WIZUALIZACJA POWIERZCHNI 3D');

disp('===================================');

num_inputs = length(fis.Inputs);

input_names = cell(1, num_inputs);

for i = 1:num_inputs

    input_names{i} = fis.Inputs(i).Name;

end


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

        zlabel(fis.Outputs(1).Name);

        colorbar;

        grid on;

        view(45, 30);

        rotate3d on;  % Włącz swobodną rotację 3D
        
        disp('  Wygenerowano powierzchnię ' + string(pair_count) + ': ' + string(input_names{i}) + ' vs ' + string(input_names{j}));

    end

end


disp(' ');

disp('===================================');

disp('WIZUALIZACJA ZAKOŃCZONA');

disp('===================================');

disp('Liczba funkcji przynależności: 1 wykres');

disp('Liczba powierzchni 3D: ' + string(pair_count) + ' wykresów');

disp('Wszystkie wykresy gotowe do analizy!');