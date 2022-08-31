import sys
name = sys.argv[1]
fasta_file = sys.argv[2]

name_list = [ line.strip() for line in open(name).readlines() ]


gene_dict = {}
gene_data = open(fasta_file).read().replace(">","$>").split('$')[1:]
for gene in gene_data:
	gene_name = gene.splitlines()[0].split()[0][1:]
	gene_dict[gene_name] = gene
	
out_temp = []
for gene in list(set(name_list)):
	out_temp.append(gene_dict[gene])
	
out = open(name + '.fasta','w')
out.write(''.join(out_temp))
out.close()
