COMPRESSION_ALGOS=( gzip bzip2 pbzip2 xz pigz )

compress_generic(){
  file=$1
  algo=$2
  compressed_file=$3

  { time cat $file | eval "$algo -9" > $compressed_file; } 2>&1
}

compress_gtz(){
  file=$1
  algo=$2
  compressed_file=$3

  path_to_gtz="~/.config/GTZ/gtz"

  echo "Algo: $algo"
  { time eval "$path_to_gtz $file -o $compressed_file 2>/dev/null"; } 2>&1
}

for file in ./fastq/*.fastq; 
do
	eval "du $file"
	root=${file%.fastq}
	for algo in "${COMPRESSION_ALGOS[@]}"
	do
	  compressed_file="./compressed/${root##*/}.$algo"
	  test_generic $file $algo $compressed_file
	done

  compress_gtz $file "gtz" $root
done









