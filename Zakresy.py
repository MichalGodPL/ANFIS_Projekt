import pandas as pd

# Nazwy kolumn które zostały zachowane w PlikWynikowy.txt

column_names = ['Temperature_C', 'Humidity_%', 'CO2_ppm', 'Occupancy_Count', 'External_Temperature_C', 'Fuzzy_Adjustment_Factor']


# Wczytaj dane z pliku (bez nagłówków)

df = pd.read_csv('PlikWynikowy.txt', sep=' ', header=None, names=column_names)


# Wypisz zakresy dla każdej zmiennej

print("Zakresy zmiennych:\n")

for column in df.columns:

    min_val = df[column].min()

    max_val = df[column].max()
    
    print(f"{column}: {min_val} - {max_val}")
