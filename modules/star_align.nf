process STAR_ALIGN {
    tag "$sample"

    conda "modules/star.yml"

    input:
    val sample
    val trimmed_reads

    output:
    val sample, emit: sample
    path "${sample}_R2.star1.Aligned.sortedByCoord.out.bam", emit: bam_R2


    script:
    """
    echo "25"
    echo "${trimmed_reads[0]}"
    echo "${trimmed_reads[1]}"
    echo "${trimmed_reads[2]}"
    """
}
