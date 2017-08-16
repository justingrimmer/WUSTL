######putting together some example R code

load('~/dropbox/teaching/text/tad14/class9/FlakeMatrix.RData')

##that loads flake_matrix

extra_stop<- c('rep', 'jeff', 'flake', '2022252635', 'matthew', 'jagirdar', 'email', 'byline','specht', 'sarabjit', 'dateline')

flake_matrix<- flake_matrix[-c(603, 604),-which(colnames(flake_matrix)%in% extra_stop)]


?kmeans

flake_norm<- flake_matrix
for(z in 1:nrow(flake_norm)){
	flake_norm[z,]<- flake_norm[z,]/sum(flake_norm[z,])
	}


n.clust<- 3
set.seed(8675309) ##complicated objective function
k_cluster<- kmeans(flake_norm, centers = n.clust)
table(k_cluster$cluster)

##labeling the topics
##just use the ``biggest" in each category
key_words<- matrix(NA, nrow=n.clust, ncol=10)
for(z in 1:n.clust){
	key_words[z,]<- colnames(flake_matrix)[order(k_cluster$center[z,], decreasing=T)[1:10]]
	}

##we can then try to compare the ``relative" strong words

key_words2<- matrix(NA, nrow=n.clust, ncol=10)
for(z in 1:n.clust){
	diff<- k_cluster$center[z,] - apply(k_cluster$center[-z, ], 2, mean)
	key_words2[z,]<- colnames(flake_matrix)[order(diff, decreasing=T)[1:10]]
	}


setwd('/Users/justingrimmer/dropbox/HousePress/JEFF_FLAKE_20100')
file.show(rownames(flake_matrix)[which(k_cluster$cluster==2)[11]])
file.show(rownames(flake_matrix)[which(k_cluster$cluster==2)[20]])
cluster2<- which(k_cluster$cluster==2)
for(z in 1:len(cluster2)){
	file.show(rownames(flake_matrix)[which(k_cluster$cluster==2)[z]])
	readline('wait')
	}


