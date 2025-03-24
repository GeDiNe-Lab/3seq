process STAR_ALIGN {
    tag "$sample"

    conda "modules/star.yml"

    input:
    // val sample
    val(trimmed_reads)
    // path star_genome

    output:
    // val sample, emit:sample
    // path "${sample}_R2.star1.Aligned.sortedByCoord.out.bam", emit: aligned_R2_bam
    stdout

    //STAR --runThreadN 5 --genomeDir ${star_genome} --readFilesIn ${trimmed_reads[2]} --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --twopassMode Basic --outFileNamePrefix ${sample}_R2.star1.

    script:
    """
    echo "25"
    echo "${trimmed_reads[0]}"
    echo "${trimmed_reads[1]}"
    echo "${trimmed_reads[2]}"
    """
}
