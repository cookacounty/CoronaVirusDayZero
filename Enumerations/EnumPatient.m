classdef EnumPatient < Simulink.IntEnumType
	enumeration
		Healthy(0)
		Carrier(1)
		Deceased(2)
        Immune(4)
	end
	methods (Static = true)
		function retVal = getDefaultValue()
			retVal = EnumPatient.Healthy;
        end
	end
end