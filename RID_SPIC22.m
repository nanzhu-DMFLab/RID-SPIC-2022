function features=RID_SPIC22(image)
% main function
% image: a RGB image's name

threshold=3/255;
Direction=3;

f=double(imread(image))/255;  

[m,n,z] = size(f);

if z==1
    disp('The input image must be color image')
    features=[];
    return
end
    
HSV = rgb2hsv(f); 
[V,H,D1,D2] = getSecondDiff(HSV);   % second order difference

PredictError=getPredictError(V,H,D1,D2,threshold,Direction);

features_1=[];
for i=1:size(PredictError,3)
    features_1=[features_1,getLTC_down(PredictError(:,:,i))];   
end

% calculate average pooled image 

if mod(m,2)==0
    m=m-1;
end
if mod(n,2)==0
    n=n-1;
end
for k=1:3
    AvgPoolImage(:,:,k)=(HSV(2:2:m,2:2:n,k)+HSV(2:2:m,3:2:n,k)+HSV(3:2:m,2:2:n,k)+HSV(3:2:m,3:2:n,k))/4;
end

[V,H,D1,D2] = getSecondDiff(AvgPoolImage);   

PredictError=getPredictError(V,H,D1,D2,threshold,Direction);

features_2=[];
for i=1:size(PredictError,3)
    features_2=[features_2,getLTC_down(PredictError(:,:,i))];   
end

features=[features_1,features_2];
