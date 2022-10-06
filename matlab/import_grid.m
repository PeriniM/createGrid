%% takes the elements and plot them on a grid
clear
clc
T = readtable('createGrid().csv');

hold on
for i = 1:height(T)
    x = str2num(string(T{i,"x_vert"}));
    y = str2num(string(T{i,"y_vert"}));
    plot([x, x(1)],[y, y(1)])
    %patch(x,y,'g')
end
axis ij
grid on
grid minor
hold off