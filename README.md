# Compression Project

## Algorithms Tested
### Generic Methods
* gzip
* bzip2/pbzip2
* xz
* pigz
* (7z)

### Genetics-Specific Methods (w/o Reference)
* Fqzcomp/FastQz
* Gtz

## Install
```
$ brew install pbzip2
$ brew install bzip2
$ brew install xz
$ brew install pigz
```

## Run
```
$ mkdir compression
$ ./compression_test.sh > logs/compression.log     # Reads from fastq folder
```

## Data
All files were taken from the 1000 Genomes Project
* HG00096: ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00096/sequence_read/
* HG00097: ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00097/sequence_read/



