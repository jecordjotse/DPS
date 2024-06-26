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

# Steady State Solve - MATLAB Live Script for Power Network Analysis

This Live Script explains the functionality of the MATLAB function `solving_sys_rect3`, which is used for solving systems of equations representing power networks with multiple buses using rectangular coordinates. [Link to solving_sys_rect3.m]([https://raw.githubusercontent.com/username/repository/branch/path/to/solving_sys_rect3.mlx](https://raw.githubusercontent.com/jecordjotse/DPS/main/solving_sys_rect3.m))

## Function Explanation
The `solving_sys_rect3` function is designed to efficiently solve a system of equations for power networks. It handles both known and unknown parameters, including voltage magnitudes, injected currents, and bus angles, allowing for the determination of their values within the network. The function utilizes rectangular coordinates for calculations.

## Input Parameters
- `x`: Matrix of unknown variables representing voltage magnitude, injected current, and bus angle for each bus.
- `ybusFunc`: Function handle for generating the admittance matrix.
- `v`: Known voltage magnitudes at each bus.
- `i`: Known injected currents at each bus.
- `load`: Known load at each bus.
- `R`: Resistance matrix representing connections between buses.
- `n`: Number of buses.
- `ang_`: Known bus angles.
- `B`: Reactance of the transmission line.
- `w`: Angular frequency.

## Functionality
1. Initializes vectors for voltage (`V`), current (`I`), and bus angle (`ang`).
2. Assigns values to these variables based on their known or unknown status for each bus.
3. Calls the `ybusFunc` function to generate the admittance matrix (`Ybus`) based on the provided parameters.
4. Calculates the magnitude of each element in `Ybus` to create the matrix `Ybusm`.
5. Computes the solution vector `X` by solving the equation \([Y_{\text{busm}} \cdot V - I]\) and returns the result along with additional calculations.

## Conclusion
The `solving_sys_rect3` function is a versatile tool for power network analysis, enabling the efficient solution of systems of equations for complex networks. Its ability to handle both known and unknown parameters makes it valuable for determining critical network parameters and ensuring network stability and operation.

# gen bus DAE - Simulink ODE Function

## Description
The `gen bus DAE` function computes the derivatives of angular velocities (`dw_dot`), injected currents (`i_inj`), bus voltages (`vbus`), angular positions (`ang`), and angular velocities (`w`) in a power system with multiple buses and loads. [Link to Simulink File](https://github.com/jecordjotse/DPS/raw/main/nbus_dyna_angle_change_II.slx)

## Inputs
- `theta`: Vector containing the angular positions of each bus.
- `dw`: Vector containing the angular velocities of each bus.
- `v`: Vector containing the voltages of each bus.
- `load_`: Vector containing the loads at each bus.
- `J`: Moment of inertia of the system.
- `Tm`: Torque applied to each bus.
- `B`: Damping coefficient.
- `R`: Resistance of the system.
- `bus_number`: Number of buses in the system.
- `wref`: Reference angular velocity.

## Outputs
- `dw_dot`: Derivatives of angular velocities.
- `i_inj`: Injected currents.
- `vbus`: Bus voltages.
- `w`: Angular velocities.
- `ang`: Angular positions.

## Algorithm
1. Initialize variables and parameters.
2. Calculate initial guesses for the solver.
3. Solve the system of equations using `fsolve`.
4. Extract the computed values of `i_inj`, `vbus`, and `ang`.
5. Calculate the derivatives of angular velocities (`dw_dot`) based on the solved values and physical parameters.
