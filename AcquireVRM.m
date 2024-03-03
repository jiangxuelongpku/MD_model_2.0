function [M,t,p] = AcquireVRM(p,V,Vbark,A,HK,T,B,time,DHK,intermediate_steps)
% this simulate a Rectangular particle with two domains.
%p is the Initial distribution of pinsite probability.including the boundary
%V is the volume of the particle,the unite is m3
%Vbark is the Barkhausen volume,the unite is m3
%A is the area that parallel to the domain wall,the unite is m2
%HK is the microscopic coercivity at room temperature,the unite is T
%T is the temperature of environment,the unite is dgree c
%B is the applied field, the unite is T
%DHK is the pinenergy energy barrier between pinsite.
loop_num = 1e4; %loop_num is the number of loop time to prevent endless circulation.
TC = 853.15;%Tc is the Curie temperature.853.15 K for magnetite.
N = 0.14; %N is the demagnetizing factor of domain structure. 0.127 for two domain particle
u0 = 4*pi*10^-7;% permeability of Vacuum in SI unit
kB = 1.380649*10^-23;% Boltzmann constant
tao0 = 1*10^-9;%interval between successive thermal excitations
%Ms is the spontaneous magnetization at room temperature,
%this is the value for magnetite for room temaperature the unite is A/m.
Ms0 =1000*480;
% number_of_pin_site is the number of pin_site
np = length(p); 
T = T+273.15; %convert the unite to K
H = 1e4*(4*pi)^-1*1000*B;% applied field,convert the unite to A/m
HK = 1e4*(4*pi)^-1*1000*HK;%corcivity at 290K,convert the unite to A/m
DHK = 1e4*(4*pi)^-1*1000*DHK;
%An empirical constant
gama = 0.43;
Ms = Ms0*(TC-T)^gama*(TC-30)^-gama;
HK = HK*(TC-T)^gama*(TC-30)^-gama;
DHK = DHK*(TC-T)^gama*(TC-30)^-gama;
% don't calculate the part higher than curie temperature to avoid bugs and save resource.
if T > TC
    T = TC;
end
if isscalar(DHK)
    DHK = -DHK + 2*DHK * rand(1, np-2);
end
%Location of pin site,They are evenly distributed around the central of the particle
% X is the distance the pin site to the central of the particle.
X = (linspace(1,np-2,np-2)-(np-1)/2)*Vbark/A;

x_boundary = 0.5*V/A+X(1);% the distance between grain boundary and clost pinnsite
VB = x_boundary*A;

M = 2*Ms*A*X/V; %net magnetization of the grain
M_holeparticle = [-Ms,M,Ms];

% Kl and Kr are the rate at which jumps occur to the left and to the right respectively.
% dEl and dEr are the magnetism energy barrier the domain jump to the left
% and  right respectively
dEl = (u0*Vbark*Ms*(H-N*M+(HK+DHK)));
dEr = (u0*Vbark*Ms*(N*M-H+(HK+DHK)));
Kl = 1/tao0*exp(dEl/(-kB*T));
Kr = 1/tao0*exp(dEr/(-kB*T));

% if the energy of grain boundary is not that biger than that of inside.
dElB = (u0*VB*Ms*(H-N*(Ms)+HK));
dErB = (u0*VB*Ms*(N*(-Ms)-H+HK));
KlB = 1/tao0*exp(dElB/(-kB*T));
KrB = 1/tao0*exp(dErB/(-kB*T));

dElx = (u0*VB*Ms*(H-N*M(1)+HK));
dErx = (u0*VB*Ms*(N*M(end)-H+HK));
Klx = 1/tao0*exp(dElx/(-kB*T));
Krx = 1/tao0*exp(dErx/(-kB*T));

if KlB<1e5*Kl(end) && KrB<1e5*Kr(1)
    Kl(1) = Klx;
    Kr(end) =  Krx;
    Kl = [0,Kl,KlB];
    Kr = [KrB,Kr,0];% DW can not jump out of the grain.
else
    Kl(1) = 0;
    Kr(end) = 0;
    Kl = [0,Kl,1e10*Kl(end)];
    Kr = [1e10*Kr(1),Kr,0];
end

%creat the matrix to save the calculate result. the row represent result every loop.
%P_matrix,dt_list and sumM are the distribution of pinsite probability,time cost and magnetism every step. 
P_matrix = zeros(loop_num,length(p));
dt_list = zeros(loop_num,1);
sumM = zeros(loop_num,1);
P_matrix(1,:) = p;
dt_list(1) = 0;
sumM(1) = sum(p.*M_holeparticle);

%creat the loop for claculating pinsite probability every step.
Sumt = 0;
P1 = p; 
for i =1:loop_num
    jumpout = -P1.*(Kl+Kr);
    Pl = [P1(2:end),0];
    Pr = [0,P1(1:end-1)];
    Kll = [Kl(2:end),0];
    Krr = [0,Kr(1:end-1)];
    jumpin = Pl.*Kll+Pr.*Krr;   
    dP_dt = jumpin+jumpout; % dP/dt
    % the block follow used to get the proper dt . dP = dt*dP_dt;P1 = dP+P1;   
    negative_indices = dP_dt < 0;
    ratios = abs(dP_dt(negative_indices)) ./ P1(negative_indices);
    dt = 0.01*min(1./ratios);
    if dt > time
        dt = 0.2*time;
    end
    Sumt = Sumt+dt;
    dP = dt*dP_dt;
    P1 = dP+P1;
    if dP(1)<0 && P1(1)<1e-4*P1(2)
        P1(2) = P1(1)+P1(2);
        P1(1) = 0;
        Kl(2) = 0;
    end
    if dP(end)<0 && P1(end)<1e-4*P1(end-1)
        P1(end-1) = P1(end-1)+P1(end);
        P1(end) = 0;
        Kr(end-1) = 0;
    end
    
    P_matrix(i+1,:) = P1;
    sumM(i+1) = sum(P1.*M_holeparticle);  
    dt_list(i+1) = dt;
    dpmax = max(abs(dP));
    if dt>1E18 %higher than the age of the universe
        break
    end
    if dpmax<10^-12 %Reach steady state
        break
    end
    if Sumt>=time
        break
    end
end

% find where dose the loop break
sum_p = sum(P_matrix,2);
if sum_p(end) ==0
    non_zeroIndex = find(sum_p == 0,1)-1; 
else
    non_zeroIndex = loop_num;
end
P_matrix = P_matrix(1:non_zeroIndex,:);
% calculate cumulative time and magnetization
Sum_t = cumsum(dt_list(1:non_zeroIndex));
sumM = sumM(1:non_zeroIndex,:);

if intermediate_steps == true
    M = sumM;t = Sum_t;p = P_matrix;
else
    if time < Sum_t(1) 
        M = sumM(1);
        p = P_matrix(1,:);
    elseif time>Sum_t(end)
        p = P_matrix(end,:);
        M = sumM(end);
    else
        deltt = time - Sum_t;
        x = find(deltt<=0,1);
        p = P_matrix(x,:);
        M = sumM(x);
    end
    t = time;
end