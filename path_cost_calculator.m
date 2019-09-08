function cost = path_cost_calculator(path, arcs, costs)

n = length(path);
cost = 0;

for i = 1:n-1
    a = path(i);
    b = path(i+1);
    arc = [a, b];
    j = find_arc_index(arc, arcs);
    cost = cost + costs(j);
end

end
    