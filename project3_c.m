M=input('Enter M : ');
N=input('Enter N : ');

hc=zeros(M,N);
g = zeros(M,N);
%generate random numbers in the range 0.0 to 100.0 to fill up h and f
f= randi([0,100],M,N);

for u = 1 : M
    for v = 1 : N
        for m = 1 : M
           for n = 1 : N
               hc(m,n) = randi([0.0,100.0]);
               if(u-m~=0&& v-n~=0)   
                   g(u,v) = g(u,v) + hc(m,n)*f(mod((u-m+M),M),mod((v-n+N),N));
               end      
           end
        end
    end
end

disp(g);