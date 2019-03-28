## Differential gene expression with DESeq2
library("DESeq2")

HTSeqcount <- readHTSeqFile(arg[1])

dds <- DESeqDataSetFromHTSeqCount(HTSeqCount, design=~karyotype)

dds <- dds [rowSums(counts(dds))>1,]
dds <- DESeq(dds)
res <- results(dds)
sigRes = res[which(res$padj<0.05),]

resTested = data.frame(res[!is.na(res$padj),])
resTested$Sig = ifelse(resTested$padj<0.05,"FDR<0.05","FDR>0.05" )
volcanoPlot = ggplot(data=resTested,aes(x=log2FoldChange, y=-log10(padj), col=Sig  ) ) +
	geom_point() + 
	labs(x='Log2 Fold Change', y='False Discovery Rate (FDR)') + 
	scale_colour_manual(values=c("red", "grey") ) + 
	theme_minimal(base_size = 24) + theme(legend.position='none')

ggsave(volcanoPlot, filename='test/volcanoPlot.pdf' )

##
unique(resTested)	
rownames(YeastGeneAnnotation) <- YeastGeneAnnotation$gene_id
YeastGeneAnnotationTested = YeastGeneAnnotation[rownames(resTested),]
resTested = cbind(resTested, YeastGeneAnnotationTested[,c('gene_name','gene_biotype','chr','start','end')] )

##
fisher.test(table(resTested$Sig, sign(resTested$log2FoldChange) ))

chisq.test(table(resTested$Sig, resTested$chr ))

sig_barplot = ggplot(data=resTested, aes(x=chr, fill=Sig) ) + 
			  geom_bar() + 	
			  labs(x='Yeast Chromosome', y='Number of Genes') + 
			  scale_fill_manual(values=c("red", "grey") ) + 
			  theme_minimal(base_size = 24) 
			  
ggsave(sig_barplot, filename='test/barplot_sig.pdf',height=8,width=12)
