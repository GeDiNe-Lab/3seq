process SAMTOOLS_EXTRACT {
    tag "$sample"

    conda "modules/samtools.yml"

    input:
    val sample
    path bam_R2_by_coord_umis_RG_Rdup
    path outdir

    output:
    val(sample), emit: sample
    path "${sample}.fastq.gz", emit: fastq_extracted

    script:
    """
    samtools fastq \
    -0 "${sample}.fastq.gz" \
    -n $bam_R2_by_coord_umis_RG_Rdup
    """
}
