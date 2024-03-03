function PlotAria_multivbarkparticle(V, A, HK, DHK, Bnrm, Blab,Tsteps,coercivity_type,steps,aging_time)

Vbark = logspace(log10(5e-9^3), log10(100e-9^3),50);

M_nrm = zeros(length(Tsteps),1);
M_ptrm = zeros(length(Tsteps),1);
for i = 1:50
    [M, t, p] = LoadProbabilityDistributionCoe(V, Vbark(i), A, HK, DHK, Bnrm, Blab,coercivity_type,steps,aging_time);
    M_nrm = M_nrm+M(1:2:end);
    M_ptrm = M_ptrm+M(2:2:end);
end
    
x = 1/50*(M_ptrm-M_nrm);
y = 1/50*M_nrm;

scatter(x,y);
hold on;
plot(x,y);
for i = 1:length(Tsteps)
    text(x(i), y(i), [num2str(Tsteps(i)) '℃'], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
xlabel('pTRM gain(A/m)', 'FontSize', 12, 'FontWeight', 'bold', 'FontName', 'Arial');
ylabel('NRM remain(A/m)', 'FontSize', 12, 'FontWeight', 'bold', 'FontName', 'Arial');