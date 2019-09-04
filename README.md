# Compression Project

## Introduction
Genomes are big. It’s a simple alphabet of A’s, G’s, C’s, & T’s, but comprises the long 3 billion base pair string representing the human genome. As the number of Next-Generation Sequencing projects rapidly grows, many institutions must confront a pressing storage issue - solutions that worked at a smaller scale before will be a headache to maintain or need to be replaced with a more scalable solution.
​​

​​Since Next-generation technologies usually spit out a massive number of short reads, a popular format for seeing sequencing results is FASTQ. FASTQ contains repeating, 2-part lines of suspected nucleotide sequences & the confidence for each call in the sequence. Below is an example showing the nucleotide sequence separated from its quality scores by a “+” sign and identified by the sequence ID, “@SEQ_ID”.
```​​
​​@SEQ_ID
​​GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
​​+
​​!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65
```
[Reference](https://en.m.wikipedia.org/wiki/FASTQ_format)

​​
​​An uncompressed human genome in FASTQ format can be around 5-10 GB and will take up a significant chunk of hard drive space. That’s why compression is a necessity for storage and distribution. The most popular compressed format is a gzipped file. If you download files from the publicly available [1000 Genomes project](https://gtz.io/GCF_000001405.37_GRCh38.p11_genomic.fna.gz) or are granted access to any files from the [European Bioinformatics Insitute](https://www.ebi.ac.uk/ena/browse/read-download) you will receive them as .fastq.gz files. These gzipped files are convenient to decompress (usually in less than a minute) and a common format expected by many third-party analysis and transformation tools. But while .gz FASTQ files have a respectable compression ratio [of about 30%](http://www.softpanorama.org/HPC/DNA_sequencing/Genomic_data_compression/index.shtml), when you have hundreds or thousands of 2-3 GB .fastq.gz files, storage can still be a concern. To stretch out budgets for storage hardware, hospitals, researchers, and genomics companies may need to investigate alternatives to .gz files that can store more with less.
​​

​​This project investigates alternative compression formats and compares them to the .gz gold standard in compression ratio/rate, decompression rate, and resource utilization for CPU & memory. The results show that many algorithms - bzip2, pbzip2, xz, and GTZ - offer more efficient storage. Improvements of the different compression algorithms over gzip ranged from nearly triple the compression rate to fractions of the time needed to compress. The clear winner for both runtime and compression rate was a specialized algorithm tailored for sequencing data called [GTX.ZIP, or GTZ](https://github.com/Genetalks/gtz). However, the generic algorithm bzip2 performed about 20% better than gzip due to its ability to take advantage of the genome’s short alphabet and repeat structure via Burroughs-Wheeler transform and Move-to-Front encoding. If storage is an issue, both bzip2 and GTZ offer better utilization of the amount of storage space available. 

## Algorithms Tested
### Generic Methods
* gzip
* bzip2/pbzip2
* xz
* pigz

### Specialized Methods for Genetic Data (w/o Reference)
* Gtz (Reference: https://gtz.io/GCF_000001405.37_GRCh38.p11_genomic.fna.gz)

## Results
| Algorithm  | Compression Ratio | Compression Rate (bytes/ms) | Decompression Rate (bytes/ms)  | CPU (%)* | MEM*    |
| ---------- | ----------------- | --------------------------- | ------------------------------ | -------- | ------- | 
| gzip       |  0.148109515      | 4.531499815                 | 232.2678697                    | 100      | 624K    |
| bzip2      |  0.121644789      | 21.33268808                 | 74.58135692                    | 100      | 6816K   |
| pbzip2     |  0.121633493      | 145.0682678                 | 168.8976657                    | 1500     | 22M+    |
| xz         |  0.11765507       | 1.021228651                 | 103.1093882                    | 100      | 360M+   |
| pigz       |  0.148111774      | 36.03876129                 | **345.1920643**                | 1500     | 11M     |
| gtz        |  **0.091490816**  | **1519.525808**             | 108.5826744                    | 200      | 1.49G+  |

\* Approximation taken from ```top``` while the algo was running. 

## Install 
### MAC
Gtz requires a linux machine so only the generic algorithms can be installed.
FqzComp Download - https://sourceforge.net/p/fqzcomp/home/Home/
* BioConda Installation: https://bioconda.github.io/recipes/fqzcomp/README.html
```
$ brew install gzip
$ brew install pbzip2
$ brew install bzip2
$ brew install xz
$ brew install pigz
```

### Linux

Gtz Download - https://github.com/Genetalks/gtz
* Requires 64-bit Linux system
* Documentation: https://github.com/Genetalks/gtz
* LICENSING NOTE - If you're using gtz, you must agree to a licensing agreement where you can't decompile or reverse engineer the software at all. You also must agree to participate "in the User Experience Improvement Program". This requires that users
update to the latest version every 6 months and that GeneTalks will be allowed to collect "software operating parameters through the HTTPS protocol, including CPU usage, memory usage, compressed file size, output file, size, compression ratio, etc". Not sure what is included in "etc". See ```supplemental/gtz_license.md```

### Run
```
$ ./fastq_download.sh                       # Creates "fastq" directory and downloads all fastq files to it
$ ./compression_test.sh > compress.log      # Runs compression test
$ tail -f ./compress.log                    # Shows logging
```

## Implementation
This was run for SRR062634, SRR062635, SRR062641, SRR077487, & SRR081241 of "HG00096" from the 1000 Genomes Project (ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00096/sequence_read/). The Decompression Rate, Compression Rate, & Compression Ratio shown in the results table are the average of the five runs (see "runs" folder for individual results).
### Genric Algorithms: 
* Best compression (slowest time) option was selected
* Results were obtained running on a 2.3 GHz i9 Processor, 16 GB RAM
* Logs: ```./runs/generic.log```
### Specialized Algorithms: 
* Default options were selected
* Logs: ```./runs/{FILE}.log```, e.g. ```./runs/SRR062634.log```. The test was run with a reference to a generic algo. 
* NOTE - Comparing the generic references included in the logs to their runs in ```./runs/generic.log```, it seems the same file was compressed/decompressed faster on mac than on the linux virtual machine. This indicates GTZ actually has a faster rate then what is shown in the results table. See Below.

#### ```runs/generic.log```
```
gzip compression: ./fastq/SRR062634_2.filt.fastq -> ./compressed/SRR062634_2.filt.gzip

real	29m24.739s
user	29m22.648s
sys	0m5.210s
1835648	./compressed/SRR062634_2.filt.gzip
gzip decompression: ./compressed/SRR062634_2.filt.gzip -> ./decompressed/SRR062634_2.filt_gzip.fastq

real	0m32.607s
user	0m29.571s
sys	0m2.531s
6198048	./decompressed/SRR062634_2.filt_gzip.fastq
```

#### ```runs/SRR062634.log```
```
gzip compression: ./fastq/SRR062634_2.filt.fastq -> ./compressed/SRR062634_2.filt.gzip

real	40m46.277s
user	40m40.093s
sys	0m17.391s
1822600	./compressed/SRR062634_2.filt.gzip
gzip decompression: ./compressed/SRR062634_2.filt.gzip -> ./decompressed/SRR062634_2.filt_gzip.fastq

real	0m45.747s
user	0m41.967s
sys	0m3.542s
6196724	./decompressed/SRR062634_2.filt_gzip.fastq
```