function [xvert, yvert, elem] = enum_nodes(nodi_x, nodi_y, elem_x, elem_y, elem)
% it calculates the unique coordinates for each nodes and remove duplicates

linee_x=uniquetol(nodi_x); %quicksort + ascending order
linee_y=fliplr(uniquetol(nodi_y)); %descending order
nodi_unici=zeros(1,2); %indices of nodes laying on unique x and y lines
count_nodi_unici=zeros(1,1); %nodes numeration for each vertex
count_nodi_globali=0; %counter for global nodes
xvert=zeros(1,1);
yvert=zeros(1,1);

for s=1:length(elem)
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

end