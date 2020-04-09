function busname = struct2bus(mystruct)
% https://www.mathworks.com/help/simulink/ug/using-structure-parameters.html

obj_name = inputname(1);
prefix = ['bus_' obj_name];

evalin('base','clear slBus*');

% Convert the original struct to a bus
busObj = Simulink.Bus.createObject(mystruct);
top_name = busObj.busName;

% Find all slBus variables in workspace, convert to a cell
cellBus = Simulink.Bus.objectToCell(arrayfun(@(s) s.name, whos('slBus*'),'UniformOutput',false));

% Find and replace slBus* with the correct prefix
cellBus = cellIter(cellBus,prefix,true,top_name); % Top level cell
cellBus = cellIter(cellBus,prefix,false,top_name); % Subblocks

% Cleanup
evalin('base',['clear slBus* ' prefix '*']);

% Create final bus
Simulink.Bus.cellToObject(cellBus);

end

% Cell iteration function to find and replace prefix
function cellBus = cellIter(cellBus,prefix,is_top,top_name)

for idx1 = 1:length(cellBus)
    for idx2 = 1:length(cellBus{idx1})
        if iscell(cellBus{idx1}{idx2})
            
            % Elements
            for idx3 = 1:length(cellBus{idx1}{idx2})
                for idx4 = 1:length(cellBus{idx1}{idx2}{idx3})
                    cd4 = cellBus{idx1}{idx2}{idx3}{idx4};
                    if isstr(cd4)
                        cellBus{idx1}{idx2}{idx3}{idx4} = replace_prefix(cd4,prefix,false);
                    end
                end
            end
        else
            % Names
            if is_top
                if strcmp(cellBus{idx1}{idx2},top_name)
                    cellBus{idx1}{idx2} = replace_prefix(cellBus{idx1}{idx2},prefix,is_top) ;
                end
            else
                cellBus{idx1}{idx2} = replace_prefix(cellBus{idx1}{idx2},prefix,is_top) ;
            end
        end
    end
end

end

% Find and replace slBus
function str = replace_prefix(str,prefix,is_top)
if is_top
    str = regexprep(str,'slBus\d*',prefix);
else
    str = regexprep(str,'slBus',prefix);
end
end



% SAving this, used to be the old struct to bus
% function old_struct2bus()
% 
% obj_name = inputname(1);
% bus_name = ['bus_' obj_name];
% evalin('base','clear slBus*');
% a = Simulink.Bus.createObject(mystruct);
% evalin('base',['clear ' bus_name]);
% evalin('base', [bus_name ' = ' a.busName ';']);
% % evalin('base','clear slBus1');
% 
% fprintf('Creating bus %s for input %s\n',bus_name,obj_name);
% end

