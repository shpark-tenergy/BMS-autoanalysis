function battery = cell_analysis(result_data, charging_algorithm, ...
    batch_date, csvpath)

%% Initialize battery struct
battery = struct('policy', ' ', 'policy_readable', ' ', 'barcode', ...
    ' ', 'channel_id', ' ', 'cycles', struct('discharge_dQdVvsV', ...
    struct('V', [], 'dQdV', []), 't', [], 'Qc', [], 'I', [],'V', [], ...
    'T', [], 'Qd', [], 'Q', []), 'summary', struct('cycle', [], ...
    'QDischarge', [], 'QCharge', [], 'IR', [], 'Tmax', [], 'Tavg', ...
    [], 'Tmin', [], 'chargetime', []));

cd(csvpath)

    % Total Test time
    Total_time = result_data(:,1); 
    % Unix Date Time
    Date_time = result_data(:,2);
    
    % Cycle index, 0 is formation cycle
    Cycle_Index = result_data(:,5);
    % All Voltage, current, charge capacity, internal resistance,
    % and temperature variables
    VoltageV = result_data(:,7);
    Current = result_data(:,6);
    Charge_CapacityAh = result_data(:,8);
    Discharge_CapacityAh = result_data(:,9);
    % Internal_Resistance = result_data(:,13);
    % TemperatureT1 = result_data(:,14);
    % batch0 attempts
    Internal_Resistance = ones(length(result_data(:,1)),1);
    TemperatureT1 = ones(length(result_data(:,1)),1);

    % Cell temp is 14, Shelf is 15 and 16
    % Initialize Vector of capacity in and out, maximum temperature, 
    % and discharge dQdV
    C_in = [];
    C_out = [];
    tmax = [];
    dDQdV = [];
    
    % Init whats needed for saving struct
    DQ = [];
    CQ = [];
    IR_CC1 = [];
    tmax = [];
    t_avg = [];
    tmin = [];
    tt_80 = [];
    
    % Translate charging algorithm to something we can put in a legend.
    t = charging_algorithm;
    battery.policy = t;
    t = strrep(t, '_' , '.' );
    t = strrep(t, '-' , '(' );
    t = strrep(t, 'per.' , '%)-' );
    battery.policy_readable = t;
    
    thisdir = cd;
    
    % if batch1, skip cycle 1 data, and add all cycles, including last to
    % struct
    if strcmp(batch_date, '2017-05-12')
        %x = 0;
        start = 2;
    else
        %x = 1;
        start = 1;
    end
    
    %% Go through every cycle except current running one
    for j = start:max(Cycle_Index) - 1
        cycle_indices = find(Cycle_Index == j);
        cycle_start = cycle_indices(1); 
        cycle_end = cycle_indices(end);
        % Time in the cycle
        cycle_time = Total_time(cycle_start:cycle_end) - ...
            Total_time(cycle_start);
        % Voltage of Cycle J
        Voltage = VoltageV(cycle_start:cycle_end);
        % Current values for cycle J
        Current_J = Current(cycle_start:cycle_end);
        % Charge Capacity for the cycle 
        Charge_cap = Charge_CapacityAh(cycle_start:cycle_end);
        % Discharge Capacity for the cycle 
        Discharge_cap = Discharge_CapacityAh(cycle_start:cycle_end);
        % Temperature of the cycle. 
        temp = TemperatureT1(cycle_start:cycle_end);
        
        %{
        % Index of any charging portion
        charge_indices = find(Current(cycle_start:cycle_end) >= 0); % todo: > or >= ?
        charge_start = charge_indices(1); charge_end = charge_indices(end);
        %}
        % Index of discharging portion of the cycle 
        discharge_indices = find(Current(cycle_start:cycle_end) < 0);
        % In case i3 is empty
        if isempty(discharge_indices)
            discharge_start = 1; discharge_end = 2;
        else 
            discharge_start = discharge_indices(1); 
            discharge_end = discharge_indices(end);
        end
        
        
        
        % record discharge dQdV vs V
        [IDC,xVoltage2] = IDCA(Discharge_cap(discharge_start:discharge_end), ...
            Voltage(discharge_start:discharge_end));
        battery.cycles(j).discharge_dQdVvsV.V = xVoltage2;
        battery.cycles(j).discharge_dQdVvsV.dQdV = IDC;
        
        % record Qd
        battery.cycles(j).Qd = Discharge_cap;
        
        % add Qc and V to batch
        battery.cycles(j).Qc = Charge_cap;
        battery.cycles(j).V = Voltage;
        
        % add T to batch
        battery.cycles(j).T = temp;
        
        % add t and C to batch
        battery.cycles(j).t = cycle_time./60;
        battery.cycles(j).I = Current_J/1.1;
        
        
        battery.cycles(j).Q = Charge_cap - Discharge_cap;
        
        %% Add Cycle Legend
        C_in(j) = max(Charge_cap);
        C_out(j) = max(Discharge_cap);
        tmax(j) = max(temp);
        tmin(j) = min(temp);
        t_avg(j) = mean(temp);
        IR_CC1(j) = Internal_Resistance(cycle_end);

        %% Find Time to 80%
        discharge_indices = find(Charge_CapacityAh(cycle_start:cycle_end) >= .88,2);
        if isempty(discharge_indices) || length(discharge_indices) == 1 
            tt_80(j) = 1200;
        else
            tt_80(j) = Total_time(discharge_indices(2)+cycle_start)-Total_time(cycle_start);
            Total_time(discharge_indices + cycle_start);
            Total_time(cycle_start);
        end
        % In case an incomplete charge
        if tt_80(j)<300
            tt_80(j) = tt_80(j-1);
        end
    end
        
    % Export Charge Capacity and correct if errant charge
    if j > 5
        [~, ind] = sort(C_in,'descend');
        maxValueIndices = ind(1:5);
        median(C_in(maxValueIndices));
        CQ = C_in;
        DQ = C_out;
    end
    
    % ADDED
    battery.summary.cycle = 1:j;
    battery.summary.QDischarge = DQ;
    battery.summary.QCharge = CQ;
    battery.summary.IR = IR_CC1;
    battery.summary.Tmax = tmax;
    battery.summary.Tavg = t_avg;
    battery.summary.Tmin = tmin;
    battery.summary.chargetime = tt_80./60;
    % ADDED
    
    cd(thisdir)
end