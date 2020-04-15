M=input('Enter M : ');
N=input('Enter N : ');
g = zeros(M,N);
g1= zeros(M,N);
%generate random numbers in the range 0.0 to 100.0 to fill up h and f
f= randi([0.0,100.0],M,N);

h1c= randi([0.0,100.0],M,M);
h2c= randi([0.0,100.0],N,N);
for m = 1 : M
    for v = 1 : N
        for n = 1 : N
            if(v-n~=0)
                g1(m,v) = g1(m,v) + h2c(mod((v-n+N),N))*f(m,n);
            end
        end
    end
end
for v = 1 : N
    for m = 1 : M
       for u = 1 : M
           if(u-m~=0)
               g(u,v) = g(u,v) + h1c(mod((u-m+M),M))*g1(m,v);
           end
       end
    end
end

disp(g);
