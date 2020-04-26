ProbabilityDistributions;
SocialDistancingFunction;

tsim = 180;

clear events PatientStates stats ev

for p = 1:num
    PatientStates(p) = initial_state;
    if initCond.infected(p)
        cs = PatientStates(p);
        ev.Infected = true;
        PatientStates(p)  = PatientHealth(cs,ev,prob,normal);
    end
end

startInfec = sum(arrayfun(@(p) p.isInfected, PatientStates)); 
fprintf('Starting with %d Infections\n',startInfec); 

%%

tidxs = 1:tsim;
for tidx = tidxs
    % trigger events

    socialFactor = socialDistancing(tidx); % The days level of distancing
    
    ps = struct2table(PatientStates);  
    [events,stats(tidx)] = PatientEvents(ps, prob, normal, socialFactor);

    for p = 1:num
        cs = PatientStates(p);
        ev = events(p);
        PatientStates(p) = PatientHealth(cs,ev,prob,normal);
    end
   if mod(tidx,10) == 1
      fprintf('Sim Time %d Infections %d\n',tidx,stats(tidx).numInfected); 
   end
end


error('Done')

%% Analysis
stats_t = struct2table(stats);
figure; 
subplot(4,2,1); plot(tidxs,stats_t.numInfected); legend('Infected')
subplot(4,2,3); plot(tidxs,stats_t.numMedical); legend('Hospitalizations')
subplot(4,2,5); plot(tidxs,socialDistancing(1:tsim)); legend('Social Distancing Inverse Effort')
subplot(4,2,7); plot(tidxs(2:end),stats_t.numInfected(2:end)-stats_t.numInfected(1:(end-1))); legend('Infected rate/day');


subplot(4,2,2); plot(tidxs,stats_t.numImmune); legend('Immune')
subplot(4,2,4); plot(tidxs,stats_t.numDeceased); legend('Deceased')

%%


function s = initial_state()
s.PatientState = "Healthy";
s.QuarintineState = "None";

s.isDeceased = false;
s.isImmune = false;
s.isInfected = false;
s.isAsymptomatic = false;
s.isDiagnosed = false;
s.isFatal = false;

s.tSymptoms = 0;
s.tInfected = 0;

s.timerInfected = 0;
end