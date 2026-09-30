fileID = fopen('output.txt', 'w');
if fileID == -1
    error('File could not be opened')
end

[Node1, Node2, ResVal] = readResistance();
[Node, Voltage] = readVoltage();

A = zeros(25,25);
b = zeros(25,1);

for k = 1:length(Node)
    idx = Node(k);
    A(idx, idx) = 1;
    b(idx) = Voltage(k);
end    


for k = 1:length(ResVal)
    n1 = Node1(k);
    n2 = Node2(k);
    R  = ResVal(k);
    C  = 1 / R; 
    if n1 ~= 1 && n1 ~= 25
        A(n1, n1) = A(n1, n1) + C;  
        A(n1, n2) = A(n1, n2) - C;  
    end

    if n2 ~= 1 && n2 ~= 25
        A(n2, n2) = A(n2, n2) + C;  
        A(n2, n1) = A(n2, n1) - C;  
    end

end
 
% disp(A); 
% disp(b);



[L, U] = Lufac(A);

% disp(L);
% disp(U);

y = L \ b; %L*y = b 
V = U \ y; % U*V = y here v is voltage

LinkCurr = zeros(length(ResVal), 1);

for k = 1:length(ResVal)
    n1 = Node1(k);
    n2 = Node2(k);
    R = ResVal(k);

    LinkCurr(k) = (V(n1) - V(n2))/R;
    fprintf(fileID,'Link: %d | Node %d Voltage: %.3f V to Node %d Voltage: %.3f V | Current through each link: %.4f A\n', k, n1,V(n1), n2,V(n2), LinkCurr(k));

end

