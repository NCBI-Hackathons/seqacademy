from pandas import read_csv
import os

gtf = "data/Saccharomyces_cerevisiae.R64-1-1.84.gtf"

RNASeqSRARunTableFile='data/RNASeqSRA.tsv'
RNASeqSRATable = read_csv(RNASeqSRARunTableFile, delimiter='\t')
RNASeqoutrun = (RNASeqSRATable["Run"]).astype(list)
RNASeqoutputSortBam = "test/" + RNASeqoutrun + ".sorted.bam"

for index, individual in enumerate(RNASeqoutputSortBam):
    input = individual
    output = individual + ".genecount.txt"
    os.system("htseq-count -m intersection-nonempty -s no -f bam {0} {1} > {2}".format(input, gtf, output))
