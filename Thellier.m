function [M,t,p,T,B] = Thellier(p,V,Vbark,A,HK,T0,Tsteps,B,t_heat,t_hold,t_cool,DHK)
np = length(p);
if isscalar(DHK)
    DHK = -DHK + 2*DHK * rand(1, np-2);
end

T = Tsteps;
t_measure = 30;
P1_out = zeros(length(T),np);
P2_out = zeros(length(T),np);
P2 = p;
NRM = zeros(1,length(T));
pTRM = zeros(1,length(T));
for n = 1:length(T) 
    % Heat up
    [~,~,P1,~] = AcquireTRM(P2,V,Vbark,A,HK,T0,T(n),0,t_heat,DHK,0);
    % Hold 
    [~,~,P1] = AcquireVRM(P1,V,Vbark,A,HK,T(n),0,t_hold,DHK,0);
    % Cool down
    [~,~,P1,~] = AcquireTRM(P1,V,Vbark,A,HK,T(n),T0,0,t_cool,DHK,0);
    % Put the sample into zero-field
    [M1,~,P1] = AcquireVRM(P1,V,Vbark,A,HK,T0,0,t_measure,DHK,0);
    P1_out(n,:) = P1;
    NRM(n) = M1;
    
    % Heat up
    [~,~,P2,~] = AcquireTRM(P1,V,Vbark,A,HK,T0,T(n),B,t_heat,DHK,0);
    % Hold 
    [~,~,P2] = AcquireVRM(P2,V,Vbark,A,HK,T(n),B,t_hold,DHK,0);
    % Cool down
    [~,~,P2,~] = AcquireTRM(P2,V,Vbark,A,HK,T(n),T0,B,t_cool,DHK,0);
    % Put the sample into zero-field
    [M2,~,P2] = AcquireVRM(P2,V,Vbark,A,HK,T0,0,t_measure,DHK,0);
    P2_out(n,:) = P2; 
    pTRM(n) = M2;
end
M = zeros(2*length(T),1);
M(1:2:end,:) = NRM;
M(2:2:end,:) = pTRM;
t = 1:2*length(T);
t = t*(t_heat+t_hold+t_cool+t_measure);
t = t';
p = zeros(2*length(T),length(p));
p(1:2:end,:) = P1_out;
p(2:2:end,:) = P2_out;
end