COMPRESSION_ALGOS=( gzip bzip2 pbzip2 xz pigz )

path_to_gtz="~/.config/GTZ/gtz" # Default location on gtz-installation

compress_generic(){
  local file=$1
  local algo=$2
  local compressed_file=$3
  { time cat $file | eval "$algo -9" > $compressed_file; } 2>&1
}

decompress_generic(){
  local algo=$1
  local compressed_file=$2
  local output_file=$3
  { time $algo -cd $compressed_file > $output_file; } 2>&1
}

compress_gtz(){
  local file=$1
  local compressed_file=$3
  { time eval "$path_to_gtz $file -o $compressed_file 2>/dev/null"; } 2>&1
}

decompress_gtz(){
  local compressed_file=$2
  local output_file=$3
  { time eval "$path_to_gtz -d $compressed_file > $output_file 2>/dev/null"; } 2>&1
}

test(){
  local file=$1
  local algo=$2
  local compress_func=$3
  local decompress_func=$4

  local root=${file%.fastq}
  local compressed_file="./compressed/${root##*/}.$algo"
  local decompressed_file="./decompressed/${root##*/}_$algo.fastq"

  echo "$algo compression: $file -> $compressed_file"
  $compress_func $file $algo $compressed_file
  echo "$algo decompression: $compressed_file -> $decompressed_file"
  $decompress_func $algo $compressed_file $decompressed_file
  du $decompressed_file
  cmp --silent $decompressed_file $file || echo "Lossy compression: $algo on $file ($decompressed_file)"
  rm $decompressed_file
}

# setup
mkdir -p decompressed
mkdir -p compressed

for file in ./fastq/*.fastq; 
do
	eval "du $file"
	for algo in "${COMPRESSION_ALGOS[@]}"
	do
	  test $file $algo compress_generic decompress_generic
	done

  test $file gtz compress_gtz decompress_gtz
done

# cleanup
rm -rf $decompressed
rm -rf $compressed








