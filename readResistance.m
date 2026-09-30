

function [Node1, Node2, ResVal] = readResistance()
    filename = 'node_resistances.txt';
    fid = fopen(filename, 'r');
    if fid == -1
        error('Could not open the input file.');
    end
    data = fscanf(fid, '%d %d %f', [3, inf] );
    fclose(fid);
    Node1 = data(1,:);
    Node2 = data(2,:);
    ResVal = data(3,:);
end



