COMPRESSION_ALGOS=( gzip bzip2 pbzip2 xz pigz )

test_compression(){
  algo=$1
  cmd=$2
  compressed_file=$3

  echo "Algo: $algo"
  eval $cmd
  du $compressed_file

  # TODO - pass in file and test decompression time as well as verify file
}

for file in ./fastq/*.fastq; 
do
	eval "du $file"
	root=${file%.fastq}
	for algo in "${COMPRESSION_ALGOS[@]}"
	do
	  compressed_file="./compressed/${root##*/}.$algo"
	  cmd="{ time cat $file | eval \"$algo -9\" > $compressed_file; } 2>&1"
	  test_compression $algo $cmd $compressed_file
	done

	# Evaluate gtz
  algo="gtz"
  compressed_file="./compressed/${root##*/}.$algo"
  path_to_gtz="~/.config/GTZ/gtz"   # Modify this if not using default installation
  cmd="{ time eval \"$path_to_gtz $file -o $compressed_file 2>/dev/null\"; } 2>&1"
  test_compression $algo $cmd $compressed_file
done









