function accuracy = svmPredictPlot(X, Y, model, title, filename, visible, showSVs)
    x1plot = linspace(min(X(:,1)), max(X(:,1)), 500)';
    x2plot = linspace(min(X(:,2)), max(X(:,2)), 500)';
    [X1, X2] = meshgrid(x1plot, x2plot);
    predictions = zeros(size(X1));
    for i = 1:size(X1, 2)
       this_X = [X1(:, i), X2(:, i)];
       predictions(:, i) = svmPredict(this_X, model);
    end
    main_pred = (double(svmPredict(X, model))*2-1);
    accuracy = mean(main_pred==Y);
    misses = find(main_pred ~= Y);
    Y_miss1 = misses(Y(misses) == 1);
    Y_miss2 = misses(Y(misses) == -1);
    fig = plot_svm(X1, X2, X, Y, Y_miss1, Y_miss2, predictions, title, visible);
    if showSVs == true
        if visible == true
            fig = figure(fig);
        else
            fig = figure(fig);
            set(fig,'visible','off');
        end
        if ~isempty((model.Y == -1))
            hold on
            scatter(model.X((model.Y == -1),1), model.X((model.Y == -1),2), 'filled', 'MarkerFaceColor',[0.5 0.4 0.3]);
            legend('Class 0', 'Class 1', 'Misclassified from Class 0', 'Misclassified from Class 1', 'SV from Class 0')
        end
        if ~isempty((model.Y == 1))
            hold on
            scatter(model.X((model.Y == 1),1), model.X((model.Y == 1),2), 'filled', 'MarkerFaceColor',[0.3 0.4 0.5]);
            legend('Class 0', 'Class 1', 'Misclassified from Class 0', 'Misclassified from Class 1', 'SV from Class 1')
        end        
        if ~isempty((model.Y == -1)) && ~isempty((model.Y == 1))
            legend('Class 0', 'Class 1', 'Misclassified from Class 0', 'Misclassified from Class 1', 'SV from Class 0', 'SV from Class 1')
        end
    end
    if filename ~= ""
        saveas(fig, filename, "jpeg");
    end    
end