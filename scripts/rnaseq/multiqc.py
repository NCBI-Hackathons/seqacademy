from pandas import read_csv
import os

RNASeqSRARunTableFile='data/RNASeqSRA.tsv'
RNASeqSRATable = read_csv(RNASeqSRARunTableFile, delimiter='\t')
RNASeqoutrun = (RNASeqSRATable["Run"])
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"

for run in RNASeqoutputSortBam:
    os.system("multiqc {0} --quiet --outdir test/multiqc_chipseq --force".format(run))
