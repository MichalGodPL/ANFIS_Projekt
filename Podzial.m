% Wczytaj dane

data = readmatrix('GotowyDatWynik.dat', 'FileType', 'text');


% Tasowanie z ustalonym seedem dla powtarzalności

rng(42);

data = data(randperm(size(data, 1)), :);


% Podział danych: 70% trening, 15% walidacja, 15% test

n = size(data, 1);

trainData = data(1:round(0.7*n), :);

valData = data(round(0.7*n)+1:round(0.85*n), :);

testData = data(round(0.85*n)+1:end, :);


% Zapisz podzielone dane

writematrix(trainData, 'TrainData.dat', 'Delimiter', '\t', 'FileType', 'text');

writematrix(valData, 'ValData.dat', 'Delimiter', '\t', 'FileType', 'text');

writematrix(testData, 'TestData.dat', 'Delimiter', '\t', 'FileType', 'text');


% Wyświetl informacje

fprintf('Całkowita liczba próbek: %d\n', n);

fprintf('Dane treningowe: %d próbek (%.1f%%)\n', size(trainData,1), 100*size(trainData,1)/n);

fprintf('Dane walidacyjne: %d próbek (%.1f%%)\n', size(valData,1), 100*size(valData,1)/n);

fprintf('Dane testowe: %d próbek (%.1f%%)\n', size(testData,1), 100*size(testData,1)/n);

fprintf('\nZapisano pliki:\n- TrainData.dat\n- ValData.dat\n- TestData.dat\n');