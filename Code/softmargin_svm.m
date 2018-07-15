function model = softmargin_svm(X,Y,C,sigma)

% Soft Margin SVM (Using Soft dual for 1 Norm for slack variables)

K=X*X'; % Dot-product kernel

% N = size(X,1);
% K = zeros(N,N);
% for i=1:N % RBF kernel
%     for j = 1:N
%             K(i,j) = exp(-1*sum((X(i,:)-X(j,:)).^2)/(2*(sigma)^2));
%     end 
% end

N = size(X,1);

cvx_begin
    cvx_precision best
    variable a_m(N);
    minimize (0.5.*quad_form(Y.*a_m,K) - ones(N,1)'*(a_m));
    subject to
        a_m >= 0;
        Y'*(a_m) == 0;
        a_m <= C;
cvx_end

a_m(a_m<10^-5)=0;
X_m = X(a_m>0,:);
Y_m = Y(a_m>0);
a_m = a_m(a_m>0);

% K=zeros(length(X(:,1)),length(X_m(:,1)));
% for i=1:length(X(:,1))% RBF kernel
%     for j = 1:length(X_m(:,1))
%             K(i,j) = exp(-1*sum((X(i,:)-X_m(j,:)).^2)/(2*(sigma)^2));
%     end 
% end

K=X*X_m';

b_m = mean(Y-K*(a_m.*Y_m));

model = getModel(X_m, Y_m, a_m, b_m, sigma, "soft");

end
