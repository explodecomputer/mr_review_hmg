library(ggplot2)
library(plyr)
library(diagram)

#############################
#############################

# GRAPHS

pdf("~/repo/mr_review_hmg/dag.pdf", width=12,height=6)

par(mfrow=c(1,2))


#############################
#############################

M <- as.data.frame(matrix(0, 5, 5))
M[[3,2]] <- "(3)" 
M[[4,2]] <- ""
M[[5,2]] <- ""
M[[4,3]] <- "(1)"
M[[5,3]] <- "(2)"
M[[5,4]] <- ""

col <- matrix(0, nrow(M), ncol(M))
col[] <- "blue"
col[3,2] <- "red"
col[5,3] <- "red"


width <- col
width[width == "blue"] <- 2

cur <- col
cur[cur == "black"] <- 0.1
cur[cur != 0.1] <- 0
cur <- matrix(as.numeric(cur), nrow(M))

at <- col
at[at == "black"] <- "circle"
at[at != "circle"] <- "triangle"


ap <- col
ap[ap == "black"] <- 0.5
ap[ap != 0.5] <- 0.5
ap <- matrix(as.numeric(ap), nrow(M))

curviture <- matrix(0, nrow(M), ncol(M))
curviture[5,3] <- 0.2

boxsize <- c(0, rep(0.09, 4))

dag <- plotmat(M
	,curve = curviture
	,pos =c(2,3)
	,name = c("", "Confounders", expression(Z[A]), "Trait A", "Trait B")
	,box.size = boxsize
	# ,arr.pos = t(ap)
	,lwd = 1
	,box.lwd = 2
	,box.cex = 0.8
	,cex.txt = 1.2
	,arr.lcol = col
	,arr.col = col
	,arr.lwd = t(width)
	,arr.type = t(at)
	,box.type = "square"
	,box.prop = 0.5
	,main = "A: Standard MR"
	,shadow.size=0
)


#############################
#############################



M <- as.data.frame(matrix(0, 5, 5))
M[[2,1]] <- "" 
M[[3,1]] <- ""
M[[2,4]] <- ""
M[[3,5]] <- ""
M[[3,2]] <- ""

col <- matrix(0, 5, 5)
col[] <- "blue"
col[2,3] <- col[3,2] <- "blue"

width <- col
width[width == "blue"] <- 2
width[width == "blue"] <- 2
width[width == "red"] <- 1

cur <- col
cur[cur == "blue"] <- 0.1
cur[cur != 0.1] <- 0
cur <- matrix(as.numeric(cur), 5, 5)

at <- col
at[at == "blue"] <- "triangle"
at[at != "circle"] <- "triangle"


ap <- col
ap[ap == "blue"] <- 0.5
ap[ap != 0.5] <- 0.6
ap <- matrix(as.numeric(ap), 5, 5)



dag <- plotmat(M
	,curve = 0
	,pos =c(1,2,2)
	,name = c("Confounders", "Trait A", "Trait B", expression(Z[A]), expression(Z[B]), expression(G[A]), expression(G[P]), expression(G[B]))
	,box.size = 0.09
	,arr.pos = t(ap)
	,lwd = 1
	,box.lwd = 2
	,box.cex = 0.8
	,cex.txt = 1.2
	,arr.lcol = t(col)
	,arr.col = t(col)
	,arr.lwd = t(width)
	,arr.type = t(at)
	,box.type = "square"
	,box.prop = 0.5
	,main = "B: Bi-directional MR"
	,shadow.size=0
)



dev.off()
