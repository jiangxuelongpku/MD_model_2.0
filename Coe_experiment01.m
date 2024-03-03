% Thellier01
number_of_pin_site = 52;%including the two particle boundary
yr = 3600*24*365.25;
P = zeros(1,number_of_pin_site);
P(1:end) = 1/number_of_pin_site;

T = [100 200 300 400 420 450 460 470 480 490 500 510 520 530 540 550 560 570 580];
V = 1e-18;
Vbark = 1e-22;
A = 1e-12;
HK = 4e-3;
[~,~,P,~] = AcquireTRM(P,V,Vbark,A,HK,580,30,0,1000*yr,0,0);

[~,~,P,~,~] = Thellier(P,V,Vbark,A,HK,30,T,5e-5,1800,1800,1800,0);
filename = GetFilename(V, Vbark, A, HK);

outputname = ['Constant-coercivity\Coe\1step_seq\0uTnrm_50uTlab\' filename];
save(outputname,'P','-ascii')