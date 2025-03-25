process FGBIO {
    tag "$sample"

    conda "modules/fgbio.yml"

    input:
    val sample
    path trimmed_reads
    path --output_sambamba--
    path outdir

    output:
    path "${sample}_R2.sortedByName.with_umis.bam", emit: bam_R2_by_name_with_umis

    script:
    def read1 = trimmed_reads instanceof Path ? trimmed_reads : trimmed_reads[0] // Sélection du premier read
    """
    fgbio -Xmx32G AnnotateBamWithUmis \
        -i $--output_sambamba-- \
        -f $read1 \
        -o "${sample}_R2.sortedByName.with_umis.bam"
    """
}
