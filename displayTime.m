function [ output_args ] = displayTime(time, dataArray)

close all
rows = size(dataArray, 1);
plot(dataArray(1:rows, 2), dataArray(1:rows,3)) % plot position
grid on
title('Position of Center of Mass');
xlabel('Horizontal Position (m)');
ylabel('Vertical Position (m)');
hold on

x = 1;
while dataArray(x, 1) < time
    x = x+1;
end


p1=plot(dataArray(1, 2), dataArray(1,3),'Marker','o','MarkerFaceColor','r');
p1.XData = dataArray(x, 2);  % update the x and Y data of the p1, p2, p3 plots in the subplot
p1.YData = dataArray(x, 3);
end

