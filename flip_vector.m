function w = flip_vector(v)

n = length(v);
w = v;

for i = 1:n
    w(i) = v(n-i+1);
end

end
    