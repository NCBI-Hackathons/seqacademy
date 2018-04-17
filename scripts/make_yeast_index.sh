#!/bin/sh
mkdir yeast_index
cd yeast_index
#
# Downloads sequence for the GRCm38 release 81 version of M. Musculus (mouse) from
# Ensembl.
#
# By default, this script builds and index for just the base files,
# since alignments to those sequences are the most useful.  To change
# which categories are built by this script, edit the CHRS_TO_INDEX
# variable below.
#

ENSEMBL_RELEASE=84
ENSEMBL_YEAST_BASE=ftp://ftp.ensembl.org/pub/release-${ENSEMBL_RELEASE}/fasta/saccharomyces_cerevisiae/dna/
HISAT2_BUILD_EXE=/home/ubuntu/SteveSemick/hisat2-2.1.0/hisat2-build

F=Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa
if [ ! -f $F ] ; then
	wget ${ENSEMBL_YEAST_BASE}/$F.gz || (echo "Error getting $F" && exit 1)
	gunzip $F.gz || (echo "Error unzipping $F" && exit 1)
	mv $F genome.fa
fi

CMD="${HISAT2_BUILD_EXE} genome.fa genome"
echo Running $CMD
if $CMD ; then
	echo "genome index built; you may remove fasta files"
else
	echo "Index building failed; see error message"
fi

rm genome.fa
