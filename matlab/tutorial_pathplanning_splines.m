




%% MatLab: spline tutorial (Part1)
% Point-to-point Path generation (linear interpolation)
% -# The point-to-point strategy has its application for linear
%    interpolation between a point to another
%
% Path (Multipoint) generation (nonlinear interpolation)
% Trajectory (Path (nonlinear) and time (linear) interpolation)



%Note: The best strategy is to find a very simple format for storing. This
%      is not always the best solution but presently it avoids a debugging 
%      loss of time.
%e.g.

pos_xy=[0 0.5  2 3.5 4;
        0 2   -2 2   0];
  
      
% and plots the results for [0, 4]. 

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

%==========================================================================
% MATLAB "native" functions for path/trajectory planning: interp1 and spline.
%
% yi = interp1(x,y,xi,'spline'); 
%
% and
%
% yi = spline(x,y,xi);
%
% Both receive a set of data points (x,y) and return the values of the cubic
% spline interpolating function s(x) for the (intermediate) points xi given as
% the third input argument. 
%==========================================================================



% INTERP1
% =======
%
%      'nearest'  - nearest neighbor interpolation
%      'linear'   - linear interpolation
%      'spline'   - piecewise cubic spline interpolation (SPLINE)
%      'pchip'    - shape-preserving piecewise cubic interpolation
%      'cubic'    - same as 'pchip'
%      'v5cubic'  - the cubic interpolation from MATLAB 5, which does not
%                   extrapolate and uses 'spline' if X is not equally
%                   spaced.
%
%    YI = interp1(X,Y,XI,METHOD,'extrap') uses the interpolation algorithm
%    specified by METHOD to perform extrapolation for elements of XI outside
%    the interval spanned by X. 
% 
%    YI = interp1(X,Y,XI,METHOD,EXTRAPVAL) replaces the values outside of the 
%    interval spanned by X with EXTRAPVAL.  NaN and 0 are often used for 
%    EXTRAPVAL.  The default extrapolation behavior with four input arguments 
%    is 'extrap' for 'spline' and 'pchip' and EXTRAPVAL = NaN for the other 
%    methods.
% 
%    PP = interp1(X,Y,METHOD,'pp') will use the interpolation algorithm specified
%    by METHOD to generate the ppform (piecewise polynomial form) of Y. The
%    method may be any of the above METHOD except for 'v5cubic'. PP may then
%    be evaluated via PPVAL. PPVAL(PP,XI) is the same as
%    interp1(X,Y,XI,METHOD,'extrap').
    



% Point-to-point path generation (linear interpolation)
% =====================================================
%
%   One might consider to simply connect a set of positions (2 points at once)
%   of the WMR in the X,Y cartesian space.
%
%   (0, 0), (0.5, 2), (2, -2), (3.5, 2), (4, 0)
%
%   the linear interpolation is the only meaningful interpolation method 
%   for planning a path between 2 only points.

figure(1)
interp_method = 'linear'
if max(size(pos_xy))==1, disp('No move !!') %In the case of 1 point, there is no path !!
else
  Ns=100;
  xi=min(pos_xy(1,:)):abs(max(pos_xy(1,:))-min(pos_xy(1,:)))/(Ns-1):max(pos_xy(1,:));
  yi = interp1(pos_xy(1,:),pos_xy(2,:),xi,interp_method); 
  plot(xi,yi,'-b','linewidth',2) 
end
title('Point-to-point path generation (linear interpolation)')





% Path (or multipoint) generation (nonlinear interpolation)
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

%interp_method='nearest'   %nearest neighbor interpolation
%interp_method='linear'    %linear interpolation
%interp_method='spline'    %piecewise cubic spline interpolation (SPLINE)
%interp_method='pchip'     %shape-preserving piecewise cubic interpolation
interp_method='cubic'      %same as 'pchip' 
%interp_method='v5cubic'   %the cubic interpolation from MATLAB 5, which does not
                           %extrapolate and uses 'spline' if X is not equally spaced
Npoints=3;
         %Choosing npoints=3,
         %123 -> pivot 2
         %345 -> pivot 4

figure(1)
if max(size(pos_xy))==1, disp('No move !!')
else
  Ns=100;
  halfstep_l=floor((Npoints-1)/2); %half step
  halfstep_r=floor((Npoints-1)/2); %half step
  array_numiter=halfstep_l+1:Npoints:size(pos_xy,2)-halfstep_r;
  for numiter=array_numiter
    xi=min(pos_xy(1,numiter-halfstep_l:numiter+halfstep_r)):...
      abs(max(pos_xy(1,numiter-halfstep_l:numiter+halfstep_r))-min(pos_xy(1,numiter-halfstep_l:numiter+halfstep_r)))...
      /(Ns-1):max(pos_xy(1,numiter-halfstep_l:numiter+halfstep_r));
    yi = interp1(pos_xy(1,:),pos_xy(2,:),xi,interp_method); 
    plot(xi,yi,'.-y','linewidth',2)
  end
  if array_numiter(end)&&(mod(size(pos_xy,2),halfstep_r+halfstep_l)~=0)
    xi=min(pos_xy(1,numiter-halfstep_l:end)):...
      abs(max(pos_xy(1,numiter-halfstep_l:end))-min(pos_xy(1,numiter-halfstep_l:end)))...
      /(Ns-1):max(pos_xy(1,numiter-halfstep_l:end));
    yi = interp1(pos_xy(1,:),pos_xy(2,:),xi,interp_method); 
  end
end








% Path (or multipoint) generation (nonlinear interpolation)
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
% For example it might be required to poduce the whole path at once !!
% 
%
%
%
% spline Cubic spline data interpolation.
%    PP = spline(X,Y) provides the piecewise polynomial form of the 
%    cubic spline interpolant to the data values Y at the data sites X,
%    for use with the evaluator PPVAL and the spline utility UNMKPP.
%    X must be a vector.
%    ...
%    ...
%

%splines (is cubic !!)
figure(1)
if max(size(pos_xy))==1, disp('No move !!')
else
  Ns=100; %Number of points
  xi=min(pos_xy(1,:)):abs(max(pos_xy(1,:))-min(pos_xy(1,:)))/(Ns-1):max(pos_xy(1,:));
  yi = spline(pos_xy(1,:),pos_xy(2,:),xi); 
  plot(xi,yi,'.-c','linewidth',2)
end
title('Comparison with spline interpolator')




% Path (or multipoint) generation (nonlinear interpolation) using Clothoid
% ========================================================================
%
% One would rather to connect a set of positions occupied by the WMR in 
% the X,Y cartesian space considering different strategies for
% guaranteering different level of path "smoothing" between points.
%
% However, the interesting feature of imposing maximum curvature (which is 
% typically assessed to the performance of the robot mechanics). This work
% is based on the code produced by 
%
%          Enrico Bertolazzi and Marco Frego                                  
%          Department of Industrial Engineering                               
%          University of Trento                                               
%          enrico.bertolazzi@unitn.it                                         
%          m.fregox@gmail.com  
%
% and freely available on-line.
% 
%==========================================================================
%Description: G1 fitting with clothoids
%
% The script buildClothoid implements the algorithm described in the paper
% G1 fitting with clothoids, Mathematical Methods in the Applied Sciences, 
% John Wiley & Sons, (2014), Ltd.
% http://onlinelibrary.wiley.com/doi/10.1002/mma.3114/abstract
% 
% Given two points and two direction associated with the points, 
% a clothoid, i.e. a curve with linear varying curvature is computed in such 
% a way it pass to the points with the prescribed direction. The solution in 
% general is not unique but chosing the one for which the angle direction 
% variation is less than 2*pi the solution is unique. The sofware solves the 
% nonlinear system associated to the fitting problem computing initial 
% curvature and its derivative with the lenght of the curve. An additional 
% routine for the computation of the points along a clothoid curve is added 
% for convenience.
% Usage: To compute curvature and length of a clothoid passing throught points 
%        P0=(x0,y0), P1=(x1,y1) with angles theta0 andtheta1 use the function 
%        buildClothoid
%
% [k,dk,L] = buildClothoid( x0, y0, theta0, x1, y1, theta1, tol ) ;
%
% The parameter tol (usually 1e-10) is a tolerance parameter used to stop 
% Newton iteration. The resulting curve can be described by the 6
% parameters:
% 
% -> (x0,y0) initial point 
% -> theta0 initial direction (angle)
% -> k initial curvature of the curve
% -> dk derivative of the cuvature along arc length
% -> L total length of the curve connecting P0 and P1
% -> to compute points along a clothoid curve use the function pointsOnClothoid
%
% XY = pointsOnClothoid( x0, y0, theta0, k, dk, L, npts ) ;
%
% This function uses the 5 parameters x0, y0, theta0, k, dk which indentify 
% the curve. The parameter L is used to determine length of the portion of 
% the curve to compute. The parameter npts is the number of points computed 
% along the curve.
% XY is a 2 x npts matrix whose columns are the points along the curve.
% To plot the computed curve use MATLAB plot command as usual:
%
% plot( XY(1,:), XY(2,:), '-r' ) ;
%
% Three sample scripts: TestN0, TestN1, TestN2 shows how to use the functions.
% 
%

x0 = pos_xy(1,1)
y0 = pos_xy(2,1)
x1 = pos_xy(1,2)
y1 = pos_xy(2,2)
theta0=pi/3
theta1=pi/3
tol=1e-10

npts=1000;
%Computes parameters of the clothoid from Ps and Pe
[k,dk,L] = buildClothoid(x0, y0, theta0, x1, y1, theta1, tol);
%Returns the path
XY = pointsOnClothoid(x0, y0, theta0, k, dk, L, npts) ;
%Visualize
%figure, 
plot(XY(1,:),XY(2,:))







% Trajectory generation (Path-> nonlinear geometry + time linear in time)
% =====================================================
%
% with Clothoid
% 
% 
% This work is re-using a part of the work carried out by Leuci & Amistadi
% during the 2013-2014 academic year.

t        = [0 1    2 3   4];
x        = [0 0.5  2 3.5 4];
y        = [0 2   -2 2   0];

theta(1) = 0;
theta(length(t)) = 0;
for i =2:length(t)-1
    theta(i) = atan(y(i)/x(i))+theta(i-1);
end

%addpath('Clotoid\G1fitting');

XYT = clothoid_traj(x, y, theta, t);

%% Plot
figure,
title('Trajectory produced using clothoid')
subplot(1,2,1), hold on, grid on
plot(x, t,'*r');
plot(XYT(1,:),XYT(3,:),'b');
legend('Points','Clothoid')
subplot(1,2,2), hold on, grid on
plot(y, t,'*r');
plot(XYT(2,:),XYT(3,:),'b');
legend('Points','Clothoid')
title('Trajectory produced using clothoid')

figure,
hold on, grid on
plot(x, y,'*r');
plot(XYT(1,:),XYT(2,:),'b');
title('Trajectory (x,y) produced using clothoid')



% Trajectory generation (Path-> nonlinear geometry + time linear in time)
% =====================================================
%
% with interp1/spline
% 
% 
%


Ts=0.01; %Sampling time -> t =  Ts x iteration + t0

for trajgentype = 1:3
  
if trajgentype==1
  
  %Ex. 1, Zig Zag
  t = [0 1 2 3 4 ]
  x = pos_xy(1,:)
  y = pos_xy(2,:)
  
elseif trajgentype==2
  
  %Ex. 2
  t = [0 1 2 3 4 5]
  x = [2 1 0 -1 -2 -1]
  y = [0 1 2  1  0 -1]
  
elseif trajgentype==3
  
  %Ex. 3
  t = [0 1 2 3 4 5 6 7 8]
  x = [1 1 1 0 -1 -1 -1 0 1]
  y = [1 0 -1 -1 -1  0 1 1 1]
  
%elseif trajgentype==4
%  
%  %Ex. 4: let see time-nonlinearities
%  t = [0 0.3 1.1 1.6 2.3 3.0 3.2 3.9 6.0];
%  x = [1 1 1 0 -1 -1 -1 0 1];
%  y = [1 0 -1 -1 -1  0 1 1 1];
  
else
  
  error('Wring input value of TRAJGENTYPE')
  
end


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
%for iterposition=1+npoints:length(t)
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


figure
title('Plot of y(t) and x(t)')
subplot(1,2,1), hold on, grid on
plot(t,x,'m*')
plot(t,y,'c*')
label_t2x2=plot(t2,x2,'co',t2,x2,'r');
label_t2y2=plot(t2,y2,'mo',t2,y2,'b');
legend([label_t2y2(2) label_t2x2(2)],'y(t)','x(t)')
%title('Plot of Data (Points) and Model (Line)')
xlabel('t [s]')
ylabel('s [m]')
subplot(1,2,2),hold on, grid on
label_x2y2=plot(x,y,'o',x2,y2,'g')
legend(label_x2y2(2),'Traj(x,y)')
xlabel('x [m]')
ylabel('y [m]')
axis equal
%axis square
AXIS=axis;
magAxisXY=1.1;
AxisFrameXY=max([(max(x2(1,:))-min(x2(1,:)))*(magAxisXY-1) (max(y2(1,:))-min(y2(1,:)))*(magAxisXY-1)]);
axis([min(x2(1,:))-AxisFrameXY max(x2(1,:))+AxisFrameXY min(y2(1,:))-AxisFrameXY max(y2(1,:))+AxisFrameXY])

title([' Iteration number ' num2str(trajgentype)])
end





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
title('Plot of y(t) and x(t)')
subplot(1,2,1), hold on, grid on
plot(t2,vx2,'m*')
plot(t2,vx2,'c*')
label_t2x2=plot(t2,vx2,'co',t2,vx2,'r');
label_t2y2=plot(t2,vy2,'mo',t2,vy2,'b');
legend([label_t2y2(2) label_t2x2(2)],'Vy(t)','Vx(t)')
title('Etraction of V_x and V_y from (x,y)')
xlabel('t [s]')
ylabel('v [m/s]')

title('Plot of y(t) and x(t)')
subplot(1,2,2), hold on, grid on
plot(t2,ax2,'m*')
plot(t2,ax2,'c*')
label_t2x2=plot(t2,ax2,'co',t2,ax2,'r');
label_t2y2=plot(t2,ay2,'mo',t2,ay2,'b');
legend([label_t2y2(2) label_t2x2(2)],'Ay(t)','Ax(t)')
title('Etraction of a_x and a_y from (x,y)')
xlabel('t [s]')
ylabel('a [m/s^2]')



% =====> Excercise during class:
% -> Impose (Ax,Vx,Sx) for obtaining path/trajectory with interp/splines
% -> Investigate difference between methods in meekAndWalton and tests for
%     clothoid.




% Trajectory generation (Path-> nonlinear geometry + time linear in time)
% =====================================================
%
% Similarly can be carried out by CSPLINES_KC
%


%csplines

%Special note:
% The section of this tutorial dedicated to the utilization of the built-in 
% "splines" has been developed looking at the original work of Yang, Cao, 
% Chung and Morris contained in "Applied numerical methods using Matlab"
%
%
% Also, append the statements that do the same job by using the routine 
% “cspline(x,y,KC)” (Section 3.5) with KC = 1, 2, and 3.


%Inputs
t1=[1 2 3 4 5]; %Temporal division
pos_xy=[0 0.5  2 3.5 4;
        0 2   -2 2   0];
      
xyt=[pos_xy; t1];
Ns=100; % discrete (1/Ns) = continuous(1/Fs) = continuous(Ts)
npoints=2;


if max(size(pos_xy))==1, disp('No move !!')
else
  xi=[];
  yi=[];
  ti=[];
  for iter=npoints:npoints-1:max(size(pos_xy))  %It is not possible 1 !!
    iter
    max(size(pos_xy))
    npoints
    ti_temp=xyt(3,iter-npoints+1):...
      abs(xyt(3,iter-npoints+1)-xyt(3,iter))/(Ns-1):xyt(3,iter);
    ti=[ti ti_temp];
    [xi_temp,S] = cspline_KC(xyt(3,iter-npoints+1:iter),...
      xyt(1,iter-npoints+1:iter),ti_temp,2,3,3);     
    [yi_temp,S] = cspline_KC(xyt(3,iter-npoints+1:iter),...
      xyt(2,iter-npoints+1:iter),ti_temp,2,3,3);
    xi = [xi xi_temp]; 
    yi = [yi yi_temp];
  end
  if iter<max(size(pos_xy))
     npoints=max(size(pos_xy))-iter+1;
     iter=max(size(pos_xy));
     ti_temp=xyt(3,iter-npoints+1):...
       abs(xyt(3,iter-npoints+1)-xyt(3,iter))/(Ns-1):xyt(3,iter);
      ti=[ti ti_temp];
      [xi_temp,S] = cspline_KC(xyt(3,iter-npoints+1:iter),...
        xyt(1,iter-npoints+1:iter),ti_temp,2,3,3);     
      [yi_temp,S] = cspline_KC(xyt(3,iter-npoints+1:iter),...
        xyt(2,iter-npoints+1:iter),ti_temp,2,3,3);
      xi = [xi xi_temp]; 
      yi = [yi yi_temp];
  end
  figure, hold on, grid on
  plot(pos_xy(1,:),pos_xy(2,:),'r*',xi,yi,'-b')
end










% TO DO: Next year !!!

% =========================================================================
% =========================================================================


% Dedicated: Robot Path Planning Using Cubic Spline

% Every object having a mass is subject to the law of inertia and so its
% speed described by the first derivative of its displacement with respect to
% time must be continuous in any direction. In this context, the cubic spline
% having the continuous derivatives up to second order presents a good basis
% for planning the robot path/trajectory. We will determine the path of a robot
% in such a way that the following conditions are satisfied:

%Problem:

% At time t = 0 s, the robot starts from its home position (0, 0) with zero 
% initial velocity, passing through the intermediate point (1, 1) at t = 1 s 
% and arriving at the final point (2, 4) at t = 2 s.

% On arriving at (2, 4), it starts the point at t = 2 s, stopping by the
% intermediate point (3, 3) at t = 3 s and arriving at the point (4, 2) at
% t = 4 s.

% On arriving at (4, 2), it starts the point, passing through the intermediate
% point (2,1) at t = 5 s and then returning to the home position (0, 0) at
% t = 6 s.
%
%
% More precisely, what we need is
%
%-> The spline interpolation matching the three points (0, 0),(1, 1),(2, 2) and
%   having zero velocity at both boundary points (0, 0) and (2, 2),
%
%-> The spline interpolation matching the three points (2, 2),(3, 3),(4, 4) and
%   having zero velocity at both boundary points (2, 2) and (4, 4), and
%
%-> The spline interpolation matching the three points (4, 4), (5, 2), (6, 0) and
%   having zero velocity at both boundary points (4, 4) and (6, 0) on the tx plane.
%
%
%On the ty plane, we need 
%
%-> The spline interpolation matching the three points (0, 0),(1, 1),(2, 4) and
%   having zero velocity at both boundary points (0, 0) and (2, 4),
%
%-> The spline interpolation matching the three points (2, 4),(3, 3),(4, 2) and
%   having zero velocity at both boundary points (2, 4) and (4, 2), and
%
%-> The spline interpolation matching the three points (4, 2),(5, 1),(6, 0) and
%   having zero velocity at both boundary points (4, 2) and (6, 0).

pos_xy(1,:)
pos_xy(2,:)

%x xdot x2dot
%x1=

%y ydot y2dot
%y1=

%robot_path
xyt=[0 1 2;
  0 1 4; 
  0 1 2]; 



ti1 = [xyt(1,3): 0.05: xyt(2,3)];
xi1 = cspline_KC(xyt(3,:),xyt(1,:),ti1); 
yi1 = cspline_KC(xyt(3,:),xyt(2,:),ti1);

xi2 = cspline_KC(xyt(3,:),xyt(1,:),ti1,1,0,0); 
yi2 = cspline_KC(xyt(3,:),xyt(2,:),ti1,1,0,0);

xi3 = cspline_KC(xyt(3,:),xyt(1,:),ti1,2,0,0); 
yi3 = cspline_KC(xyt(3,:),xyt(2,:),ti1,2,0,0);

figure
subplot(3,1,1), hold on, grid on
%plot(xi1,yi1,'k', xi2,yi2,'b', xi3,yi3, 'k')
%plot(xi1,ti1,'k', xi2,ti1,'b', xi3,ti1, 'k')
plot(ti1,xi1,'k', ti1,xi2,'b', ti1,xi3, 'k')

subplot(3,1,2), hold on, grid on
%plot([x1(1) x2(1) x3(1) x3(end)],[y1(1) y2(1) y3(1) y3(end)],'o')
%plot(yi1,ti1,'k', yi2,ti1,'b', yi3,ti1, 'k')
plot(ti1,yi1,'k', ti1,yi2,'b', ti1,yi3, 'k')

subplot(3,1,3), hold on, grid on
%plot([x1 x2 x3],[y1 y2 y3],'k+')
plot(yi1,xi1,'k', yi2,xi1,'b', yi3,xi1, 'k')

%axis([0 5 0 5])



%One-Dimensional Interpolation
%What do you have to give as the fourth input argument of the MATLAB
%built-in routine “interp1()” in order to get the same result as that would
%be obtained by using the following one-dimensional interpolation routine
%“intrp1()”? What letter would you see if you apply this routine to inter-
%polate the data points {(0,3), (1,0), (2,3), (3,0), (4,3)} for [0,4]?
function yi = intrp1(x,y,xi)
  M = length(x); Mi = length(xi);
  for mi = 1: Mi
    if xi(mi) < x(1), yi(mi) = y(1)-(y(2) - y(1))/(x(2) - x(1))*(x(1) - xi(mi));
    elseif xi(mi)>x(M)
      yi(mi) = y(M)+(y(M) - y(M - 1))/(x(M) - x(M-1))*(xi(mi) - x(M));
    else
      for m = 2:M
        if xi(mi) <= x(m)
          yi(mi) = y(m - 1)+(y(m) - y(m - 1))/(x(m) - x(m - 1))*(xi(mi) - x(m - 1));
          break;
        end
      end
    end
  end
end

%Least-Squares Curve Fitting
%(a) There are several nonlinear relations listed in Table 3.5, which
%can be linearized to fit the LS algorithm. The MATLAB routine
%“curve_fit()” implements all the schemes that use the LS method
%to find the parameters for the template relations, but the parts for the
%relations (1), (2), (7), (8), and (9) are missing. Supplement the missing
%parts to complete the routine.
%(b) The program “nm3p11.m” generates the 12 sets of data pairs according to
%various types of relations (functions), applies the routines
%“curve_fit()”/“lsqcurvefit()” to find the parameters of the template
%relations, and plots the data pairs on the fitting curves obtained from the
%template functions with the estimated parameters. Complete and run it
%to get the graphs like Fig. P3.11. Answer the following questions.

%(i) If any, find the case(s) where the results of using the two routines
%make a great difference. For the case(s), try with another initial
%guess th0 = [1 1] of parameters, instead of th0 = [0 0].
%(ii) If the MATLAB built-in routine “lsqcurvefit()” yields a bad
%result, does it always give you a warning message? How do you
%compare the two routines?


function [th,err,yi] = curve_fit(x,y,KC,C,xi,sig)
  % implements the various LS curve-fitting schemes in Table 3.5
  % KC = the # of scheme in Table 3.5
  % C = optional constant (final value) for KC! = 0 (nonlinear LS)
  %
  degree of approximate polynomial for KC = 0 (standard LS)
  % sig = the inverse of weighting factor for WLS
  Nx = length(x); x = x(:); y = y(:);
  if nargin == 6, sig = sig(:);
  elseif length(xi) == Nx, sig = xi(:); xi = x;
  else sig = ones(Nx,1);
  end
  if nargin < 5, xi = x; end; if nargin < 4 | C < 1, C = 1; end
  switch KC
    case 1
      
    case 2
      
    case {3,4}
      A(1:Nx,:) = [x./sig ones(Nx,1)./sig];
      RHS = log(y)./sig;
      th = A\RHS;
      yi = exp(th(1)*xi + th(2)); y2 = exp(th(1)*x + th(2));
      if KC == 3, th = exp([th(2) th(1)]);
      else th(2) = exp(th(2));
      end
    case 5
      if nargin < 5, C = max(y) + 1; end %final value
      A(1:Nx,:) = [x./sig ones(Nx,1)./sig];
      y1 = y; y1(find(y > C - 0.01)) = C - 0.01;
      RHS = log(C-y1)./sig;
      th = A\RHS;
      yi = C - exp(th(1)*xi + th(2)); y2 = C - exp(th(1)*x + th(2));
      th = [-th(1) exp(th(2))];
    case 6
      A(1:Nx,:) = [log(x)./sig ones(Nx,1)./sig];
      y1 = y; y1(find(y < 0.01)) = 0.01;
      RHS = log(y1)./sig;
      th = A\RHS;
      yi = exp(th(1)*log(xi) + th(2)); y2 = exp(th(1)*log(x) + th(2));
      th = [exp(th(2)) th(1)];
    case 7
    case 8
    case 9
    otherwise %standard LS with degree C
      A(1:Nx,C + 1) = ones(Nx,1)./sig;
      for n = C:-1:1, A(1:Nx,n) = A(1:Nx,n + 1).*x; end
      RHS = y./sig;
      th = A\RHS;
      yi = th(C+1); tmp = ones(size(xi));
      y2 = th(C+1); tmp2 = ones(size(x));
      for n = C:-1:1,
        tmp = tmp.*xi; yi = yi + th(n)*tmp;
        tmp2 = tmp2.*x; y2 = y2 + th(n)*tmp2;
      end
  end
  th = th(:)'; err = norm(y - y2);
  if nargout == 0, plot(x,y,'*', xi,yi,'k-'); end
  
  %nm3p11 to plot Fig.P3.11 by curve fitting
  clear
  x = [1: 20]*2 - 0.1; Nx = length(x);
  noise = rand(1,Nx) - 0.5; % 1xNx random noise generator
  xi = [1:40]-0.5; %interpolation points
  figure(1), clf
  a = 0.1; b = -1; c = -50;
  %Table 3.5(0)
  y = a*x.^2 + b*x + c + 10*noise(1:Nx);
  [th,err,yi] = curve_fit(x,y,0,2,xi); [a b c],th
  [a b c],th %if you want parameters
  f = inline('th(1)*x.^2 + th(2)*x+th(3)','th','x');
  [th,err] = lsqcurvefit(f,[0 0 0],x,y), yi1 = f(th,xi);
  subplot(321), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
  a = 2; b = 1; y = a./x + b + 0.1*noise(1:Nx); %Table 3.5(1)
  [th,err,yi] = curve_fit(x,y,1,0,xi); [a b],th
  f = inline('th(1)./x + th(2)','th','x');
  th0 = [0 0]; [th,err] = lsqcurvefit(f,th0,x,y), yi1 = f(th,xi);
  subplot(322), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
  a = -20; b = -9; y = b./(x+a) + 0.4*noise(1:Nx); %Table 3.5(2)
  [th,err,yi] = curve_fit(x,y,2,0,xi); [a b],th
  f = inline('th(2)./(x+th(1))','th','x');
  th0 = [0 0]; [th,err] = lsqcurvefit(f,th0,x,y), yi1 = f(th,xi);
  subplot(323), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
  a = 2.; b = 0.95; y = a*b.^x + 0.5*noise(1:Nx); %Table 3.5(3)
  [th,err,yi] = curve_fit(x,y,3,0,xi); [a b],th
  f = inline('th(1)*th(2).^x','th','x');
  th0 = [0 0]; [th,err] = lsqcurvefit(f,th0,x,y), yi1 = f(th,xi);
  subplot(324), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
  a = 0.1; b = 1; y = b*exp(a*x) +2*noise(1:Nx); %Table 3.5(4)
  [th,err,yi] = curve_fit(x,y,4,0,xi); [a b],th
  f = inline('th(2)*exp(th(1)*x)','th','x');
  th0 = [0 0]; [th,err] = lsqcurvefit(f,th0,x,y), yi1 = f(th,xi);
  subplot(325), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
  a = 0.1; b = 1;
  %Table 3.5(5)
  y = -b*exp(-a*x); C = -min(y)+1; y = C + y + 0.1*noise(1:Nx);
  [th,err,yi] = curve_fit(x,y,5,C,xi); [a b],th
  f = inline('1-th(2)*exp(-th(1)*x)','th','x');
  th0 = [0 0]; [th,err] = lsqcurvefit(f,th0,x,y), yi1 = f(th,xi);
  subplot(326), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
  figure(2), clf
  a = 0.5; b = 0.5; y = a*x.^b +0.2*noise(1:Nx); %Table 3.5(6a)
  [th,err,yi] = curve_fit(x,y,0,2,xi); [a b],th
  f = inline('th(1)*x.^th(2)','th','x');
  th0 = [0 0]; [th,err] = lsqcurvefit(f,th0,x,y), yi1 = f(th,xi);
  subplot(321), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
  a = 0.5; b = -0.5;
  %Table 3.5(6b)
  y = a*x.^b + 0.05*noise(1:Nx);
  [th,err,yi] = curve_fit(x,y,6,0,xi); [a b],th
  f = inline('th(1)*x.^th(2)','th','x');
  th0 = [0 0]; [th,err] = lsqcurvefit(f,th0,x,y), yi1 = f(th,xi);
  sub
  plot(322), plot(x,y,'*', xi,yi,'k', xi,yi1,'r')
end
%(cf) If there is no theoretical basis on which we can infer the physical relation
%between the variables, how do we determine the candidate function suitable
%for fitting the data pairs? We can plot the graph of data pairs and choose one
%of the graphs in Fig. P3.11 which is closest to it and choose the corresponding
%template function as the candidate fitting function.

%3.12 Two-Dimensional Interpolation
%Compose a routine “z = find_depth(xi,yi)” that finds the depth z of a
%geological stratum at a point (xi,yi) given as the input arguments, based
%on the data in Problem 1.4.

%(cf) If you have no idea, insert just one statement involving ‘interp2()' into
%the program ‘nm1p04.m' (Problem 1.4) and fit it into the format of a MAT-
%LAB function.
%3.13 Polynomial Curve Fitting by Least Squares and Persistent Excitation
%Suppose the theoretical (true) relationship between the input x and the
%output y is known as
%y =x+2
%(P3.13.1)
%Charley measured the output data y 10 times for the same input value
%x = 1 by using a gauge whose measurement errors has a uniform distribu-
%tion U[−0.5, +0.5]. He made the following MATLAB program “nm3p13”,
%which uses the routine “polyfits()” to find a straight line fitting the data.
%(a) Check the following program and modify it if needed. Then, run the
%program and see the result. Isn't it beyond your imagination? If you use
%
%the MATLAB built-in function “polyfit()”, does it get any better?
%nm3p13.m
%
%tho = [1 2]; %true parameter
%x = ones(1,10); %the unchanged input
%y = tho(1)*x + tho(2)+(rand(size(x)) - 0.5);
%th_ls = polyfits(x,y,1); %uses the MATLAB routine in Sec.3.8.2
% polyfit(x,y,1) %uses MATLAB built-in function
%(b) Note that substituting Eq. (3.8.2) into Eq.(3.8.3) yields
























