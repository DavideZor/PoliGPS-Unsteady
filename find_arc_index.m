%v is the vector to be found inside W

function i = find_arc_index(v, W)

%Insert dimension check
%Inserire che l'arco potrebbe non esserci

a = find_node_index(v(1), W(:,1));
b = find_node_index(v(2), W(:,2));

if a ~= b
    m = min([a,b]);
    for k = 1:m
        W(k,1) = v(1) + v(2) + 1;
        W(k,2) = v(2) + v(2) + 1;
    end 
    i = find_arc_index(v, W);
else
    i = a;
end

end