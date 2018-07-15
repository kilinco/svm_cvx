function predictions = svmPredict(X, model)
    if model.type == "hard"
        predictions = X*model.X'*(model.a.*model.Y) - model.b > 0;
    end    
    if model.type == "soft"
%         K=zeros(length(X(:,1)),length(model.X(:,1)));
%         for i=1:length(X(:,1))% RBF kernel
%             for j = 1:length(model.X(:,1))
%                 K(i,j) = exp(-1*sum((X(i,:)-model.X(j,:)).^2)/(2*(model.s)^2));
%             end 
%         end        
        K=X*model.X';
        predictions = K*(model.a.*model.Y)-model.b>0;
    end
    if model.type == "nonlinear"
    K=zeros(length(X(:,1)),length(model.X(:,1)));
    for i=1:length(X(:,1))% RBF kernel
        for j = 1:length(model.X(:,1))
               K(i,j) = exp(-1*sum((X(i,:)-model.X(j,:)).^2)/(2*(model.s)^2));
           end
       end
       predictions = K *(model.a.*model.Y) - model.b>0;
    end
end