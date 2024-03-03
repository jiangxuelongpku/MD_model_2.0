function [Kl,Kr] = CalculateK(p,V,Vbark,A,HK,T,B,DHK)
% this simulate a Rectangular particle with two domains.
%p is the Initial distribution of pinsite probability.
%V is the volume of the particle,the unite is m3
%Vbark is the Barkhausen volume,the unite is m3
%A is the area that parallel to the domain wall,the unite is m2
%HK is the microscopic coercivity at room temperature,the unite is T
%T is the temperature of environment,the unite is dgree c
%B is the applied field, the unite is T
%DHK is the pinenergy energy barrier between pinsite.

TC = 850;%Tc is the Curie temperature.853.15 K for magnetite.
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

%An empirical constant
gama = 0.43;
Ms = Ms0*(TC-T)^gama*(TC-30)^-gama;
HK = HK*(TC-T)^gama*(TC-30)^-gama;

% don't calculate the part higher than curie temperature to avoid bugs and save resource.
if T > TC
    T = TC;
end
if isscalar(DHK)
    DHK = -DHK + 2*DHK * rand(1, np+2);
end

%Location of pin site,They are evenly distributed around the central of the particle
% X is the distance the pin site to the central of the particle.
X = (linspace(1,np,np)-(np+1)/2)*Vbark/A;
X = [-0.5*V/A,X,0.5*V/A];
M = 2*Ms*A*X/V; %net magnetization of the grain

% Kl and Kr are the rate at which jumps occur to the left and to the right respectively.
% dEl and dEr are the magnetism energy barrier the domain jump to the left
% and  right respectively
dEl = (u0*Vbark*Ms*(H-N*M+(HK+DHK)));
dEr = (u0*Vbark*Ms*(N*M-H+(HK+DHK)));
Kl = 1/tao0*exp(dEl/(-kB*T));
Kr = 1/tao0*exp(dEr/(-kB*T));

% DW can not jump out of the grain.
Kl(1) = 0;
Kr(end) = 0;
