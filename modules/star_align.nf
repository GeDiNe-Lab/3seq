process STAR_ALIGN {
    tag "$sample"

    conda "./star_align.yml"

    input:
    val sample
    val trimmed_reads

    output:
    val sample, emit: sample
    path "${sample}_R2.star1.Aligned.sortedByCoord.out.bam", emit: bam_R2


    script:
    """
    STAR --runThreadN 5 --genomeDir ${star_genome} --readFilesIn ${trimmed_reads[2]} --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --twopassMode Basic --outFileNamePrefix ${sample}_R2.star1.
    """
}
