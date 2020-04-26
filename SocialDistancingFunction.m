%% Creation of the Social Distancing Time Waveform

socialDistancing = [repdays(1,30) repdays(0.25,30) repdays(0.5,30) repdays(1,300)]
    

function days=repdays(state,num)
days = repmat(state,1,num)
end