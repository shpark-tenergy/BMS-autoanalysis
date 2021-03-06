%% Delete bad csvs %%
% Removes tests with major experimental issues (i.e. didn't start).
% Manually added
if strcmp(batch_name, 'batch1')
    delete([path.csv_data '\' '2017-05-12_3_6C-80per_3_6C_CH4.csv'])
    delete([path.csv_data '\' '2017-05-12_3_6C-80per_3_6C_CH4_Metadata.csv']')
    delete([path.csv_data '\' '2017-05-12_4_4C-80per_4_4C_CH8.csv'])
    delete([path.csv_data '\' '2017-05-12_4_4C-80per_4_4C_CH8_Metadata.csv']')
elseif strcmp(batch_name, 'batch2')
    delete([path.csv_data '\' '2017-06-30_CH14.csv'])
    delete([path.csv_data '\' '2017-06-30_CH14_Metadata.csv']')
elseif strcmp(batch_name, 'batch3')
    delete([path.csv_data '\' '2017-08-14_2C-5per_3_8C_CH4.csv'])
    delete([path.csv_data '\' '2017-08-14_2C-5per_3_8C_CH4_Metadata.csv']')
elseif strcmp(batch_name, 'batch4')
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH4.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH4_Metadata.csv']);
    delete([path.csv_data '\' '2017-12-04_6C-10per_5c-76_7per_2C_CH25.csv']);
    delete([path.csv_data '\' '2017-12-04_6C-10per_5c-76_7per_2C_CH25_Metadata.csv']);
    % Error with sql2csv converter
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH14.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH14_Metadata.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH24.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH24_Metadata.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH36.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH36_Metadata.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH42.csv']);
    delete([path.csv_data '\' '2017-12-04_4_65C-44per_5C_CH42_Metadata.csv']);
elseif strcmp(batch_name, 'batch5')
    delete([path.csv_data '\' '2018-01-18_batch5_CH41.csv']);
    delete([path.csv_data '\' '2018-01-18_batch5_CH41_Metadata.csv']);
elseif strcmp(batch_name, 'batch7')
    delete([path.csv_data '\' '2018-02-20_batch7_CH26.csv']);
    delete([path.csv_data '\' '2018-02-20_batch7_CH26_Metadata.csv']);
elseif strcmp(batch_name, 'batch8')
    delete([path.csv_data '\' '2018-04-12_batch8_CH26.csv']);
    delete([path.csv_data '\' '2018-04-12_batch8_CH26_Metadata.csv']);
elseif strcmp(batch_name, 'oed4')
    delete([path.csv_data '\' '2018-07-29_OED4_CH17.csv']);
    delete([path.csv_data '\' '2018-07-29_OED4_CH17_Metadata.csv']);
    delete([path.csv_data '\' '2018-07-29_OED4_CH27.csv']);
    delete([path.csv_data '\' '2018-07-29_OED4_CH27_Metadata.csv']);
elseif strcmp(batch_name, 'oed_0')
    delete([path.csv_data '\' '2018-08-28_oed_0_CH17.csv']);
    delete([path.csv_data '\' '2018-08-28_oed_0_CH17_Metadata.csv']);
    delete([path.csv_data '\' '2018-08-28_oed_0_CH27.csv']);
    delete([path.csv_data '\' '2018-08-28_oed_0_CH27_Metadata.csv']);
elseif strcmp(batch_name, 'disassembly_batch')
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH5.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH5_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH39.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH39_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH45.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH45_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH46.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH46_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH47.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH47_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH48.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH48_Metadata.csv']);
    
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv2_CH42.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv2_CH42_Metadata.csv']);
    
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv2_CH43.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv2_CH43_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv2_CH44.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv2_CH44_Metadata.csv']);
    
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH38.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batch_CH38_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv3_CH43.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv3_CH43_Metadata.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv3_CH44.csv']);
    delete([path.csv_data '\' '2018-10-02_disassembly_batchv3_CH44_Metadata.csv']);
elseif strcmp(batch_name, 'disassembly_batch2')
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH27.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH27_Metadata.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH28.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH28_Metadata.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH29.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH29_Metadata.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH30.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH30_Metadata.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH31.csv']);
    delete([path.csv_data '\' '2018-12-05_M1B_rate_lifetime_CH31_Metadata.csv']);
elseif strcmp(batch_name, 'batch9')
    delete([path.csv_data '\' '2019-01-24_batch9_CH46.csv']);
    delete([path.csv_data '\' '2019-01-24_batch9_CH46_Metadata.csv']);
    
    % Pull in batch9pt2 and rename ch48
    batch_date = '2019-01-29';
    aws_pulldata = ['aws s3 sync s3://matr.io/experiment/d3batt D:\Data --exclude "*" --include "' batch_date '*"'];
    system(aws_pulldata)
    delete([path.csv_data '\' '2019-01-29_batch9pt2_CH5.csv']);
    delete([path.csv_data '\' '2019-01-29_batch9pt2_CH5_Metadata.csv']);
    cd(path.csv_data)
    movefile '2019-01-29_batch9pt2_CH48.csv' '2019-01-24_batch9_CH48.csv'
    movefile '2019-01-29_batch9pt2_CH48_Metadata.csv' '2019-01-24_batch9_CH48_Metadata.csv'
    batch_date = '2019-01-24';
    cd(path.code)
elseif strcmp(batch_name, 'batch9pt2')
    delete([path.csv_data '\' '2019-01-29_batch9pt2_CH5.csv']);
    delete([path.csv_data '\' '2019-01-29_batch9pt2_CH5_Metadata.csv']);
end