I1 = imread('food1.jpg');
I1 = double(I1)/255.0;
I2 = rgb2gray(I1);

%salt-and-pepper noise
I2=imnoise(I2,'salt & pepper',0.1);
[M,N] = size(I2);
%new empty img
I3 = zeros(M,N);
figure
imshow(I2);
title('gray I1');

% 3x3 KNN filter, we define k=4
k = 4;
size = 3;
dist = [1,(size*size)];
for i = 1:M-size+1
    for j = 1:N-size+1
        %get the 3x3 matrix from the original img
        oriPixel = I2(i:(i+size)-1, j:(j+size)-1);
        centerPointPixel = oriPixel(2,2);
        point = 1;
        %use 1*9 matrix to do sort
        keyMatrix = abs(oriPixel-centerPointPixel);
        dist = reshape(keyMatrix, 1,size*size);
        dist(1,ceil((size*size)/2)) = -2;
        [sortDist, sortIndex] = sort(dist);
        % get the mean of nearlyest point
        KNNboxmean = mean(oriPixel(sortIndex(2:k+1)));
        I3(i+(size-1)/2,j+(size-1)/2) = KNNboxmean;
        
    end
end

figure
imshow(I3);
title('KNN_Filter');
        
        
                
        