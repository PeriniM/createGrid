%% Import the CSV and create a cell variable for the shape
clear
clc
addpath('shapes_csv\');
T = readtable('path2.csv', 'ReadVariableNames',false, 'Delimiter',',', 'HeaderLines',1, 'TreatAsEmpty',{'NA','na'});
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

x_scale = [0 1];
y_scale = [0 1];

for j = 1:width(shape)
    for i = 1:height(shape)
        if j == width(shape)
            % [A, B] --> [a, b] --> (val - A)*(b-a)/(B-A) + a
            shape{i,j} = (shape{i,j} - y_min)*(y_scale(2)-y_scale(1))/(y_max-y_min) + y_scale(1);
        else
            shape{i,j} = (shape{i,j} - x_min)*(x_scale(2)-x_scale(1))/(x_max-x_min) + x_scale(1);
        end
    end
end

%% plot normalized shape
figure(1)
hold on
for i = 1:height(shape)
    %reconnect to initial point
    plot([shape{i,1}(1,:) shape{i,1}(1,1)], [shape{i,2}(1,:) shape{i,2}(1,1)])
%     h=text(mean(shape{i,1}), mean(shape{i,2}), {num2str(i)});
%     set(h,'color','r')
end
daspect([1 1 1])
grid on
grid minor
hold off

%% Points definition for WMR

pos_xy = [shape{1,1}(1,:); shape{1,2}(1,:)]; % initial position

figure(1), hold on, grid on
plot(pos_xy(1,:),pos_xy(2,:),'r*')

%Choice best limits for plotting
axis equal
AXIS=axis;
magAxisXY=1.1;
AxisFrameXY=(max(pos_xy(1,:))-min(pos_xy(1,:)))*(magAxisXY-1);
axis([min(pos_xy(1,:))-AxisFrameXY max(pos_xy(1,:))+AxisFrameXY AXIS(3)-AxisFrameXY AXIS(4)+AxisFrameXY])
%Plot labels and title
xlabel('x [m]') 
ylabel('y [m]')
point_labels = cellstr( num2str([1:numel(pos_xy)/2]') );  
text(pos_xy(1,:), pos_xy(2,:), point_labels, 'VerticalAlignment','bottom', 'HorizontalAlignment','right')
title('Points to be reached by the WMR')

%% Points interpolation with linear time

% Trajectory generation (Path-> nonlinear geometry + time linear in time)
% =====================================================
%
% One would rather to connect a set of positions occupied by the WMR in 
% the X,Y cartesian space considering different strategies for
% guaranteering different level of path "smoothing" between points.
%
%   (0, 0), (0.5, 2), (2, -2), (3.5, 2), (4, 0)
%
%     1         2        3         4       5
%
% For example it might be required to connect points 123 and 345 with a
% cubic interpolator.


Ts=0.1; %Sampling time -> t =  Ts x iteration + t0


t = [0:1:length(pos_xy)-1]
x = [pos_xy(1,:)]
y = [pos_xy(2,:)]



%PLAY WITH THIS SETTINGS
%npoints=3; %  <==== Link between this two values !!! npoints > Norder
npoints=max(size(t)); %  <==== Link between this two values !!! npoints > Norder
%Norder=1;  %  <====
%Norder=3:  %  <====
Norder=npoints; % <====

y2 = [];
x2 = [];
t2 = [];

npoints_tmax=length(t);

for iterposition=1+npoints:npoints:npoints_tmax
  t2t = [t(iterposition-npoints):Ts:t(iterposition)];
  x2 = [x2 polyval(polyfit(t(iterposition-npoints:iterposition),x(iterposition-npoints:iterposition),Norder),t2t)];
  y2 = [y2 polyval(polyfit(t(iterposition-npoints:iterposition),y(iterposition-npoints:iterposition),Norder),t2t)];
  t2 = [t2 t2t];
end
endingpoints=mod(npoints_tmax-1,npoints);
if endingpoints>0, 
  if npoints>1, npoints=endingpoints;
    Norder=npoints;
    t2t = [t(end-npoints):Ts:t(end)];
    x2 = [x2 polyval(polyfit(t(end-npoints:end),x(end-npoints:end),Norder),t2t)];
    y2 = [y2 polyval(polyfit(t(end-npoints:end),y(end-npoints:end),Norder),t2t)];
    t2 = [t2 t2t];
  else
    npoints=1;
    t2t = t(end-1):Ts:t(end);
    x2 = [x2 polyval(polyfit(t(end-1:end),x(end-1:end),Norder),t2t)];
    y2 = [y2 polyval(polyfit(t(end-1:end),y(end-1:end),Norder),t2t)];
    t2 = [t2 t2t];
  end
end

figure(2)
hold on, grid on
label_x2y2=plot(x,y,'o',x2,y2,'g')

xlabel('x [m]')
ylabel('y [m]')
axis equal
daspect([1 1 1])

title(['Path Interpolation'])

%% animation unicycle on interpolated path

% calculate the angle theta from the velocity
theta = atan2(diff(y2), diff(x2));
theta = [theta(1) theta];

% Create a triangle
% x_uni = [0 1 0.5 0]*0.1;
% y_uni = [0 0 1 0]*0.1;
% unicycle = fill(x_uni, y_uni, 'r');

unicycle = line('XData', x2(1), 'YData', y2(1), 'Marker', 'o', 'Color', 'r');

% Find the center of the unicycle
% xc = mean(x_uni);
% yc = mean(y_uni);

% Animate the unicycle along the path
for i = 2:length(x2)
    
%     % Compute the rotation matrix from theta
%     R = [cos(theta(i)) -sin(theta(i)); sin(theta(i)) cos(theta(i))];
%     
%     % Rotate the triangle around its center of mass
%     xy_rotated = R * [x_uni - xc; y_uni - yc];
%     
%     % Compute the offset between the original and rotated center of mass
%     offset = [x2(i); y2(i)] - R * [xc; yc];
%     
%     % Compute the distance from the center of mass to the tip of the triangle
%     d = norm([x_uni(1); y_uni(1)] - [xc; yc]);
%     
%     % Shift the rotated triangle so that its tip is at the current point on the trajectory
%     tip_offset = [x2(i); y2(i)] - R * [xc; yc] - d * R(:,1);
%     
%     % Update the position and orientation of the triangle
%     set(unicycle, 'XData', xy_rotated(1,:) + xc + tip_offset(1), 'YData', xy_rotated(2,:) + yc + tip_offset(2));
%     
    % Update the position and orientation of the unicycle
    set(unicycle, 'XData', x2(i), 'YData', y2(i), 'Marker', 'o', 'Color', 'r', 'LineStyle', '-');
    set(unicycle, 'Marker', 'o', 'Color', 'r', 'LineStyle', '-');
    %comment drawnow if you have performance issues
    drawnow;
    pause((t2t(i)-t2t(i-1))/100);
    exportgraphics(gcf,'testAnimated.gif','Append',true);
end

hold off;

%% create a polygon shape

% pgon = polyshape([-1 1 0]*0.05,[0 0 3]*0.05);
% plot(pgon)

%% MatLab: spline tutorial (Part2)
% Extraction of vel. and acc. from a path/trajectory
% Impose Ps/Pe, vel and acc. 
%
%


vx2 = [0 diff(x2)]; 
vy2 = [0 diff(y2)]; 
ax2 = [0 diff(vx2)]; 
ay2 = [0 diff(vy2)]; 

figure

subplot(1,3,1), hold on, grid on
plot(t,x,'m*')
plot(t,y,'c*')
label_t2x2=plot(t2,x2,'co',t2,x2,'r');
label_t2y2=plot(t2,y2,'mo',t2,y2,'b');
legend([label_t2y2(2) label_t2x2(2)],'y(t)','x(t)')
title('Plot of y(t) and x(t)')
%title('Plot of Data (Points) and Model (Line)')
xlabel('t [s]')
ylabel('s [m]')

%title('Plot of y(t) and x(t)')
subplot(1,3,2), hold on, grid on
plot(t2,vx2,'m*')
plot(t2,vx2,'c*')
label_t2x2=plot(t2,vx2,'co',t2,vx2,'r');
label_t2y2=plot(t2,vy2,'mo',t2,vy2,'b');
legend([label_t2y2(2) label_t2x2(2)],'Vy(t)','Vx(t)')
title('Etraction of V_x and V_y from (x,y)')
xlabel('t [s]')
ylabel('v [m/s]')

%title('Plot of y(t) and x(t)')
subplot(1,3,3), hold on, grid on
plot(t2,ax2,'m*')
plot(t2,ax2,'c*')
label_t2x2=plot(t2,ax2,'co',t2,ax2,'r');
label_t2y2=plot(t2,ay2,'mo',t2,ay2,'b');
legend([label_t2y2(2) label_t2x2(2)],'Ay(t)','Ax(t)')
title('Etraction of a_x and a_y from (x,y)')
xlabel('t [s]')
ylabel('a [m/s^2]')
