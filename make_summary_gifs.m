function make_summary_gifs(batch, batch_name)
% make_summary_gifs makes the summary gifs for each batch. Since each
% batch will have different 'best' ways of presenting data, we use
% conditional statements to identify which to use

disp('Starting make_summary_gifs'), tic

%% CHANGE THESE SETTINGS - development mode
filename = ['Qnplot_' batch_name '.gif']; % Specify the output file name
endcycle = 1000; % Last cycle plotted

%% Move to GIF directory
% cd 'C:\Users\Arbin\Box Sync\Data\Batch GIFS\'

%% Find all unique policies
n_cells = numel(batch);
policies = cell(n_cells,1);
readable_policies = cell(n_cells,1);
for i = 1:n_cells
    policies{i} = batch(i).policy;
    readable_policies{i}=batch(i).policy_readable;
end
unique_policies = unique(policies);
unique_readable_policies = unique(readable_policies);
n_policies = numel(unique_policies);

%% Preinitialize random colors and markers. 
% % Random colors: Updated to use 'pretty colors' (linspecer.m)
% cols = linspecer(n_policies);
% ordering = randperm(n_policies);
% cols = cols(ordering, :); % shuffle
% Distinguishable colors: Colors with maximum contrast
% (distinguishable_colors.m)
cols = distinguishable_colors(n_policies);

% Random markers
marks = cell(1,n_policies);
for i = 1:n_policies
    [~, mark]=random_color('y','y');
    marks{i} = mark;
end

%% Create 'Q' array - cell array of cell arrays
% Q = 1xn cell, where n = number of policies
% Q{1,1} = 1xm cell, where m = number of cells tested for this policy
Q = cell(1,n_policies);
for i = 1:n_policies % loop through all policies
    numcells = 0;
    for j = 1:n_cells % cell index
        if strcmp(unique_policies{i}, batch(j).policy)
            numcells = numcells + 1;
        end
    end
    Q{i} = cell(1,numcells);
    
    j = 1; % cell index
    k = 1; % cell = policy index
    while k < numcells + 1
        if strcmp(unique_policies{i}, batch(j).policy)
            Q{i}(k) = {batch(j).summary.QDischarge};
            k = k + 1;
        end
        j = j + 1;
    end
end

%% Make full screen figure
figure('units','normalized','outerposition',[0 0 1 1]), box on
xlabel('Cycle number','FontSize',16)
ylabel('Remaining capacity (normalized)','FontSize',16)
set(gca,'FontSize',16)
% ylabel('Remaining discharge capacity (Ah)')
axis([0 1000 0.79 1.0]) % y = 0.85 -> 1.15
set(gcf, 'Color' ,'w')
hline(0.8)

%% Begin looping. j = cycle index
for j=1:endcycle
    % i = policy index
    for i=1:n_policies
        %% Plot each policy 
        hold on
        
        cycles = j.*ones(1,length(Q{i}));
        Qn = zeros(1,length(Q{i})); % preinitialize capacity at cycle n (Qn)
        % k = index of cells within a policy
        for k = 1:length(Q{i})
            % If cell has died, we won't have data at this cycle number.
            % Just plot the last cycle
            if length(Q{i}{k}) < j
                Qn(k) = Q{i}{k}(end);
            else
                Qn(k) = Q{i}{k}(j);
            end
        end
        
        % Plot points for this policy
        scatter(cycles,Qn./1.1,100,cols(i,:),marks{i},'LineWidth',1.5);
    end
    % Misc plotting stuff
    title(['Cycle ' num2str(j)],'FontSize',16)
    %leg = columnlegend(2,unique_readable_policies,'Location','NortheastOutside','boxoff');
    leg = legend(unique_readable_policies','Location','EastOutside','FontSize',14);
    hold off
    
    % Create GIF
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if j == 1
        imwrite(imind,cm,filename,'gif','Loopcount',1);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.03);
    end
end

% %% Make different summary plots for each batch
% % Batch 1 (2017-05-12)
% if batch_name == 'batch1'
%     batch1_summary_plots(batch, batch_name, T_cells, T_policies)
% % Batch 2 (2017-06-30)
% elseif batch_name == 'batch2'
%     batch2_summary_plots(batch, batch_name, T_cells, T_policies)
% else
%     warning('Batch name not recognized. No summary figures generated')
% end

close all
%cd 'C:/Users/Arbin/Documents/GitHub/BMS-autoanalysis'

disp('Completed make_summary_gifs'),toc

end