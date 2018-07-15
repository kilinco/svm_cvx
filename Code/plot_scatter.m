function scatter_figure = plot_scatter(X,Y, visible)
    oneindices = find(Y==1);
    minusoneindices = find(Y==-1);
    Xones = X(oneindices,:);
    Xminusones = X(minusoneindices,:);
    if visible == true
        scatter_figure = figure;
    else
        scatter_figure = figure('visible','off');
    end
    scatter(Xones(:,1),Xones(:,2));
    hold on;
    scatter(Xminusones(:,1),Xminusones(:,2));
    hold on;
end
