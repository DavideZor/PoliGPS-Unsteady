function delta = delta_estimation(distances, generalized_costs)

delta = max(max(distances./generalized_costs));

end