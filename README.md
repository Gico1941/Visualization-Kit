# Visualization-Kit
## heatmap with gene-sets (Geneset can be custom or refer to GSEA database https://www.gsea-msigdb.org/gsea/msigdb/human/genesets.jsp): 

Recutsively plot heatmaps for all geneset files in ./geneset folder, count matrix .csv file should be normalized (e.g. DEseq2 normalized)

Example Result (Generated with GSE211061 https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE211061):

<img src="https://github.com/Gico1941/Visualization-Kit/assets/127346166/04e44fce-6afe-494a-8c94-96cc7cbec83e" width="200" />

## GSEA bubble plot (GeneSetEnrichmentAnalysis software https://www.gsea-msigdb.org/gsea/index.jsp):

Recursively read all GSEA report file under 'GSEA path', filter out pathway by FDR threshold and plot top n pathways ranked by FDR 
```
GSEA_bubble(GSEA_folder='GSEA',GSEA_fdr_hold=0.5,fdr_top=20)
```
Example Result (Generated with GSE211061):

<img src="https://github.com/Gico1941/Visualization-Kit/assets/127346166/18c9fbba-5b29-4148-a7d3-9804d8c43907" width="200" />

## Volcano plot for DESeq2 : 
```
volcano_plot_p_FC(DEseq2_result %>% as.data.frame() ,LogFoldC_col= 'log2FoldChange', p_v_col = 'pvalue',
                          p_hold = 0.1, FC_hold = 0.5,MAX=15,top_display=15) 

```
<img src="https://github.com/Gico1941/Visualization-Kit/assets/127346166/5f8cad42-aff4-42f9-b6d7-1ba500ab4ca3" width="200" />


