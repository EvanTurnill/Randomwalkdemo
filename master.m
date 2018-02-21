% Evan Turnill March 2017
clear

% Master file for the plotting of random walks with drift in two dimensions
% with two populations.


%First we have to tell the computer the what we want it to calculate. This
%means things like the size of the area and how many particles are in it.

%Change the numbers below and start the program and you can see what
%happens!

%Choose the size of the area you want the particles to move in

% First the height:
height=500; 

%Then the width:
width=500;

%Now choose how many particles you want. You can have two types. 
%Both will be arranged in rectangles with a certain number of rows and
%columns. To choose 4 particles, you could choose 2 rows and 2 columns. Or
%you could choose 1 row and 4 columns. Or any other combination.

%Choose the rows and columns for the first type of particle
rows_1=10; 
columns_1=10;

%Now choose for the second type of particle. If you only want one type,
%choose 0 rows and 0 columns.

rows_2=10;

columns_2=10;


%We want to tell the computer where to put these particles. We can tell it
%where each rectangle of particles starts and stops.

%choose where the rectangle of type one particles will start and stop along
%the bottom of the area you have choosen. These numbers should be no larger
%than the width you chose above.

type_1_start_along_width = 0;

type_1_stop_along_width = 250;

%Now choose where it will start and stop up the side of that area. This
%should be no larger than the height you chose above.

type_1_start_up_side = 0;

type_1_stop_up_side= 500;

%Now repeat this for the second type of particles

type_2_start_along_width = 250;

type_2_stop_along_width = 500;

type_2_start_up_side = 0;

type_2_stop_up_side = 500;


%We also have to tell the computer how many steps each particle will take.

steps = 1000;


%If we want to add in something that means the particles will be more
%likely to head in a certain direction, we can do so. We call this 'drift'.
%For charged particles like electrons, this effect can be caused by an
%electric field.

%Choose the field strength
%Choose a number between 0 and 10.
%0 means there the particles will move entirely randomly
%10 means the particles will only move in the direction of the field  

field_strength = 0;


%Choose the field direction You can choose to make the first type particles
%more likely to go left, right, up or down. The second type will do the
%opposite.

%to make them drift left choose field_direction=1
%to make them drift left choose field_direction=2
%to make them drift left choose field_direction=3
%to make them drift left choose field_direction=4

field_direction = 1;


%choose which graphs you want to see

%To see the animation choose animate=1
%If you don't want to see the animation choose animate=0

animate = 1;

%To see the final position of each particle choose final_position=1 
% If you don't want to see the animation choose final_position=0

final_position = 1;


%Sometimes (particularly if all particles are moving randomly) the
%particles will spread out very slowly. To see the speeded up version you
%can make the animation display every 5th or 10th or 100th step. In fact
%you can which ever time step you want as long as it's less than the total
%number of steps you have choosen.

animation_time_step=5;




% This next bit of code tells the computer to calculate the locations of
% each particle at each time step using random walk code. 
%
%Please do not change this part of the code!

region_1=[type_1_start_along_width,type_1_stop_along_width,type_1_start_up_side,type_1_stop_up_side];

region_2=[type_2_start_along_width,type_2_stop_along_width,type_2_start_up_side,type_2_stop_up_side];

data=randomwalk(rows_1,columns_1,rows_2,columns_2,steps,height, width,region_1, region_2, field_direction, field_strength);


% Plot the solutions

%This tells the computer to plot the graphs you chose above. This can be
%either an animation of the particles movements or their final positions
%after all their steps or both.
%
%Please do not change this part of the code!

number_particles_1=rows_1*columns_1;
number_particles_2=rows_2*columns_2;

plotgraph(data, animate, final_position, number_particles_1, number_particles_2, animation_time_step, height, width, steps, field_strength)



