import subprocess
import os
from pandas import read_csv

ChIPSeqSRARunTableFile='data/ChIPSeqSRA.tsv'
ChIPSeqSRATable = read_csv(ChIPSeqSRARunTableFile, delimiter='\t')
ChIPSeqoutrun = (ChIPSeqSRATable["Run"])
ChIPSeqoutputSam = "test/" + ChIPSeqoutrun + ".sam"
ChIPSeqoutputAlignmentSummary = "test/" + ChIPSeqoutrun + ".txt"
ChIPSeqoutputMetrics = "test/" + ChIPSeqoutrun + ".metrics"
ChIPSeqoutputSortBam = "test/" + ChIPSeqoutrun + ".sorted.bam"

for index, individual in enumerate(ChIPSeqoutrun):
    run = ChIPSeqoutrun[index]
    summary = ChIPSeqoutputAlignmentSummary[index] 
    metrics = ChIPSeqoutputMetrics[index]
    sam = ChIPSeqoutputSam[index]
    bam = ChIPSeqoutputSortBam[index]
    index = "yeast_index/genome"
    os.system("hisat2 -u 10000 -p 2 -x {0} --sra-acc {1} --new-summary --summary-file {2} --met-file {3} -S {4}".format(index, run, summary, metrics, sam))
