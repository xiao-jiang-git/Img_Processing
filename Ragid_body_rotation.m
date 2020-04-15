I1 = imread('food1.jpg');
[M, N, C] = size(I1);  % M: Num. of Rows , N : Num. of Columns , C : Num. of color bands= 3
figure  % start a new figure
imshow(I1);  % display image of I1 in figure
title('image I1');  % title of figure

I3 = double(I1)/255.0;

prompt = 'What is the rotation degree? ';
theta = input(prompt);

prompt2 = 'please enter a matrix like [2,1] ';
T = input(prompt2);


A = [  cosd(theta) -sind(theta)
      sind(theta)  cosd(theta) ];
    
T= T';

p = A * ([ 1 1 ]'-T) + T; % first corner point
x1=p(1);
y1=p(2);
p= A * ([ 1 N ]'-T) + T; % second corner point
x2=p(1);
y2=p(2);
p= A * ([ M 1 ]'-T) + T; % third corner point
x3=p(1);
y3=p(2);
p= A * ([ M N ]'-T) + T; % fourth corner point
x4=p(1);
y4=p(2);

xmin = floor( min( [ x1 x2 x3 x4 ] ));
xmax = ceil( max( [ x1 x2 x3 x4 ] ));
ymin = floor(min( [ y1 y2 y3 y4 ] ));
ymax = ceil(max( [ y1 y2 y3 y4 ] ));
Mp=ceil(xmax-xmin)+1; % number of rows
Np=ceil(ymax-ymin)+1; % number of columns

I2=zeros(Mp,Np,3); % output color image


Ap = inv(A);
for i = xmin : xmax
    for j = ymin : ymax
        p = Ap * ([ i j ]'-T)+T  ;
        
        % coordinates of point where we need to find the
        % image value through interpolation. 
        x0=p(1);
        y0=p(2);
        % coordinates of nearest sample point
 
        xn = round(x0);
        yn = round(y0);

        % make sure the nearest point (xn,yn) is within the
        % input image
         if( (1<=xn) && (xn<=M) && (1<=yn) && (yn<=N) )
             
             x=round(i-xmin+1);  % shift (xmin, ymin)
                                 % pixel position (1,1)
                                 % in the output image
 
             y=round(j-ymin+1);
             
            I2(x,y,1)= I3(xn,yn,1);
            I2(x,y,2)= I3(xn,yn,2);
            I2(x,y,3)= I3(xn,yn,3);
         end
        
    end
end

figure
imshow(I2);
title('rotate')

