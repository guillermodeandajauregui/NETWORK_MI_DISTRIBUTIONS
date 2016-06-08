require("data.table")
require("parallel")

#Functions to subset a SIF-file

#subsetter_less: auxiliar function to subset 
##sif is a sif-like data frame. set is the node set to subset,
##column is the number of column from which to subset 
##returns a sif like data frame
##defaults to "all nodes" if run with no other arguments (IF all nodes are in column 1)
subsetter_less <-function(sif, column = 1, set = unique(sif[,column])){
  g <- subset(sif, sif[,column]%in%set)
  #print(set)
  return(g)
}

#

#subsetter__multicore: function returns a list of SIF-like data frames
#for star-shaped subnetworks with each node selected at the center
#uses multicore to speed up subsetting 
#defaults to "all nodes" if run with no other arguments (IF all nodes are in column 1)
#for large networks, output may be quite large. 
subsetter_multicore<-function(sif, column = 1, cores = 1, nodes = unique(sif[,column])){
  list_subnetworks<-mclapply(X = nodes, FUN = subsetter_less, column = column, sif = sif, mc.cores = cores)
  names(list_subnetworks)<-nodes
    return(list_subnetworks)
}


#####
##Functions to study the intervals of Mutual Information
#####

#Base functions, min_ (minimum) max_ (maximum) median_ and avg_ (average)

min_<-function(df, mi_column = 2){
  mini<-min(df[, mi_column])
  return(mini)
}

max_<-function(df, mi_column = 2){
  maxi<-max(df[, mi_column])
  return(maxi)
}

median_<-function(df, mi_column = 2){
  medi<-median(df[, mi_column])
  return(medi)
}

avg_<-function(df, mi_column = 2){
  avgi<-mean(df[, mi_column])
  return(avgi)
}

#df_intervals_mi: takes a list of SIF-dataframes (ie., for each node), 
#returns data.frame with min, max, median and average MI for each list
df_intervals_mi<-function(sif_list, mi_column = 2) {
  min_mi<-lapply(X = sif_list, FUN = min_, mi_column = mi_column)
  max_mi<-lapply(X = sif_list, FUN = max_, mi_column = mi_column)
  median_mi<-lapply(X = sif_list, FUN = median_, mi_column = mi_column)
  avg_mi<-lapply(X = sif_list, FUN = avg_, mi_column = mi_column)
  return(as.data.frame(cbind(min = unlist(min_mi), median = unlist(median_mi), average =unlist(avg_mi), max = unlist(max_mi))))
}

## subsetter_intervals_multicore: takes sif file, returns data.frame with min, max, median and average MI for selected nodes
## 
subsetter_intervals_multicore<-function(sif, column = 1, mi_column = 2, cores = 1, nodes = unique(sif[,column])){
  list_subnetworks<-mclapply(X = nodes, FUN = subsetter_less, column = column, sif = sif, mc.cores = cores)
  names(list_subnetworks)<-nodes
  return(df_intervals_mi(list_subnetworks, mi_column))
}

