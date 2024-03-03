% 创建示例数据
x = linspace(0, 2*pi, 100);  % x轴的取值范围
y = sin(x);  % 曲线的纵坐标

% 定义颜色映射
cmap = jet(length(x));  % 使用 jet 颜色映射，您也可以根据需要选择其他颜色映射

% 绘制一系列曲线
figure;  % 创建一个新的图形窗口
hold on;  % 保持图形窗口上的绘图

for i = 1:length(x)
    color = cmap(i, :);  % 根据颜色映射选择对应的颜色
    plot(x, y+i, 'Color', color);  % 绘制曲线，颜色使用选择的渐变颜色
end

colorbar;  % 添加颜色条，显示颜色映射范围
