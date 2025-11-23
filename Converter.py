import pandas as pd

# Wczytaj plik CSV

df = pd.read_csv('HVAC_Dynamic_Fuzzy_PID_2017_with_Target.csv')


# Kolumny do pominięcia

columns_to_remove = ['Timestamp','HVAC_Efficiency_Class','ISA_Optimization_Score','User_Comfort_Index','Energy_Efficiency_%','Response_Time_s','HVAC_Power_Consumption_kWh','Kp','Ki','Kd']


# Usuń niepotrzebne kolumny

df_filtered = df.drop(columns=columns_to_remove)


# Zapisz do pliku TXT bez nagłówków

df_filtered.to_csv('PlikWynikowy.txt', sep=' ', index=False, header=False)


print(f"Plik został utworzony! Liczba wierszy: {len(df_filtered)}")

print(f"Zachowane kolumny: {list(df_filtered.columns)}")