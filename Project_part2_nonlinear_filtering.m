I1 = imread('food1.jpg');

I1 = double(I1)/255.0;

I2 = rgb2gray(I1);

%salt-and-pepper noise
I2=imnoise(I2,'salt & pepper',0.1);
[M,N] = size(I2);
I3 = zeros(M,N);
figure
imshow(I2);
title('gray I1');



P=2;
Q=2;
filterPixels = (2*P+1)*(2*Q+1);

Med = zeros(1,filterPixels);
doubleMed = double(Med);


for m = 1 : M
    for n = 1 : N
        r = 1;
        for p = -P : P
            
            if(m-p <= 1)
                k = abs(m-p)+1;
            elseif(m-p>M)
                k = M-((m-p)-M);
            else
                k = m-p;
            end
        
            for q = -Q : Q
                if(n-q < 1)
                    l = abs(n-q)+1;
                elseif (n-q > N)
                    l = N-((n-q)-N);
                else
                    l = n-q;
                end

                doubleMed(1,r) = I1(k,l); 
                r = r+1;
            end
        end
        
        I3(m,n) = median(doubleMed);
 
    end
end

figure
imshow(I3);
title('Med_Filter');


