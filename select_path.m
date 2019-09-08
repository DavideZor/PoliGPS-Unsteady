function path = select_path(d, pred, ID_nodes)

path = zeros(length(ID_nodes),1);

i = find_node_index(d, ID_nodes);
j = 1;

while pred(i) ~= 0
    path(j) = pred(i);
    i = find_node_index(path(j), ID_nodes);
    j = j + 1;
end

path = flip_vector(path);
path = [path; d];

q = find_first_index(path);
path = path(q:end);

end

