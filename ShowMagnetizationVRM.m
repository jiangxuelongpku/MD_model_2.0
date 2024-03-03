function ShowMagnetizationVRM(V, Vbark, A, HK, DHK, T, B, show_intermediate_steps)

[M, t, p, T, B] = LoadProbabilityDistributionVRM(V, Vbark, A, HK, DHK, T, B);

if show_intermediate_steps ==0
    t = t(end);
    M = M(end);
end

PlotMagnetization(M, t)
xlabel('time(s)');
ylabel('remeant magnetization(A/m)')