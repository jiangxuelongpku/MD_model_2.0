function [M, t, p, T, B] = ShowProbabilityDistributionVRM(V, Vbark, A, HK, DHK, T, B, show_intermediate_steps)

[M, t, p, T, B] = LoadProbabilityDistributionVRM(V, Vbark, A, HK, DHK, T, B);



if show_intermediate_steps ==0
    p = p(end,:);
end

PlotProbabilityDistribution(p)
xlabel('pinsite');
ylabel('probability')