%% Normalizacja danych do ANFIS GUI

clc;

% Wczytaj dane

data = load('DatWynik.dat');


fprintf('========================================\n');

fprintf('ORYGINALNE ZAKRESY DANYCH:\n');

fprintf('========================================\n');

fprintf('Alcohol:              %.2f - %.2f\n', min(data(:,1)), max(data(:,1)));

fprintf('Volatile Acidity:     %.3f - %.3f\n', min(data(:,2)), max(data(:,2)));

fprintf('Sulphates:            %.2f - %.2f\n', min(data(:,3)), max(data(:,3)));

fprintf('Citric Acid:          %.2f - %.2f\n', min(data(:,4)), max(data(:,4)));

fprintf('Total Sulfur Dioxide: %.1f - %.1f\n', min(data(:,5)), max(data(:,5)));

fprintf('Quality (OUTPUT):     %.1f - %.1f\n', min(data(:,6)), max(data(:,6)));

fprintf('========================================\n\n');


% Zapisz parametry (do późniejszej denormalizacji)

dataMin = min(data, [], 1);

dataMax = max(data, [], 1);


% NORMALIZACJA do [0, 1]

dataNorm = (data - dataMin) ./ (dataMax - dataMin);


fprintf('PO NORMALIZACJI:\n');

fprintf('Min wartość: %.4f\n', min(dataNorm(:)));

fprintf('Max wartość: %.4f\n\n', max(dataNorm(:)));


% Zapisz znormalizowane dane

writematrix(dataNorm, 'ZnormalizowanyWynik.dat', 'Delimiter', '\t');


% Zapisz parametry denormalizacji

save('ParametryDenormalizacji.mat', 'dataMin', 'dataMax');


fprintf('✓ Zapisano: ZnormalizowanyWynik.dat\n');

fprintf('✓ Zapisano: ParametryDenormalizacji.mat (parametry do denormalizacji)\n\n');

%% ============================================
%% FUNKCJA DENORMALIZACJI (użyj po treningu)
%% ============================================
% 
% % Wczytaj parametry
% load('denorm_params.mat');
% 
% % Twoje przewidywania z ANFIS (znormalizowane)
% predicted_norm = [...];  % Wyniki z ANFIS
% 
% % DENORMALIZACJA
% predicted_real = predicted_norm .* (dataMax(6) - dataMin(6)) + dataMin(6);
% 
% fprintf('Denormalizowane przewidywania:\n');
% disp(predicted_real);
