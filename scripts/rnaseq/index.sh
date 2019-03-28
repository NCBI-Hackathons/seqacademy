mkdir yeast_index
cd yeast_index
#
# Downloads sequences for the latest Yeast release from Ensembl.
#
# By default, this script builds an index for just the base files,
# since alignments to those sequences are the most useful.  To change
# which categories are built by this script, edit the CHRS_TO_INDEX
# variable below.
#

ENSEMBL_RELEASE=84
ENSEMBL_YEAST_BASE=ftp://ftp.ensembl.org/pub/release-${ENSEMBL_RELEASE}/fasta/saccharomyces_cerevisiae/dna/

F=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa
if [ ! -f $F ] ; then
	wget ${ENSEMBL_YEAST_BASE}/$F.gz || (echo "Error getting $F" && exit 1)
	gunzip $F.gz || (echo "Error unzipping $F" && exit 1)
	mv $F genome.fa
fi

hisat2-build genome.fa genome

rm genome.fa
