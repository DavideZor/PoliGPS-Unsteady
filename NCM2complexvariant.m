function [T_h, G_k, R_s] = NCM2complexvariant(nodes, arcs, times, costs, risks, n)

ID_nodes = nodes(:,1);

vehicle_time_types = 3;
vehicle_cost_types = 5;
vehicle_risk_types = 2;

m = round(n/3);

Tm_h = zeros(vehicle_time_types,3*m);
Gm_k = zeros(vehicle_cost_types,3*m);
Rm_s = zeros(vehicle_risk_types,3*m);

for i = 1:m
    for vtt = 1:vehicle_time_types
        for vct = 1:vehicle_cost_types
            for vrt = 1:vehicle_risk_types
                vehicle = [vtt,vct,vrt];
                ODS = random_OD(nodes, 's');
                os = ODS(1,1);
                ds = ODS(2,1);
                [TS, GS, RS] = NCM1(os, ds, ID_nodes, arcs, vehicle, times, costs, risks);
                Tm_h(vtt,i) = TS;
                Gm_k(vct,i) = GS;
                Rm_s(vrt,i) = RS;
                ODM = random_OD(nodes, 'm');
                om = ODM(1,1);
                dm = ODM(2,1);
                [TM, GM, RM] = NCM1(om, dm, ID_nodes, arcs, vehicle, times, costs, risks);
                Tm_h(vtt,m+i) = TM;
                Gm_k(vct,m+i) = GM;
                Rm_s(vrt,m+i) = RM;
                ODL = random_OD(nodes, 'l');
                ol = ODL(1,1);
                dl = ODL(2,1);
                [TL, GL, RL] = NCM1(ol, dl, ID_nodes, arcs, vehicle, times, costs, risks);
                Tm_h(vtt,2*m+i) = TL;
                Gm_k(vct,2*m+i) = GL;
                Rm_s(vrt,2*m+i) = RL;
            end
        end
    end
end

T_h = max(Tm_h, [], 2);
G_k = max(Gm_k, [], 2);
R_s = max(Rm_s, [], 2);

end