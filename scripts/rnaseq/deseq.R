# *****install DESeq2*****
# source("https://bioconductor.org/biocLite.R")
# biocLite("DESeq2")

library("DESeq2")

directory <- ""
filelist <- list.files(directory)
sampleFiles <- grep("genecount",filelist,value=TRUE)
sampleFiles <-c("SRR5494627.genecount.txt","SRR5494628.genecount.txt","SRR5494629.genecount.txt","SRR5494630.genecount.txt","SRR5494631.genecount.txt","SRR5494632.genecount.txt")
sampleName <- c ("Aneuploid1", "Aneuploid2", "Aneuploid3", "Euploid1", "Euploid2", "Euploid3")
condition <- c ("Aneuploid", "Aneuploid", "Aneuploid", "Euploid", "Euploid", "Euploid")
sampleTable <- data.frame(sampleName=sampleName, fileName=sampleFiles, condition=condition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, directory=directory, design=~condition)
ddsHTSeq <- ddsHTSeq[rowSums(counts(ddsHTSeq))>1,]
ddsHTSeq$condition <- relevel(ddsHTSeq$condition, ref = "Euploid")
ddsHTSeq <- DESeq(ddsHTSeq)
res <- results(ddsHTSeq)
outputdeseq <- paste(directory, "AneuploidVsEuploid_deseq2_results.csv", sep="")
outputvsd <- paste(directory, "AneuploidVsEuploid_VSD.csv", sep="")
write.csv (as.data.frame(res),file=outputdeseq)
vsd <- varianceStabilizingTransformation(ddsHTSeq, blind=FALSE)
write.csv(assay(vsd),file=outputvsd)
