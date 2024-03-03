function [M, t, p, T, B] = LoadProbabilityDistributionVRM(V, Vbark, A, HK, DHK, T, B)
filename = GetFilename(V, Vbark, A, HK, DHK);

data = load(['constant-coercivity/VRM/' num2str(B*10^6) 'uT_' num2str(T) 'C/' filename]);

M = data(:,end);
t = data(:,end-1);
p = data(:,1:end-2);
T = T;
B = B;