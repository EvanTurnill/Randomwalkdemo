function data=randomwalk(rows_1,columns_1,rows_2,columns_2,steps,height, width,region_1, region_2, field_direction, field_strength) 


DIMENSIONS=2;
% graphon=1; %show time development if =1
%set number of particles
rows = rows_1;
cols = columns_1;
part= rows*cols;

rows2 = rows_2;
cols2 = columns_2;
part2= rows2*cols2;


N_walks=part;
N_walks2=part2;

N_hops=steps;

% delta_r_array=zeros(N_walks,1);

walker_pos=zeros(DIMENSIONS*N_walks,N_hops);

% delta_r_array2=zeros(N_walks2,1);

walker_pos2=zeros(DIMENSIONS*N_walks2,N_hops);
% graphtimestep=1;


xpts=1:cols;
ypts=1:rows;
xpts2=1:cols2;
ypts2=1:rows2;

% set spacial
X=width;
Y=height;




% set initial locations






% region from and to for type 1 particles
rstartx=region_1(1);
rstopx=region_1(2);
rstarty=region_1(3);
rstopy=region_1(4);
colgap=(rstopx-rstartx)/(cols+1);
rowgap=(rstopy-rstarty)/(rows+1);

xloc=rstartx+round(xpts*colgap);
yloc=rstarty+round(ypts*rowgap);

[Xgrid,Ygrid]=meshgrid(xloc,yloc);

walker_pos(1:2:2*part,1)=reshape(Xgrid,[1,part]); %arranged so x coord are cols 1:part and y coord are part+1:end
walker_pos(2:2:2*part,1)=reshape(Ygrid,[1, part]);


% P_array=ones(2*DIMENSIONS,1)./(2.0*DIMENSIONS);
dominant=(0.75*field_strength/10)+0.25;
nondominant=0.25-(0.25*field_strength/10);

if field_direction==1   
    P_array=[dominant;nondominant;nondominant;nondominant];
end

if field_direction==2   
    P_array=[nondominant;dominant;nondominant;nondominant];
end

if field_direction==3   
    P_array=[nondominant;nondominant;dominant;nondominant];
end

if field_direction==4   
    P_array=[nondominant;nondominant;nondominant;dominant];
end
    
R_array=zeros(2*DIMENSIONS,1);
cum_sum=0.0;


% region from and to for type 2 particles
rstartx2=region_2(1);
rstopx2=region_2(2);
rstarty2=region_2(3);
rstopy2=region_2(4);
colgap2=(rstopx2-rstartx2)/(cols2+1);
rowgap2=(rstopy2-rstarty2)/(rows2+1);

xloc2=rstartx2+round(xpts2*colgap2);
yloc2=rstarty2+round(ypts2*rowgap2);

[Xgrid2,Ygrid2]=meshgrid(xloc2,yloc2);

walker_pos2(1:2:2*part2,1)=reshape(Xgrid2,[1,part2]); %arranged so x coord are cols 1:part and y coord are part+1:end
walker_pos2(2:2:2*part2,1)=reshape(Ygrid2,[1, part2]);


% P_array2=ones(2*DIMENSIONS,1)./(2.0*DIMENSIONS);

dominant=(0.75*field_strength/10)+0.25;
nondominant=0.25-(0.25*field_strength/10);

if field_direction==2   
    P_array2=[dominant;nondominant;nondominant;nondominant];
end

if field_direction==1   
    P_array2=[nondominant;dominant;nondominant;nondominant];
end

if field_direction==4   
    P_array2=[nondominant;nondominant;dominant;nondominant];
end

if field_direction==3   
    P_array2=[nondominant;nondominant;nondominant;dominant];
end
R_array2=zeros(2*DIMENSIONS,1);
cum_sum2=0.0;


% type 1 particle loop for R_array

for i=1:(2*DIMENSIONS)
    cum_sum=cum_sum+P_array(i,1);
    R_array(i,1)=cum_sum; %this is the position of each event on the number line
% #     |----|----|----|----|
% #     0    R_0  R_1  R_3  R_4
% # our random number lies in one of these intervals - that is the event we will do

end

% type 2 particle loop for R_array

for i=1:(2*DIMENSIONS)
    cum_sum2=cum_sum2+P_array2(i,1);
    R_array2(i,1)=cum_sum2; %this is the position of each event on the number line
% #     |----|----|----|----|
% #     0    R_0  R_1  R_3  R_4
% # our random number lies in one of these intervals - that is the event we will do

end


for hop=1:N_hops
    for w_count=1:N_walks
        R=rand(1);
        for J=1:2*DIMENSIONS
            if (R<R_array(J))
                dim=ceil(J/2); %this is the dimension to walk in
                direction=2*mod(J,2); %this is either 0 or 2
                if(direction==0)
                    direction=-2; 
                end
                walker_pos(1+((w_count-1)*DIMENSIONS):w_count*DIMENSIONS,hop+1)=walker_pos(1+((w_count-1)*DIMENSIONS):w_count*DIMENSIONS,hop);
                if walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==0 || walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==1 || walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==2
                    walker_pos(((w_count-1)*DIMENSIONS)+dim,hop+1)=walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)+1;
                elseif dim==1 && walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==X-2 || walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==X-1 || walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==X 
                    walker_pos(((w_count-1)*DIMENSIONS)+dim,hop+1)=walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)-1;
                elseif dim==2 && walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==Y-2 || walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==Y-1 || walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)==Y 
                    walker_pos(((w_count-1)*DIMENSIONS)+dim,hop+1)=walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)-1;
                else    
                walker_pos(((w_count-1)*DIMENSIONS)+dim,hop+1)=walker_pos(((w_count-1)*DIMENSIONS)+dim,hop)+direction;     %now have our event dimension in dim and direction
                end

            break  %exit the loop early as we have already found our event  
            end
        end
    end
    for w_count2=1:N_walks2
        R2=rand(1);
        for J=1:2*DIMENSIONS
            if (R2<R_array2(J))
                dim=ceil(J/2); %this is the dimension to walk in
                direction=2*mod(J,2); %this is either 0 or 2
                if(direction==0)
                    direction=-2; 
                end
                walker_pos2(1+((w_count2-1)*DIMENSIONS):w_count2*DIMENSIONS,hop+1)=walker_pos2(1+((w_count2-1)*DIMENSIONS):w_count2*DIMENSIONS,hop);
                if walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==0 || walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==1 || walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==2
                    walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop+1)=walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)+1;
                elseif dim==1 && walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==X-2 || walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==X-1 || walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==X 
                    walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop+1)=walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)-1;
                elseif dim==2 && walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==Y-2 || walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==Y-1 || walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)==Y 
                    walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop+1)=walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)-1;
                else    
                walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop+1)=walker_pos2(((w_count2-1)*DIMENSIONS)+dim,hop)+direction;     %now have our event dimension in dim and direction
                end

            break  %exit the loop early as we have already found our event  
            end  
        end   
     end
      %         change probabilities here    
end
%     delta_r_array(w_count,1)=sqrt(sum((walker_pos).^2));   



data{1}=walker_pos;
data{2}=walker_pos2;

