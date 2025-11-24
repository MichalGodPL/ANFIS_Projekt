import pandas as pd

# Nazwy kolumn które zostały zachowane w PlikWynikowy.txt

column_names = ['alcohol', 'volatile acidity', 'sulphates', 'citric acid', 'quality']


# Wczytaj dane z pliku (bez nagłówków)

df = pd.read_csv('DatWynik.dat', sep='\t', header=None, names=column_names)


# Wypisz zakresy dla każdej zmiennej

print("Zakresy zmiennych:\n")

for column in df.columns:

    min_val = df[column].min()

    max_val = df[column].max()
    
    print(f"{column}: {min_val} - {max_val}")
