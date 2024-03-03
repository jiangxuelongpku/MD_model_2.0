% Thellier experiment 03
% change HK to 7e-3
p = 1/50*ones(1,50);
Tstart = 560;
Tend = 20;
B = 5e-5;

V = 1e-18;
A = 1e-12;

T0 = 30;
Tsteps = [50,100,150,200,250,300,350,400,450,500,550];
t_heat = 1e3;
t_hold = 1e3;
t_cool = 1e3;

Vbark = logspace(log10(5e-9^3), log10(100e-9^3),50);
HK = 7e-3;
DHK = 0;
time = 1000;


parfor i = 1:50
    [~,~,p1,~] = AcquireTRM(p,V,Vbark(i),A,HK,Tstart,Tend,B,time,DHK,0);
    [M,t,P,~,~] = Thellier(p1,V,Vbark(i),A,HK,T0,Tsteps,B,t_heat,t_hold,t_cool,DHK);    
    % Store results in the temporary variable
    results{i} = [P,t,M];
end

for i = 1:50
    filename = GetFilename(V, Vbark(i), A, HK, DHK);
    result = results{1,i};
    outputname = ['constant-coercivity/Coe/10step_seq/50uTnrm50uTlab/' filename];
    save(outputname, 'result', '-ascii');
end


