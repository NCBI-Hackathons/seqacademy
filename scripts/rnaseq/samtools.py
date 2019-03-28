import os
from pandas import read_csv

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
    os.system("samtools view -bSF4 {0} | samtools sort -o {1}".format(sam, bam))

