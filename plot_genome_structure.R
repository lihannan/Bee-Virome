args = commandArgs(T)
#library(devEMF)
in_file = args[1]

orf_distance = 2.5

data = read.table(in_file,header=T,sep='\t',stringsAsFactor=F,na.strings = "Nan")

genomes = data$genome[!duplicated(data$genome)]
genome_num = length(genomes)
max_length = max(data$end)
plot_genome=function(){
	par(mar=c(0,2,0,2))
#	layout(matrix(1:genome_num))
	plot(c(1,1),type='n',xlim=c(1,max_length),ylim=c(1,genome_num*50),yaxt="n",xaxt="n",xlab="",ylab="",bty="n")
	genome_high = 50
	for (genome in genomes){
		temp_data = data[data$genome == genome,]
		genome_name = temp_data$genome[1]
		genome_length = temp_data$end[1]
		orfs = temp_data[,c(4,5,6,7)]
		rect(1,genome_high-4-0.1,genome_length,genome_high-4+0.1,col="gray33")
		text((1+genome_length)/2,genome_high - 12,genome_name,cex=0.7)
		#text(1,genome_high-10,1,cex=0.5)
		text(genome_length+30,genome_high-4+1.5,genome_length,cex=0.5)
		orf_plot = temp_data[,c(4,5,6,7,8,9,10)]
		for (i in 1:dim(orf_plot)[1]){
			orf_level = orf_plot[i,][1]
			orf_name = orf_plot[i,][7]
			orf_start = orf_plot[i,][2]
			orf_end = orf_plot[i,][3]
			polygon(c(orf_start,orf_end-80,orf_end,orf_end-80,orf_start),c(genome_high-4-1-(orf_distance*orf_level),genome_high-4-1-(orf_distance*orf_level),genome_high-4-(orf_distance*orf_level),genome_high-4+1-(orf_distance*orf_level),genome_high-4+1-(orf_distance*orf_level)),col="seashell2")
			if ( !is.null(orf_name) ){
				#text((orf_start+orf_end)/2,genome_high-8-(4*orf_level),orf_name,cex=0.5)
			}
			if ( orf_plot[i,][4] != "NA" ) {
				diamond_start = orf_plot[i,][5]
				diamond_end = orf_plot[i,][6]
				diamond_name = orf_plot[i,][4]
			rect(orf_start + 3*diamond_start,genome_high-4-1-(orf_distance*orf_level),orf_start + 3*diamond_end,genome_high-4+1-(orf_distance*orf_level),angle = 45,col="goldenrod1")
			text((orf_start + 3*diamond_start+orf_start + 3*diamond_end)/2,genome_high-6-(orf_distance*orf_level),diamond_name,cex=0.4)
			}
		}
		genome_high = genome_high + 50
	}
}

pdf(paste(in_file,'.pdf',sep=''),width=max_length/1000,height=genome_num*2.5)
plot_genome()
dev.off()
#emf(paste(in_file,'.emf',sep=''))
#plot_genome()
#dev.off()
