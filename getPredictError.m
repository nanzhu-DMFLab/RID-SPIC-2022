function PredictError=getPredictError(V,H,D1,D2,threshold,Direction) 
% Calcualting prediction error maps

% V,H,D1,D2: Output of funtion getSecondDiff 
% threshold: used for noise removal
% Direction: the number of directions for calculating prediction error maps

if Direction==1
    PredictError=CalError(V,H,D1,D2,threshold);
elseif Direction==2
    PredictError1=CalError(V,H,D1,D2,threshold);
    PredictError2=CalError(H,V,D1,D2,threshold);
    PredictError=cat(3,PredictError1,PredictError2);
elseif Direction==3
    PredictError1=CalError(V,H,D1,D2,threshold);
    PredictError2=CalError(H,V,D1,D2,threshold);
    PredictError3=CalError(D1,V,H,D2,threshold);
    PredictError=cat(3,PredictError1,PredictError2,PredictError3);
elseif Direction==4
    PredictError1=CalError(V,H,D1,D2,threshold);
    PredictError2=CalError(H,V,D1,D2,threshold);
    PredictError3=CalError(D1,V,H,D2,threshold);
    PredictError4=CalError(D2,V,H,D1,threshold);
    PredictError=cat(3,PredictError1,PredictError2,PredictError3,PredictError4);
end

function ErrorMap=CalError(M1,M2,M3,M4,threshold)

[m,n,z]=size(M1);

ErrorMap=[];

for channel=1:z
    Q=[reshape(abs(M2(:,:,channel)),m*n,1), reshape(abs(M3(:,:,channel)),m*n,1), reshape(abs(M4(:,:,channel)),m*n,1)];
    v=reshape(abs(M1(:,:,channel)),m*n,1);
    
    v_less_thres=(v<threshold);
    Q_less_thres=(sum((Q<threshold),2))>0;
    index_thres=(v_less_thres+Q_less_thres)>0;          
    v(index_thres)=0;
    Q(index_thres,:)=0;
        
    w=(Q'*Q)\(Q'*v);        
        
    Error=log2(v+eps)-log2(abs(Q*w)+eps);  
    %Error=v-Q*w;
    Error=reshape(Error,m,n);
        
    ErrorMap=cat(3,ErrorMap,Error);
end

