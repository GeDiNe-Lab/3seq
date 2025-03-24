nextflow.enable.dsl=2

include { FASTQC } from './modules/nf-core/fastqc'

workflow {
    Channel.fromPath('data/*.fastq.gz')
        .set { reads }

    FASTQC(reads)
}