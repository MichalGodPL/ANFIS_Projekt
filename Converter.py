import pandas as pd

# Wczytaj plik CSV

df = pd.read_csv('WineQT.csv')


# Kolumny do zachowania

columns_to_keep = ['alcohol', 'volatile acidity', 'sulphates', 'citric acid', 'total sulfur dioxide', 'quality']


# Zachowaj tylko wybrane kolumny

df_filtered = df[columns_to_keep]


# Zapisz do pliku TXT bez nagłówków

df_filtered.to_csv('PlikWynikowy.txt', sep=' ', index=False, header=False)


print(f"Plik został utworzony! Liczba wierszy: {len(df_filtered)}")

print(f"Zachowane kolumny: {list(df_filtered.columns)}")