import pandas as pd

# Wczytaj plik CSV

df = pd.read_csv('HVAC_Dynamic_Fuzzy_PID_2017_with_Target.csv')


# Kolumny do pominięcia

columns_to_remove = ['Timestamp','CO2_ppm','Kp','Ki','Kd','ISA_Optimization_Score','HVAC_Power_Consumption_kWh','Cooling_Heating_Output_C','Response_Time_s','Energy_Efficiency_%','User_Comfort_Index','HVAC_Efficiency_Class']


# Usuń niepotrzebne kolumny

df_filtered = df.drop(columns=columns_to_remove)


# Zapisz do pliku TXT bez nagłówków

df_filtered.to_csv('PlikWynikowy.txt', sep=' ', index=False, header=False)


print(f"Plik został utworzony! Liczba wierszy: {len(df_filtered)}")

print(f"Zachowane kolumny: {list(df_filtered.columns)}")