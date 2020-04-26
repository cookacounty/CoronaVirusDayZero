classdef PatientProbs
    methods (Static)
        function dist = norm_dist(ary)
            %% Array [mu sigma]
            dist = normrnd(ary(1),ary(2));
        end
        
        
        function [total, sel] = roll_dice_tf(chance,Nroll)
            % Chance - probability of getting true
            % Nroll - Number of times to roll
            val = [true false];
            r = rand(Nroll,1) < chance;
            sel = val(2 - r); % use as index into VAL
            total = sum(sel);
        end
        
        function dist = flat_dist(per)
            dist = rand < per;
        end
    end
end