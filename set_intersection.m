%The function leaves zeros in the position where there is no intersection
%It would be easy to delete those zeros thanks to the function delete_null
%rows but it would be much more difficult for the OperationGPS function to
%find indices (more time consuming).
%An element of a set is defined in a row.
%TESTED

function [test, C] = set_intersection(A,B)

[n,m] = size(A);
[o,p] = size(B);

if m ~= p
    printf('Error: the matrices are not compatible');
end

C = zeros(n,m);
test = 0;

for i = 1:n
    for j = 1:o
        if A(i,1) == B(j,1) && A(i,2) == B(j,2)
            C(i,1) = A(i,1);
            C(i,2) = A(i,2);
            test = 1;
        end
    end
end
        
end