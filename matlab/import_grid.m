%% takes the elements and plot them on a grid
clear
clc
T = readcell('createGrid().csv');

hold on
for i = 2:height(T)
    x = str2num(string(T(i,2)));
    y = str2num(string(T(i,3)));
    plot([x, x(1)],[y, y(1)])
    %patch(x,y,'g')
end
axis ij
daspect([1 1 1])
grid on
grid minor
hold off