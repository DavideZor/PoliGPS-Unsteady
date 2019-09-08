%Non ha senso calcolare le costanti di altri veicoli una volta scelto il
%tuo veicolo per questo facciamo questa versione semplificata
%Dice che le constants sono differentiated per le differenti grandezze, per
%questo mettiamo in imput anche size

function [T, G, R] = NCM2(nodes, arcs, t, c, r, size, n)

ID_nodes = nodes(:,1);

m = round(n/3);

Tv = zeros(m,1);
Gv = zeros(m,1);
Rv = zeros(m,1);

for i = 1:m
    OD = random_OD(nodes, size);
    o = OD(1,1);
    d = OD(2,1);
    [Ti, Gi, Ri] = NCM1(o, d, ID_nodes, arcs, t, c, r);
    Tv(i) = Ti;
    Gv(i) = Gi;
    Rv(i) = Ri;
end

T = max(Tv);
G = max(Gv);
R = max(Rv);

end