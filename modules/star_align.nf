process STAR_ALIGN {
    tag "$sample"

    conda "modules/star.yml"

    input:
    val(sample)
    path(trimmed_reads)
    path genome_dir
    path outdir

    output:
<<<<<<< HEAD
    val sample, emit: samples
    path "${sample}.Aligned.sortedByCoord.out.bam", emit: bam_R2
=======
    path "${sample}_R2.star1.Aligned.sortedByCoord.out.bam", emit: bam_R2
>>>>>>> af78858d100ddafcab7e499aa44cb8ee2d8c2f0f

    script:
    def read2 = trimmed_reads instanceof Path ? trimmed_reads : trimmed_reads[1] // Sélection du deuxième read
    """
    STAR --runThreadN 5 \
         --genomeDir ${genome_dir} \
         --readFilesIn ${read2} \
         --outFileNamePrefix ${sample}. \
         --outSAMtype BAM SortedByCoordinate \
         --quantMode GeneCounts \
         --twopassMode Basic \
         --readFilesCommand zcat
    
    mv ${sample}.Aligned.sortedByCoord.out.bam ${outdir}/
   """
}
