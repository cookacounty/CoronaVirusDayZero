classdef EnumQuarintine < Simulink.IntEnumType
	enumeration
		None(0)
		SociallyDistanced(1)
		Medical(2)
        Full(4)
	end
	methods (Static = true)
		function retVal = getDefaultValue()
			retVal = EnumQuarintine.None;
        end
	end
end