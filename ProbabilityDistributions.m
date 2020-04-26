%% This file defines the probablity distrubutions

global num;
num = 10000;

prob.asymptomatic = 0.20;

prob.diagnose = 0.50; % Chance someone with symptoms is diagnosed
prob.diagnose_asymptomatic = 0.01; % Chance someone with no symptoms is diagnosed

prob.gain_immunity = 0.2; % Chance to gain immunity after recovery

prob.fatality =  96/1800; % Probability of death after infection

% Normal Gaussean Distributions [mean,sigma]
normal.symptom_time = [7 1.5] ; % Time to develope symptoms (if not asymptomatic
normal.infection_time = [14 1.5]; % Time the infection will last

% Normal Gaussen Distrubtions for interaction (each day). 
% These match the EnumQuarintine enumerated types
normal.interaction.None = [20 3];
normal.interaction.Medical = [0.5 0.2];
normal.interaction.Deceased = [0 0];

% Probablity of infection if interacted with
prob.infection_chance = 0.008;

initCond.infected = flat_dist(0.001); % Starting percent of population infected
initCond.immune   = flat_dist(0.10); % Starting percent of population with Innate Immunity

% Always have at least 5 infected to start
if sum(initCond.infected) == 0
   initCond.infected(1:5) = true; 
end

%% R factor
R_factor = prob.infection_chance * (normal.infection_time(1) * normal.interaction.None(1));
fprintf('R Factor based on probabilities %d\n', R_factor)
%%

function dist = flat_dist(per)
global num;
dist = rand(num,1) < per;
end