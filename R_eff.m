function[R_eff] = R_effec(node1, node2)


A = zeros(25,25);
b = zeros(25,1);
current = 1;

for k = 1:length(A)
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


[L, U] = Lufac(A);

y = L \ b; 
V = U \ y; 

R_eff = V(node1) - V(node2);

end
Test_Res = R_effec(2,3);
disp(Test_Res);