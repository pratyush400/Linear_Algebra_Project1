
function[Node, Voltage] = readVoltage()
    filename = 'node_voltages.txt';
    fid = fopen(filename, 'r');
    if fid == -1
        error('Could not open the input file.');
    end
    data = fscanf(fid, '%d %f', [2, inf] );
    fclose(fid);
    Node = data(1,:);
    Voltage = data(2,:);
end