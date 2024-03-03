% TRM experiment for cubic sample
p = 1/50*ones(1,50);
Tstart = 560;
Tend = 20;
B = 5e-5;

V = 1e-18;
A = 1e-12;

Vbark = logspace(log10(5e-9^3), log10(100e-9^3),50);
HK = 3e-3;
DHK = 0;
time = 1000;
intermediate_steps = 1;
for i = 1:50
    [M,t,P,T] = AcquireTRM(p,V,Vbark(i),A,HK,Tstart,Tend, B,time,DHK,intermediate_steps);
    file = [P t M];
    filename = GetFilename(V, Vbark(i), A, HK, DHK);
    outputname = ['constant-coercivity/TRM/50uT_580C_20C_1000s/' filename ];
    save(outputname,'file','-ascii')
end