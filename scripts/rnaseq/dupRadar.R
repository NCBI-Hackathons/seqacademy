library(dupRadar)

args = commandArgs(trailingOnly=TRUE)
bam <- args[1]
gtf <- args[2]
sample <- basename(bam)
dm <- analyzeDuprates(bam, gtf, stranded = 0, FALSE, 5, tmpDir = "tempdir")

dm$mhRate <- (dm$allCountsMulti - dm$allCounts) / dm$allCountsMulti
bitmap(file=paste("test/dupRadar/", sample, "multimapping_histogram.png"))
hist(dm$mhRate, breaks=50, main=basename(bam),
    xlab="Multimapping rate per gene", ylab="Frequency")
dev.off()
bitmap(file=paste("test/dupRadar/", sample, "_density_scatter.png"))
duprateExpDensPlot(dm, main=basename(bam))
dev.off()
bitmap(file=paste("test/dupRadar/", sample, "_expression_histogram.png"))
expressionHist(dm)
dev.off()
bitmap(file=paste("test/dupRadar/", sample, "_expression_boxplot"))
par(mar=c(10,4,4,2)+.1)
duprateExpBoxplot(dm, main=basename(bam))
dev.off()
bitmap(file=paste("test/dupRadar/", sample, "_expression_barplot.png")
readcountExpBoxplot(dm)
dev.off()
write.table(dm, file=paste("test/dupRadar/", sample, "_dm"), sep="\\t")

# The following is from
# https://github.com/ewels/NGI-RNAseq/blob/master/bin/dupRadar.r
fit <- duprateExpFit(DupMat=dm)
df <- data.frame(intercept=as.numeric(fit$intercept), slope=c(fit$slope))
cat("# dupRadar model params\\n", file=paste("../test/dupRadar/", sample, "_model.txt"))
write.table(df, file=paste("../test/dupRadar/", sample, "_model.txt"), sep="\\t", append=TRUE, row.names=FALSE)
# Get numbers from dupRadar GLM
curve_x <- sort(log10(dm$RPK))
curve_y = 100*predict(fit$glm, data.frame(x=curve_x), type="response")
# Remove all of the infinite values
infs = which(curve_x %in% c(-Inf,Inf))
curve_x = curve_x[-infs]
curve_y = curve_y[-infs]
# Reduce number of data points
curve_x <- curve_x[seq(1, length(curve_x), 10)]
curve_y <- curve_y[seq(1, length(curve_y), 10)]
# Convert x values back to real counts
curve_x = 10^curve_x
# Write to file
write.table(
  cbind(curve_x, curve_y),
  file=paste("../test/dupRadar/", sample, "_curve.txt")
  quote=FALSE, row.names=FALSE
)
