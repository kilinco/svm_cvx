function model = hardmargin_svm(X,Y)

% Hard Margin SVM

    K=X*X'; % Dot-product kernel
    N = size(X,1);

    cvx_begin
        cvx_precision best
        variable a_m(N);
        minimize (0.5.*quad_form(Y.*a_m,K) - ones(N,1)'*(a_m));
        subject to
            a_m >= 0;
            Y'*(a_m) == 0;
    cvx_end

    a_m(a_m<10^-5)=0;
    X_m = X(a_m>0,:);
    Y_m = Y(a_m>0);
    a_m = a_m(a_m>0);
    K=X*X_m';
    b_m=mean(Y-K*(a_m.*Y_m));
    
    model = getModel(X_m, Y_m, a_m, b_m, 0, "hard")
end
