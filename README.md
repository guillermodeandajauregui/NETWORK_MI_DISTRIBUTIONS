# NETWORK_MI_DISTRIBUTIONS
##Tools for the description of Mutual Information distributions in complex networks

Weighed complex networks may have a non-random weight distribution.
For instance, transcriptional networks inferred with the ARACNE algorithm. With edges weighted by Mutual Information (MI).
Distributions of mutual information  in transcriptional networks may give insights in network differences (with biological implications)

## How to use

###"functions_for_MI_distribution_exploration_in_networks.R" contains the useful functions in R. 
Requires packages "parallel" (from base) and "data.table"

 subsetter_multicore: breaks a single SIF-like network into a list of star-shaped subgraphs with each node in the original network at the center.
 df_intervals_mi: given the output of subsetter_multicore, generates a dataframe with maximum, minimum, average and median value of MI for edges of each node. 
 subsetter_intervals_multicore: Combines the last two functions: input a single SIF-like network, output a dataframe as made by df_intervals_mi

###"plotting_function_MI_distributions.R" contains a single function, plot_intervals, which plots max, min, avg and median values of MI for each node. 

###"test_script_for_MI_distributions.R" contains a test set for the functions. Generates a BA graph, and applies relevant functions. 
Requires package "igraph"
