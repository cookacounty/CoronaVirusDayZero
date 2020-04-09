%% This file defines the probablity distrubutions

global num;
num = 1000;


prob.asymptomatic = 0.20;

prob.diagnose = 0.50; % Chance someone with  symptoms is diagnosed
prob.diagnose_asymptomatic = 0.01; % Chance someone with no symptoms is diagnosed

prob.gain_immunity = flat_dist(0.25); % Gain immunity after recovery

prob.fatality = 0.01; % Instead of recover the patient will perish

% Normal Gaussean Distributions [mean,sigma]
normal.symptom_time = [7 3] ; % Time to develope symptoms (if not asymptomatic
normal.infection_time = [14 4]; % Time the infection will last

% Normal Gaussen Distrubtions for interaction (each day). 
% These match the EnumQuarintine enumerated types
normal.interaction.None = [20 2];
normal.interaction.SociallyDistanced = [2 1];
normal.interaction.Medical = [0.5 0.2];
normal.interaction.Full = [0 0];

% Probablity of infection if interacted with
prob.infection_chance = 0.01;

% Percent of the population that is infected at the start
% TODO, full startup control of each Patient
clear startCond
startCond(1,:) = flat_dist(0.001); % probInfecStart
startCond(2,:) = flat_dist(0.30); % Innate Immunity




function dist = norm_dist(mu,sigma)
global num;
dist = normrnd(mu,sigma,num,1);
end

function dist = flat_dist(per)
global num;
dist = rand(num,1) < per;
end