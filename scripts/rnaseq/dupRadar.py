import pandas as pd
import os

"""
Python script for calling each input bam file and running dupRadar.R on it.
"""

RNASeqSRARunTableFile='data/RNASeqSRA.tsv'
RNASeqSRATable = read_csv(RNASeqSRARunTableFile, delimiter='\t')
RNASeqoutrun = (RNASeqSRATable["Run"])
RNASeqoutputSam = "test/" + RNASeqoutrun + ".sam"
RNASeqoutputAlignmentSummary = "test/" + RNASeqoutrun + ".txt"
RNASeqoutputMetrics = "test/" + RNASeqoutrun + ".metrics"
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"

