function PlotAria_singleparticle(V,Vbark,A, HK, DHK, Bnrm, Blab,Tsteps,coercivity_type,steps,aging_time)

[M, t, p] = LoadProbabilityDistributionCoe(V, Vbark, A, HK, DHK, Bnrm, Blab,coercivity_type,steps,aging_time);
M_nrm = M(1:2:end);
M_ptrm = M(2:2:end);

x = M_ptrm-M_nrm;
y = M_nrm;

scatter(x,y);
hold on;
plot(x,y);
for i = 1:length(Tsteps)
    text(x(i), y(i), [num2str(Tsteps(i)) '℃'], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
xlabel('pTRM gain(A/m)', 'FontSize', 12, 'FontWeight', 'bold', 'FontName', 'Arial');
ylabel('NRM remain(A/m)', 'FontSize', 12, 'FontWeight', 'bold', 'FontName', 'Arial');