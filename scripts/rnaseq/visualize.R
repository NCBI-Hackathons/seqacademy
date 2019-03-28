gtf2 <- read.table('data/Saccharomyces_cerevisiae.R64-1-1.84.gtf', header = FALSE, sep = '\t',stringsAsFactors=FALSE)

head(gtf2)
colnames(gtf2) <- c("chr","source","type","start","end","score","strand","phase","attributes") 

## Function provided by https://www.biostars.org/p/272889/
extract_attributes <- function(gtf_attributes, att_of_interest){
  att <- strsplit(gtf_attributes, "; ")
  att <- gsub("\"","",unlist(att))
  if(!is.null(unlist(strsplit(att[grep(att_of_interest, att)], " ")))){
    return( unlist(strsplit(att[grep(att_of_interest, att)], " "))[2])
  }else{
    return(NA)}
}

# this is how to, for example, extract the values for the various attributes of interest
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
save(YeastGeneAnnotation, file='data/yeastGeneAnnotation.rda')

## Load yeast gene counts

countFileDirectory = 'test' #Directory that the count files are stored in
countFiles = list.files(countFileDirectory,pattern='genecount.txt') #Find the count files in this directory
countFiles=countFiles[!grepl(pattern="bam",x=countFiles)] #Exclude count files with '.bam' in the name
countFiles = paste0(countFileDirectory,'/',countFiles)

### Next import the count files (individual .txt files) into a single YeastGeneCounts object
YeastGeneCountList = lapply(countFiles, read.table) #Make a list of the count objects
names(YeastGeneCountList) <- countFiles
YeastGeneCountList = lapply(YeastGeneCountList, function(x){ 
rownames(x)=x[,1]
x=x[,2,drop=F]
return(x)
 })

YeastGeneCounts = do.call("cbind",YeastGeneCountList ) #Combine the list of count objects into a single data.frame
colnames(YeastGeneCounts) <- gsub("\\..*","",basename(names(YeastGeneCountList) ) )

## Remove rows without annotation and line everything up
YeastGeneCounts = YeastGeneCounts[YeastGeneAnnotation$gene_id,]

expInfo = as.data.frame( data.table::fread('data/RNASeqSRA.tsv') )
head(expInfo)
expInfo= expInfo[match(expInfo$Run, colnames(YeastGeneCounts) ),]
expInfo$karyotype = factor(expInfo$karyotype, levels=c("Euploid","Aneuploid") )
expInfo$replicate = factor(expInfo$replicate, levels=c("First","Second",'Third') )

## Load the information about the experiment


save(YeastGeneCounts, expInfo, file='data/YeastGeneCounts.rda')



CountsPCA = prcomp( t(log2(YeastGeneCounts+1) ) )$x

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
