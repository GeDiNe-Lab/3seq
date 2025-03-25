process PICARD_REMOVEDUP {
    tag "$sample"

    conda "modules/picard.yml"

    input:
    val sample
    path bam_R2_by_coord_umis_RG
    path outdir

    output:
    val(sample), emit: sample
    path "${sample}_R2.sortedByCoordinates.with_umis.with_RG.bam", emit: bam_R2_by_coord_umis_RG_Rdup

    script:
    """
    picard -Xmx16G UmiAwareMarkDuplicatesWithMateCigar \
        -I $bam_R2_by_coord_umis_RG \
        -O "${sample}_R2.sortedByCoordinates.with_umis.with_RG.Rdup.bam" \
        --REMOVE_DUPLICATES true
    """
}
