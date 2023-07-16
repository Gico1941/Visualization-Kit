library(tidyverse)
library(ComplexHeatmap)
library(readxl)
library(pheatmap)


#######################################################################################################################  All configuration

count_matrix_file_name <- '.csv'

geneset_folder <- 'genesets'

row_cluster <- F

row_reorder <- F


high.color <- 'lightgreen'
low.color <- 'white'
color.gradients <- 100
######################################################################################################################



if(count_matrix_file_name=='.csv'){
  data <- read.csv(list.files('./',pattern='.csv')[1],row.names = 1)
}else{
  data <- read.csv(count_matrix_file_name,row.names = 1)
}

data$genes <- rownames(data)
data <- aggregate(x=data[,-ncol(data)],by=list(data$genes),FUN='sum')

rownames(data) <- data[,1]
data <- data[,-1]

data <- log10(data+1)
data  <- data [rowSums(data )!=0,]


#########################
raw_plot <- function(path){
  
  ht_features <- read_delim(path,col_names = F,delim='\n')  %>% unlist()
  if(length(grep(',',ht_features))!=0 ){ht_features <- strsplit(ht_features,',') %>% unlist()}
  
  ht_features <- unique(toupper( ht_features))
  
  plot_data <- data[which(toupper(rownames(data)) %in% ht_features),]
  
  #### candidata _reorder
  if(row_reorder==T){
    plot_data <- plot_data[order(plot_data[,1],decreasing = T),]}
  
  pdf(paste0(gsub('.txt','',basename(path)),'_clustered.pdf'),width=ncol(plot_data)*1,height=length(rownames(plot_data))*0.3)
  pheatmap(as.matrix(plot_data),col = colorRampPalette(c(low.color,high.color ))(color.gradients),cluster_rows=row_cluster,cluster_cols=F,border_color=NA,scale='row',name = 'scaled expression',)%>%print()
  dev.off()}


lapply(list.files(geneset_folder,recursive = F,full.names = T,pattern = '.txt'),raw_plot)

























