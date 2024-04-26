%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jerome Cordjotse
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Base Units
Pbase = 500000;
Vbase = 480;
Ibase = 1200;
Rbase = 0.4;
wbase = 188.5;
Tbase = 3060.57;
%%
n=3
J = [50 60  ] ; 
B = 1.26;
Tm = 2122/Tbase; % 7,500 Nm
V = 1; % 480V
load_=[0;500000;300000]
R=[Inf 0.02-0.001i 0.02;0.02 Inf 0.02; 0.02 0.02 Inf]
Load = load_/Pbase; % Load of 13KW
rpu = R/Rbase
%%

% jw' = Tm - 
J = 50 ; % Sample Value 12500 kg.m^2
B = 1.26;
Tm = 2122/Tbase; % 7,500 Nm
V = 1; % 480V
Load = load_/Pbase; % Load of 13KW
R = 0.02;

% First lets use actual values to find torque volts and current at ss
sol =  fsolve(@(x) solving_sys_rect(x,1.26,188.5,400000,480,0.02),[400000/480,480,2000]);
Iss = sol(1);
Vss = sol(2);
Tmss = sol(3);

% First lets use pu values to find torque volts and current at ss
solpu =  fsolve(@(x) solving_sys_rect(x,0.1,1,Load,1,0.02/Rbase),[Load,1,Tm]);
Iss_ = solpu(1);
Vss_ = solpu(2);
Tmss_ = solpu(3);

% Create a table
data = [Iss, Vss, Tmss; Iss_, Vss_, Tmss_];
rowNames = {'sol', 'solpu'};
colNames = {'Iss', 'Vss', 'Tmss'};
T = array2table(data, 'RowNames', rowNames, 'VariableNames', colNames);

% Display the table
disp(T)

IssAct = Iss_ * Ibase;
VssAct = Vss_ * Vbase;
TmssAct = Tmss_ * Tbase;
data = [data; IssAct, VssAct, TmssAct];

rowNames = {'sol', 'solpu', 'solActual'};
colNames = {'Iss', 'Vss', 'Tmss'};
T = array2table(data, 'RowNames', rowNames, 'VariableNames', colNames);

% Display the table
disp(T)
disp("Discrepancy");

% Lets find bus 13000
busVals = fsolve(@(x) solving_systems_bus(x,480,13000,0.02),[13000/480,480], optimoptions('fsolve','Display','off','Algorithm','levenberg-marquardt'))


%% n bus Function
n=3
x=[1 1 1]
load_=[0;400000;300000]
R=[Inf 0.02 0.02;0.02 Inf 0.02; 0.02 0.02 Inf]
 Ybus = zeros(n);
  for i = 1:n
        for j = 1:n
            if i == j
                Ybus(i,j) = Ybus(i,j)+(load_(j)/(x(j)^2));
                for k = 1:n
                    Ybus(i,j) = Ybus(i,j)+(1/R(i,k));
                end
            else
                Ybus(i,j) = Ybus(i,j)+(1/R(i,j));
            end
        end
  end

  for i = 1:n
        for j = 1:n
            if i ~= j  % Check if the element is not on the diagonal
                Ybus(i, j) = -Ybus(i, j);  % Negate the element
            end
        end
  end



 fsolve(@(x)  solving_sys_rect2(x,@solving_systems_nbus,[480 0 0],[-1 0 -1],load_,R,n),[0 479 469;1300 0 1300;2100 0 0])
 solving_sys_rect2([0 479 469;1300 0 1300;2100 0 0],@solving_systems_nbus,[480 0 0],[-1 0 -1],load_,R,n)
 fsolve(@(x)  solving_sys_rect2(x,@systems_nbus,[1 0 0],[-1 0 -1],[0 0.6944 0.5208],rpu,3,0.1,1),[0 0.9 0.8;1.05 0 1.1;0.7 0 0])
 fsolve(@(x)  solving_sys_rect2(x,@systems_nbus,[1 0 1],[-1 0 -1],Load,rpu,2,0.1,1),[0 0.9 0;1.05 0 1.1;0.7 0 0.6])
 fsolve(@(x)  solving_systems_nbus(x,[480 0 0],[-1 0 -1],load_,R,n),[0 479 469;1300 0 1300])
 fsolve(@(x)  solving_systems_nbus(x,[1 0 0],[-1 0 0],[0 0.6944 0.5208],rpu,n),[0 0.9 0.8;1.05 0 1.1])

sol = fsolve(@(x)  solving_sys_rect2(x,@systems_nbus,[480 0 480],[-1 0 -1],load_,R,3,1.25,188.5),[0 479 469;1300 0 1300;2100 0 2100])
 fsolve(@(x)  solving_sys_rect2(x,@systems_nbus,[480 0 0],[-1 0 -1],load_,R,n,1.25,188.5),[0 479 469;1300 0 1300;2100 0 0;0.175 0 0])

 solving_sys_rect2([0 479 469;1300 0 1300;2100 0 0;0.175 0 0],@systems_nbus,[480 0 0],[-1 0 -1],load_,R,n,1.25,188.5)
 
 fsolve(@(x)  solving_sys_rect2(x,@systems_nbus,[480 0 0],[-1 0 -1],load_,R,n,1.25,188.5),[0 479 469;1300 0 1300;2100 0 0;0.175 0 0])

  %%
syms v1 v2 v3
solving_systems_nbus([1 1 1],[0;13000;9000],[Inf 0.02 Inf;0.02 Inf 0.02;Inf 0.02 Inf],3)

x0 = [Load/V,V*Vbase];
fsolve(@(x) solving_systems_bus(x,v),x0);
sol = fsolve(@(x) solving_systems_bus(x,V,Load),x0)

x0 = [0,-0,0,0,0,0,0,0,0];
sol = fsolve(@(x) power_eqn(x,1),x0);


Load = 1.4062;
sol = fsolve(@(x) solving_sys(x,B,377,Load,V),[Load/V,V,377])
Tm = sol(3)
disp("I = ")
disp(sol(1))
disp("V = ")
disp(sol(2))

fsolve(@(x) solving_systems_bus(x,1,1.4062),[1,1],optimoptions('fsolve','Display','off','Algorithm','levenberg-marquardt'))

 Y10 = 0;
    Y12 = 1/0.2;
    Y20 = Load/(480^2);
    Ybus = [Y10+Y12 -Y12;
            -Y12    Y20+Y12]
    V = [x(2);v];
    I = [x(1);0];
    X = Ybus*V-I;


    Ybus = [Y10+Y12 -Y12;
            -Y12    1.4+Y12]


    syms Y10 Y12 Y20
    
    Ybus = [Y10+Y12 -Y12;
            -Y12    Y20+Y12];
    V = [v;x(2)];
    
    I = [x(1);0];
    X = [Ybus*V-I;B*w^2 - w*x(3)+v*x(1)];



R_values = linspace(0, 1, 5000); % Define the range of V values you want to sweep
sol_array = zeros(length(R_values), 3); % Preallocate array to store solutions

for i = 2:length(R_values)
    R = R_values(i); % Set the current value of V
    sol = fsolve(@(x) solving_sys(x, B, 377, Load, V, R), [Load/V, V, 377], optimoptions('fsolve', 'Display', 'off'));
    sol_array(i, :) = sol; % Store the solution
end

yyaxis left
plot(R_values( sol_array(:,1)>0),sol_array(sol_array(:,1)>0,:))
yyaxis right

plot(R_values(sol_array(:,1)>0), (100*((sol_array(sol_array(:,1)>0,3)*377)-Load)./(sol_array(sol_array(:,1)>0,3)*377)),R_values(sol_array(:, 1) > 0),(sol_array(sol_array(:, 1) > 0, 3).^2) .* R_values(sol_array(:, 1) > 0).');
legend("Injected Current","Bus 2 Voltage","Engine Torque","Efficieny","Line Losses %")
xlabel("Line 1-2 Resistance");

%% Adding Angle Change

fsolve(@(x)  solving_systems_nbus(x, [1 1 1], [-1 0 0], [0 0.6944 0.5208], rpu, n, [-1 0 0]), [1 1 1; 1.05 0 0; 0 0.1 0.1])

fsolve(@(x)  solving_systems_nbus(x, [1 1 1], [-1 0 0], Load, rpu, n, [0 -1 -1]), [1 1 1; 1.05 0 0; 0 0.1 0.1])

fsolve(@(x)  solving_sys_rect3(x,@systems_nbus,[480 0 480],[-1 0 0],load_,R,n,1.25,188),[0 479 0;1300 0 1300;2100 0 2100])
 
fsolve(@(x)  solving_sys_rect3(x,@systems_nbus,[1 1 1],[-1 0 0],Load,rpu,n,[-1 0 0],0.1,1),[1 1 1;1.01 0.1 0.1;0.6 0.2 0.2; 0 0.1 0.1])

1.3549224

[1.5423252419    0    00]