import pandas as pd

# Wczytaj plik CSV

df = pd.read_csv('WineQT.csv')


# Usuń kolumnę Id

df = df.drop(columns=['Id'])

# Oblicz korelację wszystkich kolumn z quality

print("=== KORELACJE Z QUALITY ===\n")

correlations = df.corr()['quality'].sort_values(ascending=False)

print(correlations)

print("\n" + "="*60 + "\n")


# Wyświetl szczegółowo (z formatowaniem)

print("Szczegółowe korelacje:\n")

for column, corr_value in correlations.items():

    if column != 'quality':

        print(f"{column:30s}: {corr_value:8.6f}")