import pandas as pd

import numpy as np

from sklearn.preprocessing import MinMaxScaler


# Wczytaj dane z PlikWynikowy.txt (już przefiltrowane przez Converter.py)

column_names = ['Temperature_C', 'Humidity_%', 'Occupancy_Count', 'External_Temperature_C', 'Fuzzy_Adjustment_Factor']

df = pd.read_csv('PlikWynikowy.txt', sep=' ', header=None, names=column_names)


# Kolumny wejściowe i wyjściowe

input_columns = ['Temperature_C', 'Humidity_%', 'Occupancy_Count', 'External_Temperature_C']

output_column = 'Fuzzy_Adjustment_Factor'

# 1. SMOOTHING - wygładzanie danych rolling average (okno 5 próbek)

print("Stosowanie wygładzania danych...")

for col in input_columns + [output_column]:

    df[col] = df[col].rolling(window=5, min_periods=1).mean()


# 2. DODANIE OPÓŹNIEŃ (LAGS) - HVAC reaguje z opóźnieniem

print("Dodawanie opóźnień czasowych...")

lag_steps = [1, 2, 3]  # opóźnienia o 1, 2, 3 kroki czasowe (10, 20, 30 minut)


for col in input_columns:

    for lag in lag_steps:

        df[f'{col}_lag{lag}'] = df[col].shift(lag)


# Usuń wiersze z NaN po dodaniu lagów

df = df.dropna()


# 3. NORMALIZACJA - skalowanie do zakresu [0, 1]

print("Normalizacja danych...")

scaler_input = MinMaxScaler()

scaler_output = MinMaxScaler()


# Przygotuj kolumny wejściowe (oryginalne + lagi)

all_input_columns = input_columns.copy()

for col in input_columns:

    for lag in lag_steps:

        all_input_columns.append(f'{col}_lag{lag}')


# Skaluj dane

df[all_input_columns] = scaler_input.fit_transform(df[all_input_columns])

df[[output_column]] = scaler_output.fit_transform(df[[output_column]])


# Przygotuj finalne dane - tylko wybrane kolumny

final_columns = all_input_columns + [output_column]

df_final = df[final_columns]


# Zapisz do pliku TXT bez nagłówków
df_final.to_csv('Wynik.txt', sep=' ', index=False, header=False)


print(f"\n✓ Plik został utworzony!")

print(f"✓ Liczba wierszy: {len(df_final)}")

print(f"✓ Liczba kolumn wejściowych: {len(all_input_columns)}")

print(f"✓ Kolumny: {all_input_columns}")

print(f"\n✓ Dane wygładzone (rolling average)")

print(f"✓ Dodano opóźnienia: {lag_steps} kroków czasowych")

print(f"✓ Dane znormalizowane do zakresu [0, 1]")


# Zapisz scalery do późniejszego użycia

import pickle

with open('scaler_input.pkl', 'wb') as f:

    pickle.dump(scaler_input, f)

with open('scaler_output.pkl', 'wb') as f:

    pickle.dump(scaler_output, f)

print(f"\n✓ Scalery zapisane do plików (scaler_input.pkl, scaler_output.pkl)")

print(f"✓ Możesz ich użyć do denormalizacji wyników ANFIS")