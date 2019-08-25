#!/bin/sh

FASTQ_FILES=( SRR062634 SRR062635 SRR062641 SRR077487 SRR081241 )
fdir=fastq
mkdir -p "$fdir"
for file in "${FASTQ_FILES[@]}"
do
	fname="${file}_1.filt.fastq.gz"
	fpath="$fdir/$fname"
	echo "downloading $fname"
	curl http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00096/sequence_read/$fname > $fpath
	gunzip $fpath
done;
