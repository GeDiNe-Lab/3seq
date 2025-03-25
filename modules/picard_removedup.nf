process PICARD_REMOVEDUP {
    tag "$sample"

    conda "modules/picard.yml"

    input:
    val sample
    path bam_R2_by_coord_umis_RG
    path outdir

    output:
    val(sample), emit: sample
    path "${sample}_R2.sortedByCoordinates.with_umis.with_RG.Rdup.bam", emit: bam_R2_by_coord_umis_RG_Rdup

    script:
    """
    picard -Xmx16G UmiAwareMarkDuplicatesWithMateCigar \
        -I $bam_R2_by_coord_umis_RG \
<<<<<<< HEAD
        -O ${sample}_R2.sortedByCoordinates.with_umis.with_RG.Rdup.bam \
        --UMI_METRICS ${sample}_R2.umi_metrics.txt \
=======
        -M "${outdir}${sample}_R2.metrics.txt" \
        -O "${sample}_R2.sortedByCoordinates.with_umis.with_RG.Rdup.bam" \
        -UMI_METRICS "${outdir}${sample}_R2.umi_metrics.txt" \
>>>>>>> c8e40c5553aaf3e81b7b315c34c69365fd6d6d65
        --REMOVE_DUPLICATES true
    """
}
