COMPRESSION_ALGOS=( gzip bzip2 pbzip2 xz pigz )

compress(){
  algo=$1
  root=$2
  file=$3

  echo "Algo: $algo"
  compressed_file="./compressed/${root##*/}.$algo"
  { time cat $file | eval "$algo -9" > $compressed_file; } 2>&1
  du $compressed_file
}

compress_gtz(){
  path_to_gtz=$1
  root=$2
  file=$3

  algo="gtz"
  echo "Algo: $algo"
  compressed_file="./compressed/${root##*/}.$algo"
  { time eval "$path_to_gtz $file -o $compressed_file 2>/dev/null"; } 2>&1
  du $compressed_file
}

for file in ./fastq/*.fastq; 
do
	eval "du $file"
	root=${file%.fastq}
	for algo in "${COMPRESSION_ALGOS[@]}"
	do
		compress $algo $root $file
	done

  path_to_gtz="~/.config/GTZ/gtz"   # Modify this if not using default installation
  compress_gtz $path_to_gtz $root $file
done









