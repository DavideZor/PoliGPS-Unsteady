%Tested

function C = set_difference(A, B)

[n,m] = size(A);
[o,p] = size(B);

if m ~= p
    printf('Error: the matrices are not compatible');
end

C = A;

for i = 1:n
    for j = 1:o
        if A(i,1) == B(j,1) && A(i,2) == B(j,2)
            C(i,1) = 0;
            C(i,2) = 0;
        end
    end
end

end