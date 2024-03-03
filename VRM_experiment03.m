% VRM experiment for cubic sample
p = 1/50*ones(1,50);
T = 20;
B = 5e-5;

V = 1e-18;
A = 1e-12;

Vbark = logspace(log10(5e-9^3), log10(100e-9^3),50);
HK = 5e-3;
DHK = 0;
time = 1e14;
intermediate_steps = 1;
for i = 1:50
    [M,t,P] = AcquireVRM(p,V,Vbark(i),A,HK,T,B,time,DHK,intermediate_steps);
    file = [P t M];
    filename = GetFilename(V, Vbark(i), A, HK, DHK);
    outputname = ['constant-coercivity/VRM/50uT_20C/' filename ];
    save(outputname,'file','-ascii')
end