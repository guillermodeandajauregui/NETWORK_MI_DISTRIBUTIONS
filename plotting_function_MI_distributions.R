#plotting functions 

plot_intervals<-function(intervaldf, xlab, ylab, orderby ="max", title = "MI plot"){
  
  #order by either min, max, 
  if(orderby  == "min"){
    interval_df<- intervaldf[order(intervaldf$min, decreasing = TRUE),]
    yrange<-range(0, max(interval_df$min))
  }
  else if(orderby  == "median"){
      interval_df<- intervaldf[order(intervaldf$median, decreasing = TRUE),]
      yrange<-range(0, max(interval_df$median))
    } 
  else if(orderby  == "average"){
    interval_df<- intervaldf[order(intervaldf$average, decreasing = TRUE),]
    yrange<-range(0, max(interval_df$average))
  }
  else if(orderby  == "max"){
    interval_df<- intervaldf[order(intervaldf$max, decreasing = TRUE),]
    yrange<-range(0, max(interval_df$max))
  }
  else {
    print("orderby by max, min, median or average. Default to max")
    interval_df<- intervaldf[order(intervaldf$max, decreasing = TRUE),]
    yrange<-range(0, max(interval_df$max))
    }
  
  ntrees<-length(rownames(interval_df))
  xrange<-range(1, ntrees)
  #
  
  plot(xrange, yrange, type="n", xlab= xlab,
       ylab= ylab ) 
  colors<-rainbow(ncol(interval_df))
  linetype <- c(1:ncol(interval_df)) 
  lines(interval_df$min, type = "o", lwd=1.5, lty=linetype[1], col=colors[1])
  lines(interval_df$max, type = "o", lwd=1.5, lty=linetype[2], col=colors[2])
  lines(interval_df$median, type = "o", lwd=1.5, lty=linetype[3], col=colors[3])
  lines(interval_df$average, type = "o", lwd=1.5, lty=linetype[4], col=colors[4])
  
  title(title)
}