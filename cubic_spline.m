function f = cubic_spline(data,n,extra)
%CUBIC_SPLINE computes the cubic interpolation of the data points solving
%TDMA using Thomas algorithim 
%   Detailed explanation goes here
      %  Input:  data: (x,y) points of arbitrary length with even or uneven spacing.
                    % x and y are scalars.
                    % Data points are assumed to be given in ascending order of x values in the ordered pair 
                    % expected input of the form given as [x0 x1 x2...; y0 y1 y2 ...]
                 
                % n: the number of interpolations required between the smallest and the largest x values 

       % OUTPUT: y_inter: n points interpolated between the range of data
       % point given
    x0=data(1,:);
    y0=data(2,:);
    delta= diff(x0);
    
    B=[];
    a=[];
    b=[];
    c=[];
    for i=1:length(delta)-1
        B(i,1)=(y0(i+2)-y0(i+1))/delta(i+1)+(-y0(i+1)+y0(i))/delta(i);
        if i==1
            a(i)=0;
            b(i)=(delta(i)+delta(i+1))/3;
            c(i)=(delta(i+1))/6;
        elseif i==length(delta)-1
            b(i)=(delta(i)+delta(i+1))/3;
            a(i)=(delta(i))/6;
            c(i)=0;
        else
            a(i)=(delta(i))/6;
            b(i)=(delta(i)+delta(i+1))/3;
            c(i)=(delta(i+1))/6;
        end
    end
    
    
    % LU decomposition
    
    d=[];             %diagonal elements of the Upper matrix
    u=[];             %Upper elements of the Upper matrix 
    l=[];             %lower elements of the lower matrix 
    
    d(1)=b(1);
    u(1)=c(1);
    
    for i=2:length(delta)-1
        l(i)=a(i)/d(i-1);
        d(i)=b(i)-l(i)*u(i-1);
        u(i)=c(i);
    end
    
    % forward  substituiton 
    Y=[B(1)];
    for i=2:length(delta)-1
        Y(i)=B(i)-l(i)*Y(i-1);
    end
    
    
    % backward  substituiton 
    
    X(length(delta))=Y(end)/d(end);
    for i=length(delta)-2:-1:1
        X(i+1)=(Y(i)-u(i)*X(i+2))/d(i);
    end
    X(1)=0;
    X(end+1)=0;
    
    
    x_inter=linspace(min(x0),max(x0),n);
    y_inter=[];
    ind=0;
    for i=1:length(delta)
        if i==1                  %if it is the first segment of the interpolation: x1-x2
            k=find(x_inter <= x0(2), 1, 'last');
            x1=x_inter(1:k);
            y_inter(i:k)= X(1)/6.*(((x0(2)-x1).^3)/delta(1) -delta(1)*(x0(2)-x1)) + X(2)/6.*(((x1-x0(1)).^3)/delta(1) -delta(1)*(x1-x0(1))) + y0(1).*(x0(2)-x1)/delta(1) + y0(2).*(x1-x0(1))/delta(1);
            ind=3;
        else                    %for other segments of the interpolation:
            k2=find(x_inter <= x0(ind), 1, 'last');
            x1=x_inter(k+1:k2);
            y_inter(k+1:k2)= X(i)/6.*(((x0(i+1)-x1).^3)/delta(i) -delta(i)*(x0(i+1)-x1)) + X(i+1)/6.*(((x1-x0(i)).^3)/delta(i) -delta(i)*(x1-x0(i))) + y0(i).*(x0(i+1)-x1)/delta(i) + y0(i+1).*(x1-x0(i))/delta(i);
            
            if i==length(delta)
                if nargin==3       %if there is a need for extrapolation 
                    extrapolated= X(i)/6.*(((x0(i+1)-extra).^3)/delta(i) -delta(i)*(x0(i+1)-extra)) + X(i+1)/6.*(((extra-x0(i)).^3)/delta(i) -delta(i)*(extra-x0(i))) + y0(i).*(x0(i+1)-extra)/delta(i) + y0(i+1).*(extra-x0(i))/delta(i)
                    fprintf('Extrapolated point: (x,y) = (%5.1f ,%10.5f\n',extra,extrapolated)
                end
            end
            k=k2;
            ind=ind+1;
        end
    end

    
    m=char('g1');
    for i=2:length(delta)
        c=char(strcat("g",string(i)));
        m=char(c,m)
    end
    m(2,:)
    for i=1:length(delta)
        eval([m(length(delta)+1-i,:) '= @ (x) X(i)/6.*(((x0(i+1)-x).^3)/delta(i)-delta(i)*(x0(i+1)-x)) + X(i+1)/6.*(((x-x0(i)).^3)/delta(i) -delta(i)*(x-x0(i))) + y0(i).*(x0(i+1)-x)/delta(i) + y0(i+1).*(x-x0(i))/delta(i)' ])
    end
 
    f = cell(length(delta),1);
    for i=1:length(delta)
        f{i}= eval(m(length(delta)+1-i,:))
    end
    
% eval([b(5,:) '= @(x) (x-1) + (x-2)'])




end

