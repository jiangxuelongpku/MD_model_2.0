function plotK_distribution(Kl,Kr,data_pramiter)

x = 1:length(Kl);
% 使用plot函数画折线图
h1 = semilogy(x, Kl, '-o');
hold on;
h2 = semilogy(x, Kr, '-o');

legend('jump rates to the left', 'jump rates to the right');

% 添加标题和标签
title(data_pramiter);
xlabel('pinn site');
ylabel('jump rates to the left and right');
