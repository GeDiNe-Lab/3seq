process STAR_ALIGN {
    tag "$sample"

    conda "modules/star.yml"

    input:
    val sample
    val trimmed_reads
    path star_genome

    output:
    path "${sample}_R2.star1.Aligned.sortedByCoord.out.bam", emit: bam_R2


    script:
    """
    STAR --runThreadN 5 --genomeDir $star_genome --readFilesIn ${trimmed_reads[1]} --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --twopassMode Basic --outFileNamePrefix ${sample}_R2.star1.
    """
}
