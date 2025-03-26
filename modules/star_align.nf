process STAR_ALIGN {
    tag "$sample"
    label 'process_high'

    conda "modules/star.yml"

    publishDir "${params.outdir}/star_align", mode: 'copy'

    input:
    val sample
    path trimmed_reads
    path genome_dir
    path outdir

    output:
    val sample, emit: sample
    path "${sample}.Aligned.sortedByCoord.out.bam", emit: bam_R2

    script:
    def read2 = trimmed_reads instanceof Path ? trimmed_reads : trimmed_reads[1] // Sélection du deuxième read
    """
    STAR --runThreadN 5 \
         --genomeDir "$genome_dir" \
         --readFilesIn ${read2} \
         --outFileNamePrefix ${sample}. \
         --outSAMtype BAM SortedByCoordinate \
         --quantMode GeneCounts \
         --twopassMode Basic \
         --readFilesCommand zcat
    """
}
