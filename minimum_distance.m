%It returns the first non-zero distance between two values of a vector

function d = minimum_distance(v)

n = length(v);
d = zeros(n,n);

for i = 1:n
    for j = 1:n
        d(i,j) = abs(v(i) - v(j));
        if d(i,j) == 0
            d(i,j) = (1 + v(n) - v(1)) * 10; %So the algorithm doesn't return 0
        end
    end
end

d = min(min(d));

end