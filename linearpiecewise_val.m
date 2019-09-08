function new_y = linearpiecewise_val(x, y, new_x)

nx = length(x);
ny = length(y);

n = length(new_x);
new_y = zeros(n,1);

if nx ~= ny
    printf('Error:');
end

new_x = ((new_x - min(new_x)) .* (max(x) - min(x))/(max(new_x) - min(new_x))) + min(x);

m = zeros(nx-1,1);
q = zeros(nx-1,1);

for i = 1:nx-1
    m(i) = (y(i+1)-y(i))/(x(i+1)-x(i));
    q(i) = y(i)-m(i)*x(i);
    for j = 1:n
        if new_x(j) <= x(i+1) && new_x(j) >= x(i)
            new_y(j) = m(i) * new_x(j) + q(i);
        end
    end
end

end
    