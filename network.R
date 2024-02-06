
#https://minimaxir.com/notebooks/interactive-network/

library(dplyr)
library(nycflights13)
library(igraph)
library(intergraph)
library(sna)
library(ggplot2)
library(ggnetwork)
library(plotly)
library(ggnetwork)
library(geosphere)
library(GGally)
library(maps)

sessionInfo()

head(flights)

df_edges <- flights %>% group_by(origin, dest) %>% summarize(weight = n())
df_edges %>% arrange(desc(weight)) %>% head()

# blue, red, green
colors <- c("#3498db", "#e74c3c", "#2ecc71")

# seting alphabetical order; allows for predictable ordering later
origins = c("EWR", "JFK", "LGA")
df_colors <- tbl_df(data.frame(origin=origins, color=origins,color_val = colors))
df_edges <- df_edges %>% left_join(df_colors)

df_edges %>% arrange(desc(weight)) %>% head()

net <- graph.data.frame(df_edges, directed = T)
net #as a network

#Vertex Attributes
V(net)$degree <- centralization.degree(net)$res
V(net)$weighted_degree <- graph.strength(net)
V(net)$color_v <- c(origins, rep("Others", gorder(net) - length(colors)))


#airport description
df_airports <- data.frame(vname=V(net)$name) %>% left_join(airports, by=c("vname" = "faa"))

V(net)$text <- paste(V(net)$name,
                     df_airports$name,
                     paste(format(V(net)$weighted_degree, big.mark=",", trim=T), "Flights"),
                     sep = "<br>")
V(net)$long_name <- paste(df_airports$name," ",V(net)$name)
V(net)$text %>% head()

#adding lat and lon
V(net)$lat <- df_airports$lat
V(net)$lon <- df_airports$lon

# gives to/from locations; map to corresponding ending lat/long
end_loc <- data.frame(ename=get.edgelist(net)[,2]) %>% left_join(airports, by=c("ename" = "faa"))

#edge attributes
E(net)$endlat <- end_loc$lat
E(net)$endlon <- end_loc$lon



#GGally to convert network object to be used with ggplot

#net2 <-asNetwork(net) #not necessary

ggnet2(net,mode = "fruchtermanreingold",
       node.size = 2,
       label = TRUE,
       label.size = 2,
       edge.label.alpha = 1,
       edge.size = E(net)$weight / 10000,
       node.label = V(net)$long_name
)


ggsave(filename = here::here("graph_plot.pdf"))
#or
#usa <- ggplot(map_data("usa"), aes(x = long, y = lat)) +
#  geom_polygon(aes(group = group), color = "grey65",
#               fill = "#f9f9f9", size = 0.2)


#ggnetworkmap(usa,net2,size = 1,great.circles = TRUE,
#             segment.color = "steelblue"
#            )
