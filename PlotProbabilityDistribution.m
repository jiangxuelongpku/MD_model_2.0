function PlotProbabilityDistribution(p)
[n_t, n_p] = size(p);

cmap = jet(n_t);
figure;
hold on;

for i = 1:n_t
    color = cmap(i, :);
    plot(p(i, :), 'Color', color);
end

colormap(jet); % 设置当前图形的颜色映射为 jet
caxis([1, n_t]); % 设置颜色映射的范围，根据曲线数量

colorbar;
hold off;

    
    