import pandas as pd

# Wczytaj plik CSV

df = pd.read_csv('HVAC_Dynamic_Fuzzy_PID_2017_with_Target.csv')


# Kolumny do analizy korelacji z Fuzzy_Adjustment_Factor

columns_for_fuzzy = ['Temperature_C', 'Humidity_%','Occupancy_Count', 'External_Temperature_C', 'Cooling_Heating_Output_C']

# Kolumny do analizy korelacji z Cooling_Heating_Output_C

columns_for_cooling = ['Temperature_C', 'Humidity_%', 'Occupancy_Count', 'External_Temperature_C', 'Fuzzy_Adjustment_Factor']


# Korelacja z Fuzzy_Adjustment_Factor

print("Korelacja z Fuzzy_Adjustment_Factor:\n")

for column in columns_for_fuzzy:

    correlation = df[column].corr(df['Fuzzy_Adjustment_Factor'])

    print(f"{column}: {correlation:.6f}")

print("\n" + "="*50 + "\n")


# Korelacja z Cooling_Heating_Output_C

print("Korelacja z Cooling_Heating_Output_C:\n")

for column in columns_for_cooling:

    correlation = df[column].corr(df['Cooling_Heating_Output_C'])

    print(f"{column}: {correlation:.6f}")