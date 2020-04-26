function ns = PatientHealth(cs,events,prob,normal)


ns = cs;

%% Health State
switch cs.PatientState
    case "Healthy"
        
        if events.Infected
            ns.PatientState = "Carrier";
            ns.isInfected = true;
            ns.isDiagnosed = false;
            
            % Once infected roll for outcomes
            ns.isAsymptomatic = PatientProbs.flat_dist(prob.asymptomatic);
            ns.isFatal = PatientProbs.flat_dist(prob.fatality);
            ns.tSymptoms = PatientProbs.norm_dist(normal.symptom_time);
            ns.tInfected = PatientProbs.norm_dist(normal.infection_time);
            ns.timerInfected = 0;
        end
    case "Carrier"
        
        % Carrier developes symptoms and is diagnosed
        if ~cs.isAsymptomatic && cs.timerInfected > cs.tSymptoms
            ns.isDiagnosed = PatientProbs.flat_dist(prob.diagnose);
        end
        
        if cs.timerInfected > cs.tInfected
            ns.isInfected = false;
            if cs.isFatal
                ns.PatientState = "Deceased";
                ns.isDeceased = true;
            else
                %Roll for immunity
                GainsImmunity = PatientProbs.flat_dist(prob.gain_immunity);
                if GainsImmunity
                    ns.PatientState = "Immune";
                else
                    ns.PatientState = "Healthy";
                end
                
            end
        end
        
        ns.timerInfected = cs.timerInfected + 1;

    case "Immune"
        ns.isImmune = true;
        
    case "Deceased"
        ns.isInfected = false;
        cs.QuarintineState = "Deceased"; % Force next quaritine state to deceased
    otherwise
        error('Invalid PatientState %s',cs.PatientState)
        
end

%% Quarintine State
switch cs.QuarintineState
    case "None"
        if cs.isInfected && cs.isDiagnosed
            ns.QuarintineState = "Medical";
        end
    case "Medical"
        if ~cs.isInfected
            ns.QuarintineState = "None";
        else
            ns.QuarintineState = "Medical";
        end
    case "Deceased"
        ns.QuarintineState = "Deceased";
    otherwise
        error('Invalid QuarintineState %s',cs.QuarintineState)
end

end

