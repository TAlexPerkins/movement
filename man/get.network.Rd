\name{get.network}
\alias{get.network}

\title{
Extract the necessary components for movement modelling form a population density raster.
}
\description{
Given raster map of population density, extract a distance matrix and vector of population sizes for all cells with population density above a minimum threshold. These can be used as network representation of the landscape for use in movement models.
}
\usage{
get.network(raster, min = 1, matrix = TRUE)
}

\arguments{
  \item{raster}{
A \code{RasterLayer} object of population density.
}
  \item{min}{
The minimum population size for inclusion in the netwrk. All cells with populations greater than or equal to \code{min} will be included and other excluded.
}
  \item{matrix}{
Whether the distance matrix should be returned as a \code{matrix} object (if \code{TRUE}) or as a \code{dist} object (if \code{FALSE}).
}
}

\value{
A list with three components:
  \item{population }{A vector giving the populations at the cells of interest}
  \item{distance_matrix }{A distance matrix (eith of class \code{matrix} or \code{dist}) diving the pairwise euclidean distance between the cells of interest in the units of \code{raster}}
  \item{coordinate }{A two-column matrix giving the coordinates of the cells of interest in the units of \code{raster}}
}

\seealso{
\code{\link{raster}}, \code{\link{dist}}, \code{\link{movement.model}}
}
\examples{
# load kenya raster
data(kenya)

# aggregate to 10km to speed things up
kenya10 <- aggregate(kenya, 10, sum)

# get the network for pixels with at least 50,000 inhabitants
net <- get.network(kenya10, min = 50000)

# visualise the distance matrix
plot(raster(net$distance_matrix))

# plot the raster layer
plot(kenya10)

# rescale the population of those pixels for plotting
size <- 0.1 + 2 * net$population / max(net$population)

# plot the pixels selected, with point size proportional to population size
points(net$coordinates, pch = 16,
     cex = size,
     col = rgb(0, 0, 1, 0.6))
}