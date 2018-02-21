function plotgraph(data, animate, final_position, number_particles_1, number_particles_2, animation_time_step, height, width, steps, field_strength)

walker_pos=data{1};
walker_pos2=data{2};

N_walks=number_particles_1;
N_walks2=number_particles_2;
part2=N_walks2;
N_hops=steps;

X=width;
Y=height;

if final_position==1


    
figure
part=N_walks;
for i=1:2:(2*part)-1
plot(walker_pos(i,:),walker_pos(i+1,:),'red')
% plot(walker_pos(i,:),walker_pos(i+1,:),'blue')
hold on
end 

part2=N_walks2;
for i=1:2:(2*part2)-1
plot(walker_pos2(i,:),walker_pos2(i+1,:), 'blue')
% plot(walker_pos(i,:),walker_pos(i+1,:),'blue')
hold on
end 

axis([0 X 0 Y])
if field_strength == 0
title('Final position and paths of particles diffusing')
elseif field_strength == 10
title('Final position and paths of particles drifting')
else
title('Final position and paths of particles diffusing and drifting')    
end
xlabel('width')
ylabel('height')
% legend({'Red dots = electrons', 'Blue dots = holes'})
a=zeros(part,1);
b=zeros(part2,1);
% a= cell(part*2,1);

for i=1:2:(2*part)-1
a(i) = plot(walker_pos(i,end),walker_pos(i+1,end),'o','MarkerFaceColor','red');
    % a(i) = plot(walker_pos(i,end),walker_pos(i+1,end),'o','MarkerFaceColor','red');
end

for i=1:2:(2*part2)-1
b(i) = plot(walker_pos2(i,end),walker_pos2(i+1,end),'o','MarkerFaceColor','blue');
    
end

grid on
hold off

end

if animate==1
figure


part=N_walks;
for i=1:2:(2*part)-1
plot(walker_pos(i,:),walker_pos(i+1,:),'white')
hold on
end 


axis([0 X 0 Y])
grid on
if field_strength == 0
title('Animation of particles diffusing')
elseif field_strength == 10
title('Animation of particles drifting')
else
title('Animation of particles diffusing and drifting')    
end
xlabel('width')
ylabel('height')
% legend({'Red dots = electrons', 'Blue dots = holes'})
a=zeros(part,1);
b=zeros(part2,1);

for i=1:2:(2*part)-1
a(i) = plot(walker_pos(i,:),walker_pos(i+1,:),'o','MarkerFaceColor','red');

end
for i=1:2:(2*part2)-1
b(i) = plot(walker_pos(i,:),walker_pos(i+1,:),'o','MarkerFaceColor','blue');

end     
        
  k = 1;
    while k<=N_hops
        for i=1:2:(2*part)-1
        set(a(i),'XData',walker_pos(i,k), 'YData',walker_pos(i+1,k));
        set(b(i),'XData',walker_pos2(i,k), 'YData',walker_pos2(i+1,k));
        end
              drawnow;
         M(k) = getframe(1);
        
         k=k+animation_time_step;
    end

end




end

