gtf2 <- read.table('../data/Saccharomyces_cerevisiae.R64-1-1.84.gtf', header = FALSE, sep = '\t',stringsAsFactors=FALSE)

colnames(gtf2) <- c("chr","source","type","start","end","score","strand","phase","attributes") 

## Function provided by https://www.biostars.org/p/272889/
extract_attributes <- function(gtf_attributes, att_of_interest){
  att <- strsplit(gtf_attributes, "; ");
  att <- unlist(att);
  if(!is.null(unlist(strsplit(att[grep(att_of_interest, att)], " ")))){
    return( unlist(strsplit(att[grep(att_of_interest, att)], " "))[2])
  }else{
    return(NA)}
}

# extract values of interest
gtf2$gene_id <- unlist(lapply(gtf2$attributes, extract_attributes, "gene_id"))
gtf2$gene_biotype <- unlist(lapply(gtf2$attributes, extract_attributes, "gene_biotype"))
gtf2$gene_name <- unlist(lapply(gtf2$attributes, extract_attributes, "gene_name"))
gtf2$gene_source <- unlist(lapply(gtf2$attributes, extract_attributes, "gene_source"))

gtf2$exon_number <- unlist(lapply(gtf2$attributes, extract_attributes, "exon_number"))

gtf2$transcript_id <- unlist(lapply(gtf2$attributes, extract_attributes, "transcript_id"))
gtf2$transcript_name <- unlist(lapply(gtf2$attributes, extract_attributes, "transcript_name"))
gtf2$transcript_source <- unlist(lapply(gtf2$attributes, extract_attributes, "transcript_source"))
gtf2$transcript_biotype <- unlist(lapply(gtf2$attributes, extract_attributes, "transcript_biotype"))

YeastGeneAnnotation = gtf2[gtf2$type=='gene',]
save(YeastGeneAnnotation, file='../data/yeastGeneAnnotation.rda')

## Load yeast gene counts

countFileDirectory = 'test' #Directory that the count files are stored in
countFiles = list.files(countFileDirectory,pattern='genecount.txt') #Find the count files in this directory
countFiles = paste0(countFileDirectory,'/',countFiles)

getrows <- function(x) {
row.names(x)=x[,1]
x=x[,2,drop=F]
return(x)
}

### Next import the count files (individual .txt files) into a single YeastGeneCounts object
YeastGeneCountList = lapply(countFiles, read.table) #Make a list of the count objects
names(YeastGeneCountList) <- countFiles
YeastGeneCountList = lapply(YeastGeneCountList, getrows) 

YeastGeneCounts = do.call("cbind",YeastGeneCountList ) #Combine the list of count objects into a single data.frame
colnames(YeastGeneCounts) <- (basename(names(YeastGeneCountList))) 

## Remove rows without annotation and line everything up
YeastGeneCounts = YeastGeneCounts[YeastGeneAnnotation$gene_id,]

expInfo = as.data.frame( data.table::fread('../data/RNASeqSRA.tsv') )
expInfo= expInfo[match(expInfo$Run, colnames(YeastGeneCounts) ),]
expInfo$karyotype = factor(expInfo$karyotype, levels=c("Euploid","Aneuploid") )
expInfo$replicate = factor(expInfo$replicate, levels=c("First","Second",'Third') )

## Load the information about the experiment

save(YeastGeneCounts, expInfo, file='../data/YeastGeneCounts.rda')

filtYeastGeneCounts = YeastGeneCounts[rowSums(YeastGeneCounts)>0,]
pcainput = t(log2(filtYeastGeneCounts+1))
CountsPCA = prcomp( pcainput)$x

pdf('test/pca.pdf',height=8,width=8)
par(mar=c(5,6,4,1)+.5)
plot(CountsPCA[,1],CountsPCA[,2],col=expInfo$karyotype,pch=16,cex=2, xlab='PC1',ylab='PC2', cex.lab=2, cex.axis=2, cex.main=2, cex.sub=2 )
legend("topleft", 
	   legend=c("Euploid","Aneuploid"),
	   pch =c(16,16),
       col=c("black", "red"), cex=2)
par(mar=c(5,6,4,1)+.5)
plot(CountsPCA[,1],CountsPCA[,2],col=expInfo$replicate,pch=16,cex=2, xlab='PC1',ylab='PC2', cex.lab=2, cex.axis=2, cex.main=2, cex.sub=2 )
legend("topleft", 
	   legend=c("First Replicate","Second Replicate",'Third Replicate'),
	   pch =c(16,16),
       col=c("black", "red",'green'), cex=2)
	  
dev.off()

summary(prcomp( t(log2(filtYeastGeneCounts+1) ) ))

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
