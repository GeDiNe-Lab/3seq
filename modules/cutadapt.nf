process CUTADAPT {
    tag "$sample"

    conda "${baseDir}/conda-envs/cutadapt.yml"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("${sample}_R1.cut_clean.fastq"), path("${sample}_R2.cut_clean.fastq"), emit: trimmed_reads

    script:
    """
    cutadapt -j $task.cpus -u 4 --nextseq-trim=20 -a "A{100}" -m 50 \
        -o ${sample}_R2.temp.fastq \
        -p ${sample}_R1.temp.fastq \
        ${reads[1]} ${reads[0]}

    cutadapt -j $task.cpus -l 26 --nextseq-trim=20 \
        -o ${sample}_R1.cut_clean.fastq \
        ${sample}_R1.temp.fastq

    mv ${sample}_R2.temp.fastq ${sample}_R2.cut_clean.fastq

    rm ${sample}_R1.temp.fastq
    """
}
