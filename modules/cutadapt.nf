process CUTADAPT {
    tag "$sample"

    publishDir "${params.outdir}/cutadapt", mode: 'copy'
    conda "modules/cutadapt.yml"
    
    input:
    tuple val(sample), path(reads)

    output:
    val(sample), emit: sample
    tuple path("${sample}_R1.cut_clean.fastq.gz"), path("${sample}_R2.cut_clean.fastq.gz"), emit: trimmed_reads

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
    
    gzip ${sample}_R1.cut_clean.fastq
    gzip ${sample}_R2.cut_clean.fastq

    gzip ${sample}_R1.cut_clean.fastq
    gzip ${sample}_R1.cut_clean.fastq

    rm ${sample}_R1.temp.fastq
    """
}
