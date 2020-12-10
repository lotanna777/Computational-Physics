max_iteration=10000;  % max number of iterations
max_period=256;
start_testing=max_iteration-max_period;
numdiv=5000;
tolerance=1e-8;

bfile=fopen('bifurcations_matlab_6c.txt','w');
pfile=fopen('periods_matlab_6c.txt','w');

for riter=0:numdiv-1
    r=1.0+14.0*(riter)/numdiv;
    
    x=0.001;
    xobs=0;
    period=max_period;
    
    for iter=0:max_iteration-1
        x=logistic_calculate(r,x);
    
        if iter==start_testing
            xobs=x;
            fprintf(bfile,'%f',r);
        end
        if iter>start_testing
            fprintf(bfile,',%f',x);
            if abs(x-xobs)<tolerance
                period=iter-start_testing; 
            end
        end
    end
    fprintf(bfile,'\n');
    fprintf(pfile,'%f,%f\n',r,period);
end


data=load('bifurcations_matlab_6c.txt');
%import the data

f=figure;
%create a figure called f.

hold all
%the flag hold means we are going to add data to the plot, rather than replace data.  
% this is not necessary for this example, but may be needed when combining data.

set(f,'Visible','on');
%the chart will pop up if 'on' is selected.  You can use 'off' as well


plot(data(:,1),data(:,2:end),'.','MarkerSize',1,'color','black');
% This is the actual plot.  Only the first two aruments are required, the others optional.
% '.' refers to the plot markers being points.  You can use '+', for example.
% 'MarkerSize',1 choses the size of the plot markers
% 'color','black' choses the color.  

title('bifurcation diagram 6c');
%writes to the top of the plot

box on
%puts a box all around the plot (instead of just x-y axes)

ax=gca;
% gca means "get current axes".  If you wnat to modify the axes, this is how.

ax.FontSize=12;
%sets the font size for the axes

xlabel('r');
ylabel('x_n');
%labels the axes 

saveas(gcf,'bifurcation 6c','epsc');
%prints the figure to an eps file.  You should usually use eps instead of pdf if possible. 

hold off

function x=logistic_calculate(r,x)
	x=r*x/(1+x^4);
end
