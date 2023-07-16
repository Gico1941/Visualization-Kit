# Visualization-Kit
## heatmap with gene-sets : 
Recutsively plot heatmaps for all geneset files in ./geneset folder, count matrix .csv file should be normalized (e.g. DEseq2 normalized)

## GSEA bubble plot :
Recursively read all GSEA report file under 'GSEA path', filter out pathway by FDR threshold and plot top n pathways ranked by FDR \
```
GSEA_bubble(GSEA_folder='GSEA',GSEA_fdr_hold=0.5,fdr_top=20)
```
