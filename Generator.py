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

# Losowa liczba próbek dla każdej kategorii quality

num_quality_1 = np.random.randint(10, 41)   # 10-40 próbek

num_quality_2 = np.random.randint(10, 51)   # 10-50 próbek

num_quality_3 = np.random.randint(20, 51)   # 20-50 próbek

num_quality_4 = np.random.randint(20, 51)   # 20-50 próbek

num_quality_8 = np.random.randint(20, 51)   # 20-50 próbek

num_quality_9 = np.random.randint(10, 51)   # 10-50 próbek

num_quality_10 = np.random.randint(10, 41)  # 10-40 próbek


# Quality = 1 (bardzo zła jakość)

# Niski alkohol, wysoka kwasowość lotna, niskie siarczany, niska kwasowość cytrynowa

for _ in range(num_quality_1):

    synthetic_data.append([

        np.random.uniform(8.0, 9.5),      # alcohol (niski)

        np.random.uniform(1.0, 1.6),      # volatile acidity (wysoki)

        np.random.uniform(0.3, 0.5),      # sulphates (niski)

        np.random.uniform(0.0, 0.1),      # citric acid (niski)

        1                                  # quality

    ])


# Quality = 2 (zła jakość)

for _ in range(num_quality_2):

    synthetic_data.append([

        np.random.uniform(8.5, 10.0),     # alcohol (niski-średni)

        np.random.uniform(0.9, 1.4),      # volatile acidity (wysoki)

        np.random.uniform(0.35, 0.55),    # sulphates (niski)

        np.random.uniform(0.0, 0.15),     # citric acid (niski)

        2                                  # quality

    ])


# Quality = 3 (słaba jakość)

for _ in range(num_quality_3):

    synthetic_data.append([

        np.random.uniform(9.0, 10.5),     # alcohol (niski-średni)

        np.random.uniform(0.7, 1.2),      # volatile acidity (średni-wysoki)

        np.random.uniform(0.4, 0.6),      # sulphates (niski-średni)

        np.random.uniform(0.1, 0.25),     # citric acid (niski-średni)

        3                                  # quality

    ])


# Quality = 4 (poniżej średniej jakość)

for _ in range(num_quality_4):

    synthetic_data.append([

        np.random.uniform(9.5, 11.0),     # alcohol (średni)

        np.random.uniform(0.6, 1.0),      # volatile acidity (średni)

        np.random.uniform(0.45, 0.65),    # sulphates (średni)

        np.random.uniform(0.15, 0.3),     # citric acid (średni)

        4                                  # quality

    ])


# Quality = 8 (dobra jakość)

for _ in range(num_quality_8):

    synthetic_data.append([

        np.random.uniform(11.5, 13.0),    # alcohol (wysoki)

        np.random.uniform(0.2, 0.45),     # volatile acidity (niski-średni)

        np.random.uniform(0.65, 0.85),    # sulphates (wysoki)

        np.random.uniform(0.3, 0.5),      # citric acid (średni-wysoki)

        8                                  # quality

    ])


# Quality = 9 (bardzo dobra jakość)

# Wysoki alkohol, niska kwasowość lotna, wysokie siarczany, wysoka kwasowość cytrynowa

for _ in range(num_quality_9):

    synthetic_data.append([

        np.random.uniform(12.5, 14.0),    # alcohol (wysoki)

        np.random.uniform(0.15, 0.35),    # volatile acidity (niski)

        np.random.uniform(0.75, 0.95),    # sulphates (wysoki)

        np.random.uniform(0.4, 0.65),     # citric acid (wysoki)

        9                                  # quality

    ])


# Quality = 10 (doskonała jakość)

for _ in range(num_quality_10):

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

print(f"  - Quality 1:  {num_quality_1} próbek")

print(f"  - Quality 2:  {num_quality_2} próbek")

print(f"  - Quality 3:  {num_quality_3} próbek")

print(f"  - Quality 4:  {num_quality_4} próbek")

print(f"  - Quality 8:  {num_quality_8} próbek")

print(f"  - Quality 9:  {num_quality_9} próbek")

print(f"  - Quality 10: {num_quality_10} próbek")


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
