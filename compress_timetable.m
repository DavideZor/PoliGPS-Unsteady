%DA OTTIMIZZARE PERCHE' LENTA SULLE MATRICI DI GRANDI DIMENSIONI

function B = compress_timetable(A, eta)

[n,m] = size(A);

B = zeros(n, eta);

elements = ceil(m/eta);

for i = 1:n
    for j = 1:eta
        if j < eta
            B(i,j) = mean(A(i, elements*(j-1) + j : elements*j));
        elseif j == eta
            B(i,j) = mean(A(i, elements*(j-1) + j : m));
        end
    end
end

end