# DPS
EE 5802 Directed Study with Dr Weaver

# Ybus Generator - MATLAB Live Script for Power Network Analysis

This Live Script performs power network analysis using MATLAB. [Link to solving_systems_nbus.m](https://raw.githubusercontent.com/jecordjotse/DPS/main/solving_systems_nbus.m)


## Input Parameters
- `x`: Matrix of unknown variables representing voltage magnitude, injected current, and bus angle for each bus.
- `v`: Known voltage magnitudes at each bus.
- `i_`: Known injected currents at each bus.
- `load_`: Known load at each bus.
- `R`: Resistance matrix representing connections between buses.
- `n`: Number of buses.
- `ang_`: Known bus angles.

## Functionality
- Initializes the admittance matrix (`Ybus`) and a matrix for storing the magnitude of the admittance matrix (`Ybusm`).
- Assigns values to voltage, current, and angle variables based on their known or unknown status for each bus.
- Constructs the admittance matrix based on resistance values and load at each bus.
- Modifies diagonal elements to account for load and negates off-diagonal elements.
- Calculates the magnitude of each element in the admittance matrix.
- Returns the solution vector by solving the equation \( Y_{\text{busm}} \cdot V - I \), where \( V \) is the voltage vector and \( I \) is the current vector.

