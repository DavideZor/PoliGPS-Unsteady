function [t, c, r] = select_data(vehicle, eta)

if vehicle(1) == 1
    t = load('H1_MOTORBIKE.txt');
elseif vehicle(1) == 2
    t = load('H2_CAR.txt');
elseif vehicle(1) == 3
    t = load('H3_TRUCK.txt');
end

if vehicle(2) == 1
    c = load('K1_GASOLINE.txt');
elseif vehicle(2) == 2
    c = load('K2_DIESEL.txt');
elseif vehicle(2) == 3
    c = load('K3_ELECTRICAL.txt');
end

if vehicle(3) == 1
    r = load('S1.txt');
elseif vehicle(3) == 2
    r = load('S2.txt');
end

t = compress_timetable(t, eta);
c = compress_timetable(c, eta);
r = compress_timetable(r, eta);

end