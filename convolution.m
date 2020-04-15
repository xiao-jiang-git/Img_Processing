I1 = imread('food1.jpg');
I1 = double(I1)/255.0;
I2 = rgb2gray(I1);
[M,N] = size(I2);
I3 = zeros(M,N);
figure
imshow(I2);
title('gray I1');

P = 2;
Q = 2;
r = randi([1,5]);
sita = randi([1,5]);
h=zeros(2*P+1,2*Q+1);

for m = 1:M
    for n = 1:N
        sum = 0.0;
        for p = -P:P
            if (m-p< 1)
                k = abs(m-p)+1;
            elseif (m - p > M)
                k = M-1-((m-p) - (M-1));
            else
                k = m-p;
            end

            for q = -Q:Q
                if (n-q < 1)
                    l = abs(n-q)+1;
                elseif (n - q > N)
                    l = N-((n-q)-N);
                else
                    l = n-q;
                end
                
                q1 = q+3;
                p1 = p+3;
                
                if((p1^2+q1^2)<(r^2))
                    h(p1,q1) = 1/(pi * r^2);
                else
                    h(p1,q1) = 0;
                end
                
                % This is:
                %Gaussian with parameter sigma in the range 1.0 to 5.0 pixels
                %h(p1,q1) = (exp(-(p1^2)/2*(sita^2))/(sqrt(2*pi)*sita))*(exp(-(q1^2)/2*(sita^2))/(sqrt(2*pi)*sita));
                sum = sum + h(p1,q1) * I1(k,l);
            end
        end
        I3(m,n) = sum;
    end
end
        
figure
imshow(I3);
title('');              