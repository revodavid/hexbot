library(httr)
endpoint <- "https://api.noopschallenge.com/hexbot"

## get a single color, and display on screen

random.color <- function() {
 hexbot <- GET(endpoint)
 content(hexbot)$colors[[1]]$value
}

rcol <- random.color()
barplot(1, col=rcol, main=rcol, axes=FALSE)

## get n colors at once

random.colors <- function(n) {
 hexbot <- GET(endpoint, query=list(count=n))
 unlist(content(hexbot)$colors)
}

ncol <- 5
barplot(rep(1,ncol),col=random.colors(ncol), axes=FALSE)

## get n colors with locations

random.points <- function(n,width=100,height=100) {
 hexbot <- GET(endpoint, query=list(count=n, width=width, height=height))
 data <- matrix(unlist(content(hexbot)$colors),ncol=3,byrow=TRUE)
 cols <- data[,1]
 x <- as.numeric(data[,2])
 y <- as.numeric(data[,3])
 data.frame(cols, x, y)
}

with(random.points(25,100,100), 
     plot(x,y,col=cols,xlim=c(0,100), ylim=c(0,100)))
