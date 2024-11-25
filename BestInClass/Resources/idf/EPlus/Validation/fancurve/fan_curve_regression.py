import pandas as pd
import numpy as np
from numpy.polynomial.polynomial import Polynomial
from sklearn.metrics import r2_score, mean_squared_error
import matplotlib.pyplot as plt

# Load data from CSV
df = pd.read_csv('fan.csv')

# Convert 'Time' column to datetime format (assuming it's in Unix timestamp format in seconds)
df['Time'] = pd.to_datetime(df['Time'], unit='s')

# Set 'Time' as the index
df.set_index('Time', inplace=True)

# Resample data to 15-minute intervals and take the mean
df_resampled = df.resample('15T').mean()

# Filter out rows where P is smaller than 1 after resampling
df_resampled = df_resampled[df_resampled['AHU.fanSup.P'] >= 100]

# Define the rated values
nominal_m_flow = 1.2* 6.35
rated_P = 1402 * nominal_m_flow / 0.49


# Calculate normalized columns
df_resampled['nominal_P'] = df_resampled['AHU.fanSup.P'] / rated_P
df_resampled['nominal_m_flow'] = df_resampled['AHU.fanSup.m_flow'] / nominal_m_flow

# Fit a 4th order polynomial
x = df_resampled['nominal_m_flow']
y = df_resampled['nominal_P']

# Fit the polynomial
coefs = np.polyfit(x, y, 3)

# Ensure sum of coefficients is 1 by normalizing
coefs /= coefs.sum()

# Create polynomial model
poly_model = Polynomial(coefs[::-1])  # reverse order for Polynomial class

# Predict using the polynomial model for plotting range 0 to 1 in steps of 0.1
x_range = np.arange(0, 1.1, 0.1)
y_range_pred = poly_model(x_range)

# Calculate R²
r2 = r2_score(y, poly_model(x))

# Calculate RMSE
rmse = mean_squared_error(y, poly_model(x), squared=False)

# Calculate CVRMSE
cvrmse = rmse / y.mean() * 100

# Print results
print("Normalized Coefficients:", coefs)
print("Polynomial Model:", poly_model)
print("R²:", r2)
print("CVRMSE (%):", cvrmse)

# Plotting Measured vs. Predicted
plt.figure(figsize=(10, 6))
plt.scatter(x, y, label="Measured", color='blue', s=10)
plt.plot(x_range, y_range_pred, label="Predicted (4th order polynomial)", color='red', linewidth=2)
plt.xlabel("Normalized Mass Flow (nominal_m_flow)")
plt.ylabel("Normalized Power (nominal_P)")
plt.title("Measured vs. Predicted Fan Power")
plt.legend()
plt.grid(True)
plt.show()