\name{lisa.nc}
\alias{lisa.nc}
\title{Non-centered inidcators of spatial association}
\description{
  lisa.nc is a function to estimate the (noncentred) local indicators of
  spatial association. The function requires multiple observations at each location.
  For single observations at each location use \code{lisa}
}

\usage{
    lisa.nc(x, y, z, neigh, na.rm = FALSE, resamp=1000, 
    latlon = FALSE, quiet = FALSE)
    }

\arguments{
  \item{x}{vector of length n representing the x coordinates (or latitude; see latlon).}
  \item{y}{vector of length n representing the y coordinates (or longitude).}
  \item{z}{a matrix of dimension n x p 
        representing p (>1) observation at each location.}
  \item{neigh}{neighborhood size.}
  \item{resamp}{number of resamples under the NULL to generate p-values}
  \item{latlon}{Not yet implemented: if TRUE, coordinates are latitude and
          longitude.}
  \item{na.rm}{if TRUE, NA's will be dealt with through 
           pairwise deletion of missing values.}
  \item{quiet}{if TRUE the counter is supressed during execution.}
}

\details{
  This is the function to estimate the (non-centered) local indicators of spatial 
  association modified form Anselin (1995). 'correlation' is the average correlation within
  a neighborhood. The function requires multiple observations at each location.  
  
  Missing values are allowed -- values are assumed missing at 
  random.
}

\value{
  An object of class "lisa" is returned, consisting of
  the following components:
  \item{n}{the number of pairs within each neighborhood.}
  \item{dmean}{the actual mean of distance within each neighborhood.}
  \item{correlation}{the mean correlation within the neighborhood (neigh).}
  \item{p}{the permutation two-sided p-value for each distance-class.}
  \item{coord}{a list with the x and y coordinates.}
}

\references{
Anselin, L. 1995. Local indicators of spatial association - LISA. Geographical Analysis 27:93-115.
}

\author{Ottar N. Bjornstad \email{onb1@psu.edu}}

\seealso{
\code{\link{lisa}}
\code{\link{plot.lisa}}
}

\examples{
#first generate some sample data
    x <- expand.grid(1:20, 1:5)[,1]
    y <- expand.grid(1:20, 1:5)[,2]

#z data from an exponential random field
    z <- cbind(
        rmvn.spa(x=x, y=y, p=2, method="exp"),
        rmvn.spa(x=x, y=y, p=2, method="exp")
        )

#lisa.nc analysis
    fit1 <- lisa.nc(x=x, y=y, z=z, neigh=3)
    \dontrun{plot.lisa(fit1)}
}

\keyword{spatial}
