n = 50;

M = zeros(n,n);                             % Initialize as zeros and use loop to change to 1
b = ones(50,1);

for j=1:50
    for i =1:50
        if abs(i-j)<3
            M(i,j) = 1;
        end
    end
end

[V,L] = eig(M);     % V is the eig vector matrix and L is is the eig.value diagonal matrix

lam_max = max(L,[],'all');                  % Maximum eig. value
[row,col]=find(ismember(L,lam_max));        % saves row and column index of max eig. value
v_max = V(:,col);                           % v_max from eig.vector matrix, same column as max eig. value

