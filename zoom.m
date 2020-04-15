I1 = imread('food1.jpg');

zmf = 1.2;

[M, N, C] = size(I1);
I2 = double(I1)/255.0;
a = ceil(M*zmf);
b = floor(N*zmf);
I3 = zeros(a, b, 3);

for i = 1:M*zmf
    for j = 1:N*zmf
        p = [i,j]'/zmf;
        xo= p(1);
        yo = p(2);
        
        if( (1<xo) && (xo<M) && (1<yo) && (yo<N) )
            minx = floor(xo);
            maxx = ceil(xo);
            miny = floor(yo);
            maxy = ceil(yo);
            dx = xo-minx;
            dy = yo-miny;

            s1=I2(minx,miny,:);
            s2=I2(minx,maxy,:);
            s3=I2(maxx,miny,:);
            s4=I2(maxx,maxy,:); 
            I3(i,j,:)=  bilinear(dx,dy,s1,s2,s3,s4);
        end
    end
end


figure
imshow(I1);
title('ori');

figure
imshow(I3);
title('Zoom');



function[result] = bilinear(dx,dy,s1,s2,s3,s4)
    x1 = (1-dx)*s1 + dx*s3;
    x2 = (1-dx)*s2 + dx*s4;
    result = (1-dy)*x1 + dy*x2;
end