
#Script to test functions
require(igraph)

#Generate a BA graph of 2000 edges
random_barabasi_graph<-barabasi.game(n = 2000, power = 1, directed = FALSE)
g_edgelist <-as.data.frame(get.edgelist(random_barabasi_graph))
#Generate a random list of "MIs" 
random_mis<- runif(n = nrow(g_edgelist), min = 0, max = 1)
#Make a sif like, of the edge-edge-interaction form 
##interaction is in column 3, not in default column 2
sif_like<-cbind(g_edgelist, random_mis)
#a random sample of 100 nodes
rnd_nodes<-sample(sif_like[,1], 100)

#test the functions, with a random set of nodes
rndnodes_stars<- subsetter_multicore(sif = sif_like, cores = 2, nodes = rnd_nodes)
rndnodes_df_intervals<- df_intervals_mi(sif_list = rndnodes_stars, mi_column = 3)
rndnodes_intervals_from_sif<-subsetter_intervals_multicore(sif = sif_like, mi_column = 3, cores = 2, nodes = rnd_nodes)

#Test the functions
test_list_stars<- subsetter_multicore(sif_like, cores = 2) #generates a list of star-subgraphs for all nodes in network
test_df_intervals_mi<-df_intervals_mi(sif_list = test_list_stars, mi_column = 3) #generates the df with min,max,med,avg for the last list
test_intervals<-subsetter_intervals_multicore(sif = sif_like, mi_column = 3, cores = 2)