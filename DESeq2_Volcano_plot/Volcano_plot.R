library(DESeq2)
library(tidyverse)


volcano_plot_p_FC <- function(data,LogFoldC_col= 'log2Fold_.Change', p_v_col = 'p_.value',p_hold , FC_hold ,
                              MAX=15,top_display=5){
  
  colnames(data)[which(colnames(data) == LogFoldC_col)] <- 'log2Fold_.Change'
  
  colnames(data)[which(colnames(data) == p_v_col)] <- 'p_.value'
  
  data$significant <- ifelse(data$p_.value<p_hold&abs(data$log2Fold_.Change)>=FC_hold,
                             ifelse(data$log2Fold_.Change>FC_hold,"Up","Down"),"Stable")

  data <- data[complete.cases(data),]
  ##### symbol = gene name
  data $Symbol <- row.names(data)
  
  plot <- ggplot(data,aes(x=log2Fold_.Change,y=-log10(p_.value)))+
    theme(plot.margin = unit(c(1,1,1,1),"cm"))+
    geom_point(aes(color = factor(significant)),size=2,alpha=0.4)+
    scale_color_manual(values=c('blue','grey','red')[which(c("Down","Stable","Up") %in% unique(data$significant))])+
    geom_text_repel(
      data = rbind(subset(data,p_.value<p_hold&data$log2Fold_.Change>=FC_hold) %>%top_n(top_display,log2Fold_.Change), 
                   subset(data,p_.value<p_hold&data$log2Fold_.Change<=-FC_hold)%>%top_n(top_display,-log2Fold_.Change)),
      
      aes(label = Symbol),size = 3,
      min.segment.length = 0,box.padding = 0.1,max.overlaps =MAX )+
    
    geom_vline(xintercept = c(-FC_hold,FC_hold),lty=4,col='black',lwd=0.8)+
    geom_hline(yintercept = -log10(p_hold),lty=4,col='black',lwd=0.8)+
    theme(legend.position = 'bottom')
  #ggsave(paste0('Volcano_plot.pdf'),plot,dpi=1500,width = 10,height = 10)
  return(plot)
}