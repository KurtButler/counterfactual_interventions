function [B] = create_B(CL, sp,  D)

% Transition matrix
B = unifrnd(-CL, CL, D);      

% Number of 0s in row
n0 = round(sp*D);   

% Sparsify matrix
for j = 1:D
    B(j, datasample(1:D, n0, 'replace', true)) = 0;
end


end