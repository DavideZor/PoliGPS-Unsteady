function M = delete_null_rows(N)

[n, m] = size(N);
M = zeros(n,m);
nullrow = ones(n,1);

for i = 1:n
    for j = 1:m
        if N(i,j) ~= 0
            nullrow(i) = 0;
        end
    end
end

zerorows = sum(nullrow);
nonzerorows = n - zerorows;
k = 1;

for i = 1:n
    if nullrow(i) == 0
        M(k,:) = N(i,:);
        k = k + 1;
    end
end

M = M(1:nonzerorows,:);

end