function svm_figure = plot_svm(X1, X2, X, Y, Y_miss1, Y_miss2, predictions, mtitle, visible)
    scat_fig = plot_scatter(X, Y, visible);
    if visible == true
        svm_figure = figure(scat_fig);
    else
        svm_figure = figure(scat_fig);
        set(svm_figure,'visible','off');
    end
    hold on
    scatter(X(Y_miss1, 1), X(Y_miss1, 2), 'filled', 'MarkerFaceColor',[1.0 0.0 0]);
    hold on
    scatter(X(Y_miss2, 1), X(Y_miss2, 2), 'filled', 'MarkerFaceColor',[1.0 1.0 0]);
    hold on
    contour(X1, X2, predictions, [1 1], 'Color', 'b')
    title(mtitle)
    legend('Class 0', 'Class 1', 'Misclassified from Class 0', 'Misclassified from Class 1')
    xlabel('x');
    ylabel('y');
end
