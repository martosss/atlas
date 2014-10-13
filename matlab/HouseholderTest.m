clear all;
tic;

% Inputs
dim = 7;

% UNCOMMENT THIS CODE BLOCK TO DYNAMICALLY CREATE SYMMETRIC TOEPLITZ
% MATRICES. DON'T FORGET THE COMMENT OUT THE A MATRICES BELOW!
%
% diagRadius = 3;
% 
% Build symmetric Toeplitz
% temp = rand(1, (diagRadius+1));
% for i=(diagRadius + 2):dim
%     temp = [temp 0];
% end
% A = toeplitz(temp);
% 
% clear temp diagRadius;

% A = [ 4 1 -2 2;
%       1 2 0 1;
%       -2 0 3 -2;
%       2 1 -2 -1; ];
%   
% A = [   0.78 0.39 0.84 0.00;
%         0.39 0.78 0.39 0.84;
%         0.84 0.39 0.78 0.39;
%         0.00 0.84 0.39 0.78; ]

A = [   0.84 0.39 0.78 0.00 0.00 0.00 0.00;
        0.39 0.84 0.39 0.78 0.00 0.00 0.00;
        0.78 0.39 0.84 0.39 0.78 0.00 0.00;
        0.00 0.78 0.39 0.84 0.39 0.78 0.00;
        0.00 0.00 0.78 0.39 0.84 0.39 0.78;
        0.00 0.00 0.00 0.78 0.39 0.84 0.39;
        0.00 0.00 0.00 0.00 0.78 0.39 0.84; ]
%     
% A = [
%     0.9649    0.1576    0.9706         0         0         0         0         0         0         0;
%     0.1576    0.9649    0.1576    0.9706         0         0         0         0         0         0;
%     0.9706    0.1576    0.9649    0.1576    0.9706         0         0         0         0         0;
%          0    0.9706    0.1576    0.9649    0.1576    0.9706         0         0         0         0;
%          0         0    0.9706    0.1576    0.9649    0.1576    0.9706         0         0         0;
%          0         0         0    0.9706    0.1576    0.9649    0.1576    0.9706         0         0;
%          0         0         0         0    0.9706    0.1576    0.9649    0.1576    0.9706         0;
%          0         0         0         0         0    0.9706    0.1576    0.9649    0.1576    0.9706;
%          0         0         0         0         0         0    0.9706    0.1576    0.9649    0.1576;
%          0         0         0         0         0         0         0    0.9706    0.1576    0.9649;
% ]
% 
% A = [
%     0.9572    0.4854    0.8003    0.1419         0         0         0         0         0         0;
%     0.4854    0.9572    0.4854    0.8003    0.1419         0         0         0         0         0;
%     0.8003    0.4854    0.9572    0.4854    0.8003    0.1419         0         0         0         0;
%     0.1419    0.8003    0.4854    0.9572    0.4854    0.8003    0.1419         0         0         0;
%          0    0.1419    0.8003    0.4854    0.9572    0.4854    0.8003    0.1419         0         0;
%          0         0    0.1419    0.8003    0.4854    0.9572    0.4854    0.8003    0.1419         0;
%          0         0         0    0.1419    0.8003    0.4854    0.9572    0.4854    0.8003    0.1419;
%          0         0         0         0    0.1419    0.8003    0.4854    0.9572    0.4854    0.8003;
%          0         0         0         0         0    0.1419    0.8003    0.4854    0.9572    0.4854;
%          0         0         0         0         0         0    0.1419    0.8003    0.4854    0.9572;  
% ]

for b=0:(dim-3)
    % Compute Householder parameters
    alpha = -sign(A(2+b,1+b))*norm(A(2+b:dim,1+b));
    r = sqrt((alpha^2 - A(2+b,1+b)*alpha) / 2);

    % Compute householder vector
    v = zeros(1,dim-b);
    v(2) = (A(2+b,1+b) - alpha) / (2*r);
    if((dim-b) >= 3)
        for k=3:(dim-b)
            v(k) = A(k+b,1+b) / (2*r);
        end
    end

    % Compute Q
    Q = eye(dim-b) - 2*transpose(v)*v;

    % Compute new elements of A
    A(1+b:dim, 1+b:dim) = Q*A(1+b:dim, 1+b:dim)*Q;
end
A

toc
clear Q alpha b dim i k r v;