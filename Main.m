clc;clear;
year = [1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008];
Tuition= [21300 23057 24441 25917 27204 28564 29847 31200 32994 34800 36030];

%% a. Plot the given data points and intuitively interpolate (draw) a smooth curve through them


figure(1)
scatter(year, Tuition,LineWidth=2)
xlabel('Year')
ylabel('Tuition')


%% b. Interpolate the data with the Lagrange polynomial. Plot the polynomial and the data points. Use the polynomial to predict the tuition in 2010. This is an extrapolation problem; discuss the utility of Lagrange polynomials for extrapolation.


year = [1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008];
Tuition= [21300 23057 24441 25917 27204 28564 29847 31200 32994 34800 36030];
x0=year;y0=Tuition;
x_interp = linspace(1998,2008); % x-coordinates at which to interpolate

y_interp = lagrangian_interpolation(year, Tuition, x_interp);


figure(2)
plot(x_interp,y_interp,'b','LineWidth',2) 
hold on 
plot(x0(1),y0(1),'rs','LineWidth',2) 
plot(x0(2),y0(2),'g*','LineWidth',2)
plot(x0(3),y0(3),'b*','LineWidth',2)
plot(x0(4),y0(4),'c*','LineWidth',2)
plot(x0(5),y0(5),'rs','LineWidth',2) 
plot(x0(6),y0(6),'g*','LineWidth',2)
plot(x0(7),y0(7),'b*','LineWidth',2)
plot(x0(8),y0(8),'c*','LineWidth',2)
plot(x0(9),y0(9),'rs','LineWidth',2) 
plot(x0(10),y0(10),'g*','LineWidth',2)
plot(x0(11),y0(11),'b*','LineWidth',2)
xlabel('Year')
ylabel('Tuition')
title('Lagrangian Polynomial Interpolation')

x_interp=linspace(1998,2010);
y_interp = lagrangian_interpolation(year, Tuition, x_interp);
figure(3)
plot(x_interp,y_interp,'b','LineWidth',2) 
xlabel('Year')
ylabel('Tuition')
title('Lagrangian Polynomial Interpolation used for Extrapolation')
y_interp(end)  % Extrapolation of Tuition using Lagrangian polynomial 




%% c. Repeat (b) with a cubic spline interpolation and compare your results

% Non uniform spacing 

% WE SOLVE  Ax=b where A is the Tridiagonal matrix using Thomas Algorithm 

% year = [1998 1999 2000 2001 2002 2003 2007 2010 2016 2023 2028];
% Tuition= [21300 23057 24441 25917 27204 28564 29847 31200 32994 34800 36030];
x0= year;
y0= Tuition;
f= cubic_spline([x0;y0],101,2010);

x1=linspace(x0(1),x0(2),101);
x2=linspace(x0(2),x0(3),101);
x3=linspace(x0(3),x0(4),101);
x4=linspace(x0(4),x0(5),101);
x5=linspace(x0(5),x0(6),101);
x6=linspace(x0(6),x0(7),101);
x7=linspace(x0(7),x0(8),101);
x8=linspace(x0(8),x0(9),101);
x9=linspace(x0(9),x0(10),101);
x10=linspace(x0(10),x0(11),101);

y1=f{1,1}(x1);
y2=f{2,1}(x2);
y3=f{3,1}(x3);
y4=f{4,1}(x4);
y5=f{5,1}(x5);
y6=f{6,1}(x6);
y7=f{7,1}(x7);
y8=f{8,1}(x8);
y9=f{9,1}(x9);
y10=f{10,1}(x10);

figure (4)
hold on 
plot(x1,y1,'LineWidth',2) 
plot(x2,y2,'LineWidth',2)
plot(x3,y3,'LineWidth',2)
plot(x4,y4,'LineWidth',2)
plot(x5,y5,'LineWidth',2) 
plot(x6,y6,'LineWidth',2)
plot(x7,y7,'LineWidth',2)
plot(x8,y8,'LineWidth',2)
plot(x9,y9,'LineWidth',2) 
plot(x10,y10,'LineWidth',2)


% cc= spline(year,Tuition);
% % % plot(x_inter,ppval(cc,x_inter),'b','LineWidth',1)
% % % hold on
% % % figure(4)
% % % plot(x_inter,y_inter,'r','LineWidth',2)
% % hold on 
plot(x0(1),y0(1),'rs','LineWidth',2) 
plot(x0(2),y0(2),'g*','LineWidth',2)
plot(x0(3),y0(3),'b*','LineWidth',2)
plot(x0(4),y0(4),'c*','LineWidth',2)
plot(x0(5),y0(5),'rs','LineWidth',2) 
plot(x0(6),y0(6),'g*','LineWidth',2)
plot(x0(7),y0(7),'b*','LineWidth',2)
plot(x0(8),y0(8),'c*','LineWidth',2)
plot(x0(9),y0(9),'rs','LineWidth',2) 
plot(x0(10),y0(10),'g*','LineWidth',2)
plot(x0(11),y0(11),'b*','LineWidth',2)
xlabel('Year')
ylabel('Tuition')
title('Cubic spline Interpolation')








