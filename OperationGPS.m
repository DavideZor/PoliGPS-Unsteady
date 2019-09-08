%Integrare il calcolo del path e la gestione del tempo

function pred = OperationGPS(o, d, departure_time, ID_nodes, arcs, t, generalized_costs, rho_u, F)

n = size(arcs,1);
m = size(F,1);

U = zeros(n,2); %Permanently labeled arcs
L = zeros(n,1); %Arc label
temp = L; %Temporary vector used later
pred = zeros(n,1); %Predecessor of the arc (?)

delta_plus_o = exiting_arcs(arcs,o);
delta_minus_d = entering_arcs(arcs,d);
A_minus_delta = set_difference(arcs, delta_plus_o);

for i = 1:n
    if A_minus_delta(i,1) ~= 0 || A_minus_delta(i,2) ~= 0
        L(i) = inf;
    else
        L(i) = generalized_costs(i, departure_time);
    end
end

for j = 1:length(delta_plus_o)
    i = find_arc_index(delta_plus_o(j,:), arcs);
    pred(i) = o;
end

test = 0;

while test == 0
    A_minus_U = set_difference(A, U);
    for i = 1:n
        if A_minus_U(i,1) ~= 0 || A_minus_U(i,2) ~= 0
            arc_head = arcs(i,2);
            u = find_node_index(arc_head, ID_nodes);
            temp(i) = L(i) + rho_u(u);
        end
    end
    pq = find_first_index(temp == min(temp));
    p = arcs(pq,1);
    q = arcs(pq,2);
    U(pq,1) = p;
    U(pq,2) = q;
    
    required_time = path_cost_calculator(path, arcs, t);
    time = departure_time + required_time;
    timeslot = find_timeslot(time);
    
    delta_plus_q = exiting_arcs(arcs, q);
    
    z = size(delta_plus_q,1);
    
    for j = 1:z
        r = delta_plus_q(j,2);
        qr = find_arc_index([q,r], arcs);
        for k = 1:m
            if F(k,1) ~= p && F(k,2) ~= q && F(k,3) ~= r
                if L(pq) + generalized_costs(qr,timeslot) < L(qr)
                    L(pq) = L(pq) + generalized_costs(qr,timeslot);
                    pred(qr) = p;
                end
            end
        end
    end
    
    [test, ~] = set_intersection(U, delta_minus_d);
    
end


end