%%% Fictional Data generation %%%
%This script aims to generate feasible data for the times, the costs and
%the risks in an average day in Milan

nodes = load('NODES.txt'); %Position of the graph nodes
graph = load('GRAPH.txt'); %Arcs and graph properties
turns = load('TURNS.txt'); %Not allowed turns
ID_nodes = nodes(:,1);
arcs = graph(:,2:3);
n_arcs = size(graph,1);
n_nodes = length(ID_nodes);

distances = graph(:,4); %[km]
max_speed = graph(:,7); %[km/h]

min_times = 60 * 60 * distances./max_speed; %[s]

minutes_in_a_day = 24*60;
timestep = minutes_in_a_day/5;
timetable = zeros(n_arcs,timestep);

%Every ten minutes there could be a sensible variation
%We differentiate three vehicles types:
%1 - motorbike: the motorbike can go up to 0.95 times the speed limit and it
%is not affected very much by the traffic. That's why during the day its
%coefficient varies between 0.9 and 1 (from 6:00 until 23:59)
%2 - car: the car can go up to 0.9 times the speed limit and it is slightly
%affected by the traffic. During the day its random coefficient varies
%between 0.85 to 1 (from 6:00 until 23:59)
%3 - truck: the truck can go up to 0.8 times the speed limit and it is
%strongly affected by traffic. During the day its random coefficient varies
%between 0.5 and 0.9 (from 6:00 until 23:59)

%Also a very strong penalty coefficient is considered for rush hours such
%as 7-9, 12-14 and 17-19. The penalty coefficient is 0.6


motorbike_speed = 0.95 * max_speed;
car_speed = 0.9 * max_speed;
truck_speed = 0.8 * max_speed;

motorbike_timetable = (60 * 60 * distances./motorbike_speed) * ones(1,timestep); 
car_timetable = (60 * 60 * distances./car_speed) * ones(1,timestep);
truck_timetable = (60 * 60 * distances./truck_speed) * ones(1,timestep);

%We consider significant changes every ten minutes so we need:

random_cases = minutes_in_a_day/10;
instances = 1:random_cases;
xx = 1:timestep;

motorbike_coefficient = 0.9 + (1-0.9)*rand(1,random_cases);
car_coefficient = 0.85 + (1-0.85)*rand(1,random_cases);
truck_coefficient = 0.5 + (0.9-0.5)*rand(1,random_cases);

motorbike_coefficients = linearpiecewise_val(instances, motorbike_coefficient, xx);
car_coefficients = linearpiecewise_val(instances, car_coefficient, xx);
truck_coefficients = linearpiecewise_val(instances, truck_coefficient, xx);

%Rush hour penalty:

sixam = time_in_minutes(6,00,00);
eightam = time_in_minutes(8,00,00);
noon = time_in_minutes(12,00,00);
twopm = time_in_minutes(14,00,00);
fivepm = time_in_minutes(17,00,00);
sevenpm = time_in_minutes(19,00,00);

for k = 1:timestep
    if (k >= sixam && k <= eightam) || (k >= noon && k <= twopm) || (k >= fivepm && k <= sevenpm)
        motorbike_coefficients(k,1) = 0.6 * motorbike_coefficients(k,1);
        car_coefficients(k,1) = 0.6 * car_coefficients(k,1);
        truck_coefficients(k,1) = 0.6 * truck_coefficients(k,1);
    end
end

motorbike_coefficients = 1./motorbike_coefficients;
car_coefficients = 1./car_coefficients;
truck_coefficients = 1./truck_coefficients;

motorbike_coefficients = motorbike_coefficients * ones(1, max(n_arcs,timestep));
car_coefficients = car_coefficients * ones(1, max(n_arcs,timestep));
truck_coefficients = truck_coefficients * ones(1, max(n_arcs,timestep));

motorbike_coefficients = motorbike_coefficients';
car_coefficients = car_coefficients';
truck_coefficients = truck_coefficients';

motorbike_timetable = motorbike_coefficients .* motorbike_timetable;
car_timetable = car_coefficients .* car_timetable;
truck_timetable = truck_coefficients .* truck_timetable;

%There are three types of vehicle accordingly to the costs:
%1 - gasoline: 0.544€/km
%2 - diesel: 0.53€/km
%3 - electrical: 0.5131€/km

gasoline = 0.544 * distances;
diesel = 0.53 * distances;
electrical = 0.5131 * distances;

%The highways toll is now considered (0.1€/km):

for i = 1:n_arcs
    if graph(i,5) == 1
        gasoline(i) = gasoline(i) + distances(i) * 0.1;
        diesel(i) = diesel(i) + distances(i) * 0.1;
        electrical(i) = electrical(i) + distances(i) * 0.1;
    end
end

gasoline = gasoline * ones(1, timestep);
diesel = diesel * ones(1, timestep);
electrical = electrical * ones(1, timestep);

%The Area C is now considered (5€):

sevenhalfam = time_in_minutes(7,30,00);
sevenhalfpm = time_in_minutes(19,30,00);

for j = 1:timestep
    for i = 1:n_arcs
        if graph(i,6) == 8 && j >= sevenhalfam && j <= sevenhalfpm
            gasoline(i,j) = gasoline(i,j) + 5;
            diesel(i,j) = diesel(i,j) + 5;
            electrical(i,j) = electrical(i,j) + 5;
        end
    end
end

%Now we are generating data for the risks. First we consider a default risk
%value equal to 0.5 km^-1 for both cathegories:
%No risk carry: coefficient equal to 1
%Risk carry: coefficient equal to 2

risk = 0.5 * distances;

RISK1 = risk;
RISK2 = 2*risk;

RISK1 = RISK1 * ones(1, timestep);
RISK2 = RISK2 * ones(1, timestep);


schools = 210; %https://www.tuttitalia.it/lombardia/18-milano/39-scuole/
hospitals = 40; %https://milano.corriere.it/milano/pubblica-utilita/ospedali.shtml#1

%We generate schools + hospitals different node position

position = ceil(n_nodes*rand(schools+hospitals,1));


dlmwrite('H1_MOTORBIKE.txt',motorbike_timetable);
dlmwrite('H2_CAR.txt',motorbike_timetable);
dlmwrite('H3_TRUCK.txt',motorbike_timetable);

dlmwrite('K1_GASOLINE.txt', gasoline);
dlmwrite('K2_DIESEL.txt', diesel);
dlmwrite('K3_ELECTRICAL.txt', electrical);

dlmwrite('S1.txt', RISK1);
dlmwrite('S2.txt', RISK2);