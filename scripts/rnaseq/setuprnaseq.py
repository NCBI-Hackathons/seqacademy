from pandas import read_csv

RNASeqSRARunTableFile='data/RNASeqSRA.tsv'
RNASeqSRATable = read_csv(RNASeqSRARunTableFile, delimiter='\t')
RNASeqoutrun = (RNASeqSRATable["Run"])
RNASeqoutputSam = "test/" + RNASeqoutrun + ".sam"
RNASeqoutputAlignmentSummary = "test/" + RNASeqoutrun + ".txt"
RNASeqoutputMetrics = "test/" + RNASeqoutrun + ".metrics"
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"

print("RNA-Seq run" + str(RNASeqoutrun))
