library(tidyverse)
library(ComplexHeatmap)
library(readxl)
library(pheatmap)


#######################################################################################################################  All configuration

count_matrix_file_name <- 'DEseq2_normalized_count_matrixrowsum_gene_count_threshold_1_GSEASPFTumorbearing_163_GFTumorbearing_163.txt_.csv'

geneset_folder <- 'genesets'

row_cluster <- F

row_reorder <- F

######################################################################################################################




data <- read.csv(count_matrix_file_name,row.names = 1)
if(length(grep('_',rownames(data)))!=0 ){
  data$genes <- lapply(rownames(data),function(x) strsplit(x,'_')[[1]][2]) %>% unlist()
}else{
  data$genes <- rownames(data)
}

data <- aggregate(x=data[,-ncol(data)],by=list(data$genes),FUN='sum')

rownames(data) <- data[,1]
data <- data[,-1]

data <- log10(data+1)
data  <- data [rowSums(data )!=0,]


#########################
raw_plot <- function(path){
  
  ht_features <- read_delim(path,col_names = F,delim='\n')  %>% unlist()

  if(length(grep(',',ht_features))!=0 ){ht_features <- strsplit(ht_features,',') %>% unlist()}
  ht_features <- unique(toupper(ht_features))
  
  plot_data <- data[which(toupper(rownames(data))%in% ht_features),]
  plot_data <- plot_data[order(factor(toupper(rownames(plot_data)),levels=ht_features)),]
  
  plot_data <- na.omit(plot_data)
  
  
  #### candidata _reorder
  if(row_reorder==T){
    plot_data <- plot_data[order(rowSums(plot_data[,c(1,2)]),decreasing = T),]}

  pdf(paste0(gsub('.txt','',basename(path)),'_clustered.pdf'),width=ncol(plot_data)*1,height=length(rownames(plot_data))*0.3)
  pheatmap(as.matrix(plot_data),col = colorRampPalette(c('white','lightgreen'))(100),cluster_rows=row_cluster,cluster_cols=F,border_color=NA,scale='row',name = 'scaled expression',)%>%print()
  dev.off()}


lapply(list.files(geneset_folder,recursive = F,full.names = T,pattern = '.txt'),raw_plot)


























