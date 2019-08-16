COMPRESSION_ALGOS=( gzip bzip2 pbzip2 xz pigz )

for file in ./fastq/*.fastq; 
do
	eval "du $file"
	root=${file%.fastq}
	for algo in "${COMPRESSION_ALGOS[@]}"
	do
		echo "Algo: $algo"   
		compressed_file="./compressed/${root##*/}.$algo"
		{ time cat $file | eval "$algo -9" > $compressed_file; } 2>&1
		eval "du $compressed_file"
	done
done









