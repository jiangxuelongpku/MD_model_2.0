function [M,t,p,T] = AcquireTRM(p,V,Vbark,A,HK,Tstart,Tend, B,time,DHK,intermediate_steps)
% Calculate the pinn site probability distribution after temperature change
% from fromT to toT.(Uniform cooling)
np = length(p);
if isscalar(DHK)
    DHK = -DHK + 2*DHK * rand(1, np-2);
end

TT = linspace(Tstart,Tend,10*min(50,1+ceil(abs(Tstart-Tend)/5)));
P1 = p;

if intermediate_steps == true 
    M = zeros(length(TT),1);
    t = zeros(length(TT),1);
    p = zeros(length(TT),length(p));
    T = TT;
  
    for n = 1:length(TT)
        [VRM,~,pVRM] = AcquireVRM(P1,V,Vbark,A,HK,TT(n),B,time./length(TT),DHK,false);
        P1 = pVRM;
        M(n) = VRM;
        t(n) = n*time./length(TT);
        p(n,:) = pVRM;
    end
else
    for n = 1:length(TT)
        [VRM,~,pVRM] = AcquireVRM(P1,V,Vbark,A,HK,TT(n),B,time./length(TT),DHK,false);
        P1 = pVRM;
    end
    p = P1;
    M = VRM;
    t = time;
    T = Tend;
end
