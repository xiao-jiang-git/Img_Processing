


I1 = imread('food1.jpg');
[M, N, C] = size(I1);  % M: Num. of Rows , N : Num. of Columns , C : Num. of color bands= 3
 

 
I6 = double(I1)/255.0;
figure  % start a new figure
imshow(I6);  % display image of I1 in figure
title('double I1');  % title of figure
 
I2 = rgb2gray(I1);
figure
imshow(I2);
title('gray I1');


%
% Test input is for rotation , scaling x-axis, and translation T
%

theta=60.0;
A = [ 0.5 * cosd(theta) -sind(theta)
      sind(theta)  cosd(theta) ];
    
T= [ 10 5 ]'; % change this for translations
 
% In Affine transform, straight lines map to 
% straight lines. 
% Therefore, first map corner points (1,1),
% (M,1), (1,N), and (M,N)
 
p = A * [ 1 1 ]' + T; % first corner point
x1=p(1);
y1=p(2);
p= A * [ 1 N ]' + T; % second corner point
x2=p(1);
y2=p(2);
p= A * [ M 1 ]' + T; % third corner point
x3=p(1);
y3=p(2);
p= A * [ M N ]' + T; % fourth corner point
x4=p(1);
y4=p(2);

% Determine background image size (excluding translation)
xmin = floor( min( [ x1 x2 x3 x4 ] ));
xmax = ceil( max( [ x1 x2 x3 x4 ] ));
ymin = floor(min( [ y1 y2 y3 y4 ] ));
ymax = ceil(max( [ y1 y2 y3 y4 ] ));
Mp=ceil(xmax-xmin)+1; % number of rows
Np=ceil(ymax-ymin)+1; % number of columns
 
I8=zeros(Mp,Np); % output gray scale image
 
I4=zeros(Mp,Np,3); % output color image
I10 = zeros(Mp,Np,3);
I11 = zeros(Mp,Np,3);

Ap = inv(A); 
 
for i = xmin : xmax
    for j = ymin : ymax
        p = Ap * ( [ i j ]' -T );
        
        % coordinates of point where we need to find the
        % image value through interpolation. 
        x0=p(1);
        y0=p(2);
        % coordinates of nearest sample point最近采样点的坐标
        xn = round(x0);
        yn = round(y0);
        %滤波器中心的位置
        xc=x0-xn;  
        yc=y0-yn;
 
        % make sure the nearest point (xn,yn) is within the
        % input image
        if( (1<=xn) && (xn<=M) && (1<=yn) && (yn<=N) )
            %求出在旋转后的图的x，y并且要求这些点必须能和之前的图对应
            x=round(i-xmin+1); 

            y=round(j-ymin+1);

            %I4和I8是旋转后的图像
            % copy the values of nearest pixel像素点 
            I4(x,y,1)= I6(xn,yn,1);
            I4(x,y,2)= I6(xn,yn,2);
            I4(x,y,3)= I6(xn,yn,3);
            
       
            I8(x,y)=I7(xn,yn);
            I8(x,y)=I7(xn,yn);
            I8(x,y)=I7(xn,yn);
        end

        if( (1<xn) && (xn<M) && (1<yn) && (yn<N) )
            minx=floor(x0); 
            maxx=ceil(x0);
            miny=floor(y0); 
            maxy=ceil(y0);
            dx = x0-minx;
            dy = y0-miny; 
            
            s1=I6(minx,miny,:);
            s2=I6(minx,maxy,:);
            s3=I6(maxx,miny,:);
            s4=I6(maxx,maxy,:);     
            I10(x,y,:)=  bilinear(dx,dy,s1,s2,s3,s4);
        end
        
        
        
        if( (1<xn) && (xn<M) && (1<yn) && (yn<N) )
            normalization_factor = 0;
             for m1 = -2:2
                for n1 = -2:2
                    if ((1<=(xn-m1))&&((xn-m1)<=M)&&(1<=(yn-n1))&&((yn-n1)<=N))
                        normalization_factor = normalization_factor + h(m1-xc,n1-yc);
                    else
                        normalization_factor = normalization_factor + 0;
                    end
                end
             end
             
            sum = 0.0;
            for m1 = -2:2
                for n1 = -2:2
                    
                    if ((1<=(xn-m1))&&((xn-m1)<=M)&&(1<=(yn-n1))&&((yn-n1)<=N))
                        
                   
                    sampleValue = I6(xn-m1,yn-n1,:);
                    filterCoeff = (1.0/normalization_factor) * (h(m1-xc,n1-yc));

                    %sum是个3*1的数组
                    sum = (filterCoeff * sampleValue) + sum;

                    I11(x,y,:) = sum;

                    end

                end
            end
        end

    end
end
 
figure
imshow(I11);
title('Guss filter I1');
 
figure
imshow(I10);
title('Bilinear I1');
     
function[result] = h(x,y)
        result = (1/2*pi)*exp(-(x^2+y^2)/2);
end

function[result] = bilinear(dx,dy,s1,s2,s3,s4)
    x1 = (1-dx)*s1 + dx*s3;
    x2 = (1-dx)*s2 + dx*s4;
    result = (1-dy)*x1 + dy*x2;
end

