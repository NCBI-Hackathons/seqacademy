import pandas as pd
import os

"""
Python script for calling each input bam file and running dupRadar.R on it.
"""

RNASeqSRARunTableFile = "data/RNASeqSRA.tsv"
RNASeqSRATable = pd.read_csv(RNASeqSRARunTableFile, delimiter="\t")
RNASeqoutrun = (RNASeqSRATable["Run"])
RNASeqoutputMetrics = "test/" + RNASeqoutrun + ".metrics"
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"
gtf = "data/Saccharomyces_cerevisiae.R64-1-1.84.gtf"

for bam in RNASeqoutputSortBam:
    os.system("Rscript scripts/rnaseq/dupRadar.R %s %s" % (bam, gtf)) 
