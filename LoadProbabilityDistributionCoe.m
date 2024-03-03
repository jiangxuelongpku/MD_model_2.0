function [M, t, p] = LoadProbabilityDistributionCoe(V, Vbark, A, HK, DHK, Bnrm, Blab,coercivity_type,steps,aging_time)
filename = GetFilename(V, Vbark, A, HK, DHK);
data = load([coercivity_type '/Coe/' num2str(steps) 'step_seq/' num2str(Bnrm*10^6) 'uTnrm' ...
    num2str(Blab*10^6) 'uTlab' aging_time 'yr/' filename]);

M = data(:,end);
t = data(:,end-1);
p = data(:,1:end-2);
