I1 = imread('food1.jpg');

I1 = double(I1)/255.0;

I2 = rgb2gray(I1);

[M,N] = size(I2);

figure
imshow(I2);
title('gray I1');

H = zeros(M,N);
P = zeros(M,M);
Q = zeros(N,N);
P1 = zeros(M,M);
Q1 = zeros(N,N);
j = sqrt(-1);

%cal

for u = 1 : M
    for v = 1 : N
        if(u<5&&v<5||u>(M-5)&&v<5||u<5&&v>(N-5)||u>(M-5)&&v>(N-5))
            H(u,v) = 0.5;
        else
            H(u,v) = 1.0;
        end
    end
end

for u = 1 : M
   for m = 1 : M   
       P(u,m) = (1/M)*(exp(-j*2*pi*(u*m/M)));
   end
end  
    
 for v = 1 : N
     for n = 1 : N
        Q(v,n) = (1/N)*(exp(-j*2*pi*(v*n/N)));
     end
 end
for u = 1 : M
   for m = 1 : M   
       P1(u,m) = (exp(j*2*pi*(u*m/M)));
   end
end

 for v = 1 : N
     for n = 1 : N
         Q1(v,n) = (exp(j*2*pi*(v*n/N)));
     end
 end


%DFT
F = P*I2*Q;

G = H.*F;

%IDFT

f = P1*G*Q1;

figure
imshow(f);
title('after IDFT');
