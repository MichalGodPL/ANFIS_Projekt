import pandas as pd

# Wczytaj plik CSV

df = pd.read_csv('WineQT.csv')


# Kolumny do zachowania (quality MUSI być ostatnie jako OUTPUT)

columns_to_keep = ['alcohol', 'volatile acidity', 'sulphates', 'citric acid', 'density', 'quality']


# Zachowaj tylko wybrane kolumny

df_filtered = df[columns_to_keep]


# Zapisz do pliku .dat z tabulacją jako separator (MATLAB preferuje TAB)

df_filtered.to_csv('DatWynik.dat', sep='\t', index=False, header=False, float_format='%.6f')


print(f"Plik został utworzony! Liczba wierszy: {len(df_filtered)}")

print(f"Zachowane kolumny: {list(df_filtered.columns)}")

print(f"Ostatnia kolumna (OUTPUT dla ANFIS): {df_filtered.columns[-1]}")

print(f"\nUżyto separatora: TAB")