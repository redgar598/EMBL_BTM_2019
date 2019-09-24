HY_edges<-read.csv("../../../../Downloads/HY_edges.csv")
HY_edges$injection<-"1097"
HY_edges$X<-NULL
HY_edges<-HY_edges[,c(20,14,1:13,15:19)]


HY_nodes<-read.csv("../../../../Downloads/HY_nodes.csv")
HY_nodes$X<-NULL
colnames(HY_nodes)[5]<-"full_name"


VISp_edges<-read.csv("../../../../Downloads/VISp_edges.csv")
VISp_edges$injection<-"385"
VISp_edges$X<-NULL
VISp_edges<-VISp_edges[,c(20,14,1:13,15:19)]

VISp_nodes<-read.csv("../../../../Downloads/VISp_nodes.csv")
VISp_nodes$X<-NULL
colnames(VISp_nodes)[5]<-"full_name"


# combine
nodes<-rbind(VISp_nodes,HY_nodes)
nodes<-nodes[,c(4,1,5)]
nodes$acronym<-as.character(nodes$acronym)
nodes$full_name<-as.character(nodes$full_name)

nodes[nrow(nodes) + 1,] = c("385","VISp","Primary visual area")
nodes<-nodes[!duplicated(nodes), ]
nodes$injection_source<-sapply(1:nrow(nodes), function(x){
  if(nodes$id[x]%in%c("385","1097")){"source"}else{"target"}
})


edges<-rbind(VISp_edges,HY_edges)
edges$is_injection<-NULL

write.csv(nodes,"network_visualization/data/nodes_allen.csv", row.names = F, quote=F)
write.csv(edges,"network_visualization/data/edges_allen.csv", row.names = F, quote=F)
