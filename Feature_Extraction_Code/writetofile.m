

% Define the header names
header_names = {'st', 'dt', 'pir', 'bp'};

% Define the filename for the CSV file
csv_filename = 'datain_sciml.csv';

% Open the file for writing
fileID = fopen(csv_filename, 'w');

%normalize ppg signals to 100 samples
for i = 1:length(data)
    if(length(data(i).mid_ppg)<100)
        for k = length(data(i).mid_ppg)+1: 100
            data(i).mid_ppg = [data(i).mid_ppg; data(i).mid_ppg(length(data(i).mid_ppg))];
        end
    end
end

data_ppg = zeros([length(data), 100]);

for i= 1: length(data)
    data_dt(i) = data(i).LASI;
    data_st(i) = data(i).ST;
    data_pir(i) = data(i).PIR;
    data_sbp(i) = data(i).SBP;
    for k = 1:100
        data_ppg(i,k) = data(i).mid_ppg(k);
    end
end 




% Write the data to the file
for i = 1: length(data_dt)
    fprintf(fileID,[repmat('%d ',1,numel(data_ppg(i,:))) '%d %d %d %d\n'], [data_ppg(i,:),data_dt(1,i), data_st(1,i), data_pir(1,i),data_sbp(1,i)]);
end
% Close the file


fclose(fileID)