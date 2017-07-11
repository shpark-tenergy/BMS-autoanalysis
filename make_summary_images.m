function make_summary_images(batch, batch_name, T_cells, T_policies)
% make_summary images makes the summary images for each batch. Since each
% batch will have different 'best' ways of presenting data, have
% conditional statements to identify which to use

%% Move to image directory
% cd ['C:/Users/Arbin/Box Sync/Batch images/' batch_name]

%% Q vs n for each policy
policies = cell(height(T_cells),1);
for i = 1:numel(batch)
    policies{i} = batch(i).policy;
end
disp(policies)
unique_policies = unique(policies);

map = colormap('jet(32)');
figure('units','normalized','outerposition',[0 0 1 1]), hold on, box on
for i = 1:length(unique_policies)
    % Keep consistent color
    [col, mark] = random_color('y','y');
    % Find all cells with policy i
    for j = 1:numel(batch)
        if strcmp(unique_policies{i}, batch(j).policy)
            x = batch(j).summary.cycle;
            y = batch(j).summary.QDischarge;
            plot(x,y,'o','color',col)
        end
    end
end
xlabel('Cycle number')
ylabel('Remaining discharge capacity (Ah)')
ylim([0.85 1.1])
leg = legend(unique_policies); leg.Location = 'eastoutside';
print('summary1_Q_vs_n','-dpng')

%% Make different summary plots for each batch
% Batch 1 (2017-05-12)
if batch_name == 'batch1'
    batch1_summary_plots(batch, batch_name, T_cells, T_policies)
% Batch 2 (2017-06-30)
elseif batch_name == 'batch2'
    batch2_summary_plots(batch, batch_name, T_cells, T_policies)
else
    warning('Batch name not recognized. No summary figures generated')
end

% cd 'C:/Users/Arbin/Documents/GitHub/BMS-autoanalysis'

end