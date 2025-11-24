import pandas as pd

import numpy as np


# Wczytaj oryginalne dane

column_names = ['alcohol', 'volatile acidity', 'sulphates', 'citric acid', 'quality']

df = pd.read_csv('WstepnyDatWynik.dat', sep='\t', header=None, names=column_names)

print("="*60)

print("ANALIZA ORYGINALNYCH DANYCH")

print("="*60)

print(f"Całkowita liczba próbek: {len(df)}")

print(f"\nRozkład wartości quality:")

print(df['quality'].value_counts().sort_index())


synthetic_data = []

# Quality = 1 (bardzo zła jakość)

# Niski alkohol, wysoka kwasowość lotna, niskie siarczany, niska kwasowość cytrynowa

for _ in range(50):  # Wygeneruj 50 próbek

    synthetic_data.append([

        np.random.uniform(8.0, 9.5),      # alcohol (niski)

        np.random.uniform(1.0, 1.6),      # volatile acidity (wysoki)

        np.random.uniform(0.3, 0.5),      # sulphates (niski)

        np.random.uniform(0.0, 0.1),      # citric acid (niski)

        1                                  # quality

    ])


# Quality = 2 (zła jakość)

for _ in range(50):

    synthetic_data.append([

        np.random.uniform(8.5, 10.0),     # alcohol (niski-średni)

        np.random.uniform(0.9, 1.4),      # volatile acidity (wysoki)

        np.random.uniform(0.35, 0.55),    # sulphates (niski)

        np.random.uniform(0.0, 0.15),     # citric acid (niski)

        2                                  # quality

    ])


# Quality = 9 (bardzo dobra jakość)

# Wysoki alkohol, niska kwasowość lotna, wysokie siarczany, wysoka kwasowość cytrynowa

for _ in range(50):

    synthetic_data.append([

        np.random.uniform(12.5, 14.0),    # alcohol (wysoki)

        np.random.uniform(0.15, 0.35),    # volatile acidity (niski)

        np.random.uniform(0.75, 0.95),    # sulphates (wysoki)

        np.random.uniform(0.4, 0.65),     # citric acid (wysoki)

        9                                  # quality

    ])


# Quality = 10 (doskonała jakość)

for _ in range(50):

    synthetic_data.append([

        np.random.uniform(13.0, 14.5),    # alcohol (bardzo wysoki)

        np.random.uniform(0.1, 0.3),      # volatile acidity (bardzo niski)

        np.random.uniform(0.8, 1.0),      # sulphates (bardzo wysoki)

        np.random.uniform(0.5, 0.7),      # citric acid (wysoki)

        10                                 # quality

    ])


# Utwórz DataFrame z syntetycznymi danymi

df_synthetic = pd.DataFrame(synthetic_data, columns=column_names)


# Połącz oryginalne i syntetyczne dane

df_augmented = pd.concat([df, df_synthetic], ignore_index=True)


# Przetasuj dane

df_augmented = df_augmented.sample(frac=1, random_state=42).reset_index(drop=True)


# Zapisz augmentowane dane

df_augmented.to_csv('GotowyDatWynik.dat', sep='\t', index=False, header=False, float_format='%.6f')

print("\n" + "="*60)

print("WYGENEROWANE SYNTETYCZNE DANE")

print("="*60)

print(f"Dodano {len(df_synthetic)} syntetycznych próbek")

print(f"  - Quality 1:  50 próbek")

print(f"  - Quality 2:  50 próbek")

print(f"  - Quality 9:  50 próbek")

print(f"  - Quality 10: 50 próbek")


print("\n" + "="*60)

print("PODSUMOWANIE")

print("="*60)

print(f"Oryginalna liczba próbek: {len(df)}")

print(f"Liczba próbek po augmentacji: {len(df_augmented)}")

print(f"\nNowy rozkład wartości quality:")

print(df_augmented['quality'].value_counts().sort_index())


print("\n" + "="*60)

print("✓ Zapisano: GotowyDatWynik.dat")

print("="*60)
