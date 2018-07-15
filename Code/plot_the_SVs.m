function plot_the_SVs(X, Y, model, mtitle, filename, visible)
%PLOT_THE_SVS Summary of this function goes here
%   Detailed explanation goes here
    scat_fig = plot_scatter(X, Y, visible);
    if visible == true
        svm_figure = figure(scat_fig);
    else
        svm_figure = figure(scat_fig);
        set(svm_figure,'visible','off');
    end
    hold on
    scatter(model.X((model.Y == -1),1), model.X((model.Y == -1),2), 'filled', 'MarkerFaceColor',[1.0 0.0 0]);
    hold on
    scatter(model.X((model.Y == 1),1), model.X((model.Y == 1),2), 'filled', 'MarkerFaceColor',[1.0 1.0 0]);
    title(mtitle)
    legend('Class 0', 'Class 1', 'SV from Class 0', 'SV from Class 1')
    xlabel('x');
    ylabel('y');
    if filename ~= ""
        saveas(gca, filename, "jpeg");
    end    
end

