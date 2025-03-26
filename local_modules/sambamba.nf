process SAMBAMBA {
    tag "$sample"
    label 'process_low'

    conda "modules/sambamba.yml"

    publishDir "${params.outdir}/sambamba_sort", mode: 'copy'

    input:
    val sample
    path bam_R2
    path outdir

    output:
    val sample, emit: sample
    path "${sample}_R2.star1.sortedByName.bam", emit: bam_R2_by_name

    script:
    """
    sambamba sort -n -t 5 -o ${sample}_R2.star1.sortedByName.bam ${bam_R2}
    """
}
