function [V,H,D1,D2] = getSecondDiff(Matrix)
% Calculating second order difference maps

[m,n,~]=size(Matrix);

central=Matrix(2:m-1,2:n-1,:);
left_upper=Matrix(1:m-2,1:n-2,:);
upper=Matrix(1:m-2,2:n-1,:);
right_upper=Matrix(1:m-2,3:n,:);
right=Matrix(2:m-1,3:n,:);
right_lower=Matrix(3:m,3:n,:);
lower=Matrix(3:m,2:n-1,:);
left_lower=Matrix(3:m,1:n-2,:);
left=Matrix(2:m-1,1:n-2,:);

V=2*central-upper-lower;
H=2*central-left-right;
D1=2*central-left_upper-right_lower;
D2=2*central-right_upper-left_lower;
