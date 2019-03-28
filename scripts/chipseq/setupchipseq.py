from pandas import read_csv

ChIPSeqSRARunTableFile='data/ChIPSeqSRA.tsv'
ChIPSeqSRATable = read_csv(ChIPSeqSRARunTableFile, delimiter='\t')
ChIPSeqoutrun = (ChIPSeqSRATable["Run"])
ChIPSeqoutputSam = "test/" + ChIPSeqoutrun + ".sam"
ChIPSeqoutputAlignmentSummary = "test/" + ChIPSeqoutrun + ".txt"
ChIPSeqoutputMetrics = "test/" + ChIPSeqoutrun + ".metrics"
ChIPSeqoutputSortBam = "test/" + ChIPSeqoutrun + ".sorted.bam"

print("ChIP-Seq run " + ChIPSeqoutrun)
