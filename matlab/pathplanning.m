%% Import the CSV and create a cell variable for the shape
clear
clc
addpath('shapes_csv\');
T = readtable('path1.csv', 'ReadVariableNames',false, 'Delimiter',',', 'HeaderLines',1, 'TreatAsEmpty',{'NA','na'});
shape = cell(height(T),2);
x_max = -1e5;
y_max = -1e5;
x_min = 1e5;
y_min = 1e5;

%build the shape into a cell variable
for i = 1:height(T)

    x = str2num(string(T{i,2:3:end}));
    y = str2num(string(T{i,3:3:end}))*-1;
    % plot([x, x(1)],[y, y(1)])
    shape{i,1} = x;
    shape{i,2} = y;

    % takes min and max of both axes for normalization
    if x_max<max(x)
        x_max = max(x);
    end
    if y_max<max(y)
        y_max = max(y);
    end
    if x_min>min(x)
        x_min = min(x);
    end
    if y_min>min(y)
        y_min = min(y);
    end
end

%% normalize coordinates from 0 to 1 in both axes (square)
for j = 1:width(shape)
    for i = 1:height(shape)
        if j == width(shape)
            % [A, B] --> [a, b] --> (val - A)*(b-a)/(B-A) + a
            shape{i,j} = (shape{i,j} - y_min)/(y_max-y_min);
        else
            shape{i,j} = (shape{i,j} - x_min)/(x_max-x_min);
        end
    end
end

%% plot normalized shape
figure(1)
hold on
for i = 1:height(shape)
    %reconnect to initial point
    plot([shape{i,1}(1,:) shape{i,1}(1,1)], [shape{i,2}(1,:) shape{i,2}(1,1)])
    h=text(mean(shape{i,1}), mean(shape{i,2}), {num2str(i)});
    set(h,'color','r')
end
daspect([1 1 1])
grid on
grid minor
hold off