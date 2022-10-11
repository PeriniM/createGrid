%% Import the CSV and create a cell variable for the shape
clear
clc
addpath('shapes_csv\');
T = readcell('star.csv');
shape = cell(height(T)-1,2);
x_max = -1e5;
y_max = -1e5;
x_min = 1e5;
y_min = 1e5;

%build the shape into a cell variable
for i = 2:height(T)
    x = str2num(string(T(i,2)));
    y = str2num(string(T(i,3)))*-1;
    %plot([x, x(1)],[y, y(1)])
    shape{i-1,1} = x;
    shape{i-1,2} = y;

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

%% grid parameters
x0=0; y0=0; % grid origin
f1=1; % grid width
f2=1; % grid height
xmin_grid=x0; xmax_grid=x0+f1;  
ymin_grid=y0; ymax_grid=y0+f2;  

suddx=5; % num of cols
suddy=5; % num of rows
dx=f1/suddx;
dy=f2/suddy;

%% create grid
indelem=0;
% cells to store x and y coordinates of each element
elem_x=cell(suddx*suddy*height(shape),1);
elem_y=cell(suddx*suddy*height(shape),1);
% store the indexes of nodes for each element
elem=cell(suddx*suddy*height(shape),1);

% initial coordinates for the elements to build the grid
x_start = xmin_grid;
y_start = ymax_grid-dy;

for i=1:suddy
    for j=1:suddx
        indelem=indelem+1;
        for k = 1:height(shape)
            % add x and y coordinates to separate cells
            elem_x{indelem,:}=shape{k,1}*dx+x_start;
            elem_y{indelem,:}=shape{k,2}*dy+y_start;

            % build up the nodes coordinates
            if indelem==1
                nodi_x = elem_x{indelem,:};
                nodi_y = elem_y{indelem,:};
            else
                nodi_x = [nodi_x elem_x{indelem,:}];
                nodi_y = [nodi_y elem_y{indelem,:}];
            end

            % dont update indelem twice
            if k<height(shape)
                indelem=indelem+1;
            end
        end
        % move cordinates to the right for next element
        x_start = x_start + dx;
    end
    % move cordinates to the bottom for next element
    x_start = xmin_grid;
    y_start=y_start - dy;
end

%% NODES ENUMERATION
linee_x=uniquetol(nodi_x); %quicksort + ascending order
linee_y=fliplr(uniquetol(nodi_y)); %descending order
nodi_unici=zeros(1,2); %indices of nodes laying on unique x and y lines
count_nodi_unici=zeros(1,1); %nodes numeration for each vertex
count_nodi_globali=0; %counter for global nodes
xvert=zeros(1,1);
yvert=zeros(1,1);

for s=1:indelem
    for k=1:length(elem_x{s,:}) 
        count_nodi_globali=count_nodi_globali+1;
        %find node's position on unique lines with tolerance
        ind_pos_x=ismembertol(linee_x,elem_x{s,:}(1,k));
        ind_pos_y=ismembertol(linee_y,elem_y{s,:}(1,k));
        if s==1
            count_nodi_unici(end+1)=count_nodi_globali;       
            elem{s,:}(1,k)=count_nodi_unici(end);
            xvert(end+1)= linee_x(ind_pos_x);
            yvert(end+1)= linee_y(ind_pos_y);
        else
            %if finds duplicates of nodes' indices
            if find(ismember(nodi_unici,[find(ind_pos_x==1) find(ind_pos_y==1)],'rows'))
                %find the index of the non repeated "original" node
                index = find(ismember(nodi_unici,[find(ind_pos_x==1) find(ind_pos_y==1)],'rows'));
                %insert the nueration already given to the existing node
                count_nodi_unici(end+1)=count_nodi_unici(index(1));
                %update the elements cell
                elem{s,:}(1,k)=count_nodi_unici(end);
                % decrease global counter
                count_nodi_globali=count_nodi_globali-1;
            else
                count_nodi_unici(end+1)=count_nodi_globali;  
                elem{s,:}(1,k)=count_nodi_unici(end);
                %insert only non repeated coordinates
                xvert(end+1)= linee_x(ind_pos_x);
                yvert(end+1)= linee_y(ind_pos_y);
            end
        end
        nodi_unici(end+1,:)=[find(ind_pos_x==1) find(ind_pos_y==1)]; 
    end
end
%remove first element for initialization
xvert(1)=[];
yvert(1)=[];

%% GRID PLOT
%building boundary nodes
nnode=length(xvert);
j=0;
b=zeros(1,1);
for i=1:nnode
    if abs(xvert(i)-xmin_grid)<=1e-10 || abs(xvert(i)-xmax_grid)<=1e-10 || abs(yvert(i)-ymin_grid)<=1e-10 || abs(yvert(i)-ymax_grid)<=1e-10
        j=j+1;
        b(j)=i;
    end
end
griglia.dirichlet=b(:);
griglia.neuman=0;

%draw elements with their nodes
figure(3)
for iel=1:indelem
    xvertici=elem{iel,:};
    xv=xvert(xvertici);
    yv=yvert(xvertici);
    plot([xv, xv(1)],[yv, yv(1)],'k','linewidth',1)
    hold on
    %h=text(mean(xv), mean(yv), {num2str(iel)});
    %set(h,'color','r')
end

%{
for i=1:length(xvert)
    plot( xvert(i),yvert(i),'o'); text(xvert(i)+0.03,yvert(i)+0.03, num2str(i));   
end

for i=1:j
   plot(xvert(b(i)),yvert(b(i)),'m*')
end
%}

griglia.elements=indelem;
griglia.vertices=[xvert;yvert];
griglia.bordo=b(:);
axis equal