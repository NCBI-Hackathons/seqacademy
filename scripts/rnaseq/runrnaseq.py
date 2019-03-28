from pandas import read_csv
import os

RNASeqSRARunTableFile='data/RNASeqSRA.tsv'
RNASeqSRATable = read_csv(RNASeqSRARunTableFile, delimiter='\t')
RNASeqoutrun = (RNASeqSRATable["Run"])
RNASeqoutputSam = "test/" + RNASeqoutrun + ".sam"
RNASeqoutputAlignmentSummary = "test/" + RNASeqoutrun + ".txt"
RNASeqoutputMetrics = "test/" + RNASeqoutrun + ".metrics"
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"

for index, individual in enumerate(RNASeqoutrun):
    run = RNASeqoutrun[index]
    summary = RNASeqoutputAlignmentSummary[index] 
    metrics = RNASeqoutputMetrics[index]
    sam = RNASeqoutputSam[index]
    bam = RNASeqoutputSortBam[index]
    os.system("hisat2 -u 2000 -x yeast_index/genome --sra-acc {0} --new-summary --summary-file {1} --met-file {2} -S {3}".format(run, summary, metrics, sam))

gtf = "data/Saccharomyces_cerevisiae.R64-1-1.84.gtf"

RNASeqSRARunTableFile='data/RNASeqSRA.tsv'
RNASeqSRATable = read_csv(RNASeqSRARunTableFile, delimiter='\t')
RNASeqoutrun = (RNASeqSRATable["Run"])
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"

for index, individual in enumerate(RNASeqoutputSortBam):
    input = individual
    output = individual + ".genecount.txt"
    os.system("htseq-count -m intersection-nonempty -s no -f bam %s %s > %s" % (input, gtf, output))
