ARG HTS_NIM_TAG=sha-f4fd991
FROM runsascoded/hts-nim:$HTS_NIM_TAG

# for nextflow
RUN apk add bash procps

COPY . /somalier
WORKDIR somalier
RUN nimble install -y nimble \
 && /root/.nimble/bin/nimble install -d -y \
 && nim c -d:danger -d:nsb_static -d:release -d:openmp -d:blas=openblas -d:lapack=openblas -o:/usr/bin/somalier src/somalier \
 && cp scripts/ancestry-labels-1kg.tsv / \
 && rm -rf /somalier \
 && somalier --help

ENV somalier_ancestry_labels /ancestry_labels-1kg.tsv
