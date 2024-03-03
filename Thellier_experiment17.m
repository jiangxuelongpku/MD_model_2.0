% Thellier experiment 17
%  HK is 3e-3，
% time for stay on earth to 1B year.
% DHK is 2e-4
% Blab = Banc = 5e-5;
% more Tsteps
p = 1/50*ones(1,50);
Tstart = 560;
Tend = 20;
Blab = 5e-5;
Banc = 5e-5;

V = 1e-18;
A = 1e-12;

T0 = 30;
Tsteps = [50,100,150,200,250,300,350,400,425,450,475,500,520,525,530,535,540,545,550,555];
t_heat = 1e3;
t_hold = 1e3;
t_cool = 1e3;

Vbark = logspace(log10(5e-9^3), log10(100e-9^3),50);
HK = 3e-3;
DHK = 2e-4;
time = 1000;
timeforstay = 365*24*3600*1e6;

parfor i = 1:50
    [~,~,p1,~] = AcquireTRM(p,V,Vbark(i),A,HK,Tstart,Tend,Banc,time,DHK,0);
    [~,~,p2] = AcquireVRM(p1,V,Vbark(i),A,HK,Tend,Banc,timeforstay,DHK,0);
    [M,t,P,~,~] = Thellier(p2,V,Vbark(i),A,HK,T0,Tsteps,Blab,t_heat,t_hold,t_cool,DHK);    
    % Store results in the temporary variable
    results{i} = [P,t,M];
end

for i = 1:50
    filename = GetFilename(V, Vbark(i), A, HK, DHK);
    result = results{1,i};
    outputname = ['varying-coercivity/Coe/20step_seq/50uTnrm50uTlab1e9yr/' filename];
    save(outputname, 'result', '-ascii');
end