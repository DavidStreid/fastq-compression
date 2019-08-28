# Compression Project

## Algorithms Tested
### Generic Methods
* gzip
* bzip2/pbzip2
* xz
* pigz

### Specialized Methods for Genetic Data (w/ Reference)
* Fqzcomp/FastQz

### Specialized Methods for Genetic Data (w/o Reference)
* Gtz (Reference: https://gtz.io/GCF_000001405.37_GRCh38.p11_genomic.fna.gz)

## Results
| Algorithm  | Compressed Size | Compression Ratio  | Time        | CPU (%)* | MEM*    |
| ---------- | --------------- | ------------------ | ----------- | -------- | ------- |
| None       | 12393856        | 1                  | 0           | 0        | 0       | 
| gzip       | 3671296         | 0.2962190298       | 31m44.590s  | 99.7     | 624K    |
| bzip2      | 3016552         | 0.2433909189       | 9m11.744s   | 99.9     | 6816K   |
| pbzip2     | 3015288         | 0.2432889328       | 3m29.235s   | 1538.8   | 22M+    |
| xz         | 2916464         | 0.2353153046       | 124m48.642s | 99.9     | 360M+   |
| pigz       | 3671744         | 0.2962551768       | 3m48.276s   | 1552.3   | 11M     |
| gtz        | 1133924         | 0.09149081609      | 2m1.774s    | 197.3    | 1.49G+  |

\* Taken from ```top```
## Development
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
### Setup
```
$ mkdir fastq    # Add fastq files here
```

### Run
While running, creates two directories to output compressed & decompressed files 
```
$ ./compression_test.sh > compress.log &
$ tail -f compress.log
```

## Implementation
For the generic options, the best compression (slowest time) option was selected. 

## Notes
Run ```top``` command while running script to view cpu load

MAC
```
$ top -u

PID    COMMAND      %CPU      TIME     #TH    #WQ   #PORT MEM    PURG   CMPRS  PGRP  PPID  STATE    BOOSTS            %CPU_ME %CPU_OTHRS UID
28472  xz           99.9      00:58.15 1/1    0     10    360M+  0B     0B     25742 28471 running  *0[1]             0.00000 0.00000    1774903000
31836  gzip         99.7      00:53.51 1/1    0     10    624K   0B     0B     25742 31835
32660  bzip2        99.9      00:37.05 1/1    0     10    6816K  0B     0B     25742 32659 running  *0[1]             0.00000 0.00000    1774903000 1950      59       24         11         80977+     54         902+        4        2
32686  pbzip2       1538.8    10:35.51 20/17  0     33    22M+   0B     0B     25742 32685 running  *0[1]             0.00000 0.00000    1774903000 40868+    63       37         13         355433+    304        833505+     15       0
```

LINUX
```
$ top       # 'P' to sort by CPU

PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
12602 streidd   20   0 2752972   1.4g  16788 S 197.3 18.7   3:30.84 gtz
```

## Data
All files were taken from the 1000 Genomes Project
* HG00096: ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00096/sequence_read/
* HG00097: ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase3/data/HG00097/sequence_read/



