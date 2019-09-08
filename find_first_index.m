function i = find_first_index(v)

%Inserire controllo della dimensione di v
%Inserire la possibilità che il nodo non sia presente nella lista

test = 0; %Truth test
k = 1; %Counter

while test == 0
    if v(k) ~= 0
        i = k;
        test = 1;
    end
    k = k + 1;
end

end