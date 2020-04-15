M=input('Enter M : ');
N=input('Enter N : ');

h=zeros(M,N,M,N);
g = zeros(M,N);
%generate random numbers in the range 0.0 to 100.0 to fill up h and f
f= randi([0.0,100.0],M,N);

for u = 1 : M
    for v = 1 : N
        for m = 1 : M
           for n = 1 : N
               h(u,v,m,n) = randi([0.0,100.0]);
               g(u,v) = g(u,v) + h(u,v,m,n)*f(m,n);
           end
        end
    end
end

disp(g);
