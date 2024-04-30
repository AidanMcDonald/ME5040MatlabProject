function  d=setup_ID_LM(d)
include_flags;

count = 0; count1 = 0;   
for i = 1:neq
    if flags(i) == 2            % check if essential B.C   
        count   = count + 1;    
        ID(i)   = count;        % arrange essential B.C nodes first
        d(count)= e_bc(i);      % store reordered essential B.C 
    else
        count1 = count1 + 1;
        ID(i) = nd + count1;
    end
end

for i = 1:nel
    row=1;
    for j = 1:nen
        % Every node is ndof rows, so iterate over each
        nodedofs = ndof*(IEN(j,i)-1);
        for k=1:ndof
            LM(row,i)=ID(nodedofs+k);   % create the LM matrix
            row = row+1;
        end
    end
end
