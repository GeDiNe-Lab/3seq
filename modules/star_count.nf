process STAR_COUNT {
    tag "$sample"
    label 'process_high'

    conda "modules/star.yml"

    publishDir "${params.outdir}/star_count", mode: 'copy'

    input:
    val sample
    path fastq_extracted
    path genome_dir
    path outdir

    output:
    val sample, emit: sample
    path "${sample}.star_count.", emit: bam_R2

    script:
    """
    STAR --runThreadN 5 \
        --genomeDir $genome_dir} \
        --readFilesIn ${fastq_extracted} \
        -- readFilesCommand zcat \
        --outSAMtype BAM SortedByCoordinate \
        --quantMode GeneCounts \
        --outFileNamePrefix ${sample}.star_count.
    """
}
