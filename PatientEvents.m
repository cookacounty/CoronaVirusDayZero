function [patient_events,stats] = PatientEvents(patient_t, prob, normal, socialFactor)


num_patients = height(patient_t);

% Next state initalization
pinit.Infected = false;
pinit.GainsImmunity = false;
patient_events = repmat(pinit,num_patients,1);

% Get the infected patients
p_infected = patient_t(patient_t.isInfected,:);
isInPublic = patient_t.QuarintineState == "None";

stats.numInfected = height(p_infected);
stats.numMedical = sum(patient_t.QuarintineState == "Medical");


boolInfected = false(num_patients,1);

% Roll to infect new patients
for row_idx = 1:height(p_infected)
    
    % Get the quarintine level
    qlvl = p_infected.QuarintineState(row_idx);
    switch qlvl
        case "None";                 interaction_prob = normal.interaction.None * socialFactor;
        case "Deceased";             interaction_prob = normal.interaction.Deceased;
        case "Medical";              interaction_prob = normal.interaction.Medical;
        otherwise
            error('Bad value for QuarintineState %s',qlvel);
    end
    
    interactions = round(PatientProbs.norm_dist(interaction_prob));
    
    new_infections = PatientProbs.roll_dice_tf(prob.infection_chance,interactions);
    
    if new_infections > 0
        % Randomly infect uninfected
        idx_healthy = find(isInPublic == 1); % Find indexes of anyone not medically quarintined
        if length(idx_healthy) > 1 % if there are healthy people to infect
            idx_infect = randsample(idx_healthy,new_infections); % Randomly infect (could be healty or not)
            boolInfected(idx_infect) = true;
        end
    end
    
end

stats.total_new_infections = sum(boolInfected);

for idx = 1:num_patients
    patient_events(idx).Infected = boolInfected(idx);
end

%% Statiscal outputs
stats.numImmune   = height(patient_t(patient_t.isImmune,:));
stats.numDeceased = height(patient_t(patient_t.isDeceased,:));



end
