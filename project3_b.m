M=input('Enter M : ');
N=input('Enter N : ');

g = zeros(M,N);
g1 = zeros(M,N);
h2 = zeros(N,N);
h1 = zeros(M,M);

%generate random numbers in the range 0.0 to 100.0 to fill up h and f
f = randi([0.0,100.0],M,N);

%cal
for v = 1 : N
    for m = 1 : M
         for n = 1 : N
            h2(v,n) = randi([0.0,100.0]);
            g1(m,v) = g1(m,v) +h2(v,n)*f(m,n);
         end
    end
end
for u = 1 : M
    for v = 1 : N
       for m = 1 : M   
           
           h1(u,m) = randi([0.0,100.0]);
           g(u,v) = g(u,v)+h1(u,m)*g1(m,v);
       end
    end
end

disp(g);