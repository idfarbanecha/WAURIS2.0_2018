setwd("C:/Users/Farid/OneDrive/Documents/Biologie Master Bioinfo/Cours/Write a review")
library(ggplot2)
library(dplyr)
counlist=read.table(file='Countries.txt',header = T,sep='\t')
epi=paste(counlist$Country,counlist$Year,sep='_')
counlist$epi=epi
world_map <- map_data("world")
world_map %>% filter(region != "Antarctica")->world_map
world_map=fortify(world_map)

p <- ggplot() + coord_fixed() +
  xlab("") + ylab("")
base_world_messy <- p + geom_polygon(data=world_map, aes(x=long, y=lat, group=group), 
                                     colour="#7f7f7f", fill="white")
base_world_messy
cleanup <- 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "white"),
        axis.ticks=element_blank(), axis.text.x=element_blank(),
        axis.text.y=element_blank())
base_world=base_world_messy+cleanup
base_world
zoom=base_world+coord_cartesian(xlim=c(-110,139),ylim=c(-31, 60))
zoom
zoom+ggtitle('')+geom_jitter(data=counlist,position=position_jitter(width=1.2, height=1.2),aes(x=lon, y=lat, color=Year,size=n),alpha=0.7,stroke=2)+labs(colour='Outbreak years')+theme(plot.title = element_text(size = '15',face = 'bold.italic',hjust = 0.5))#+scale_size_continuous(range = c(5,13))


#Points with the same size but colors corresponding to the number of isolates for each outbreak:

zoom+ggtitle('C.auris outbreaks from 1996 to 2017 across the world')+geom_jitter(data=counlist,position=position_jitter(width=1.3, height=1.3),aes(x=lon, y=lat,color=n),size=5,stroke=2,alpha=0.7)+labs(colour='Isolates per outbreak')+theme(plot.title = element_text(size = '15',face = 'bold.italic',hjust = 0.5))+scale_colour_continuous(low="thistle2", high="darkred", guide="colorbar")

#Without zoom:
base_world+ggtitle('')+geom_jitter(data=counlist,position=position_jitter(width=1.1, height=1.1),aes(x=lon, y=lat, color=Year,size=n),alpha=0.7,stroke=2)+labs(colour='Outbreak years')+theme(plot.title = element_text(size = '15',face = 'bold.italic',hjust = 0.5))

#Cropped:
crop=base_world+coord_fixed(xlim=c(-110,139),ylim=c(-31, 60))
crop+ggtitle('')+geom_jitter(data=counlist,position=position_jitter(width=1.1, height=1.1),aes(x=lon, y=lat, color=Year,size=n),alpha=0.7,stroke=2)+labs(colour='Outbreak years')+theme(plot.title = element_text(size = '15',face = 'bold.italic',hjust = 0.5))
