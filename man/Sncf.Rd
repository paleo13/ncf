\name{Sncf}
\alias{Sncf}
\title{Nonparametric (cross-)correlation function for spatio-temporal data}
\description{
  Sncf is the function to estimate the nonparametric (cross-)correlation 
  function using a smoothing spline as an equivalent kernel. The function
  requires multiple observations at each location (use \code{\link{spline.correlog}} otherwise).  
}

\usage{
Sncf(x, y, z, w = NULL, df = NULL, type = "boot", resamp = 1000, 
npoints = 300, save = FALSE, filter = FALSE, fw = 0, max.it = 25, 
xmax = FALSE, na.rm = FALSE, latlon = FALSE, circ = FALSE, quiet = FALSE)
}

\arguments{
  \item{x}{vector of length n representing the x coordinates (or longitude; see latlon).}
  \item{y}{vector of length n representing the y coordinates (or latitude).}
  \item{z}{matrix of dimension n x p representing p observation at each location.}
  \item{w}{an optional second matrix of dimension n x p for species 2 
    (to estimate the spatial cross-correlation function).}
  \item{df}{degrees of freedom for the spline. Default is sqrt(n).}
  \item{type}{takes the value "boot" (default) to generate a bootstrap 
    distribution or "perm" to generate a null distribution for the estimator}
  \item{resamp}{the number of resamples for the bootstrap or the 
    null distribution. }
  \item{npoints}{the number of points at which to save the 
           value for the spline function (and confidence 
           envelope / null distribution). }
  \item{save}{if TRUE the whole matrix of output from the 
           resampling is saved (an resamp x npoints 
           dimensional matrix). }
  \item{filter}{if TRUE the Fourier filter method of Hall and 
           coworkers is applied to ensure positive 
           semidefiniteness of the estimator. 
       (more work may be needed on this.)}
  \item{fw}{if filter is TRUE, it may be useful to 
           truncate the function at some distance w sets 
           the truncation distance. when set to zero no 
           truncation is done.}
  \item{max.it}{the maximum iteration for the Newton method
           used to estimate the intercepts.}
  \item{xmax}{if FALSE the max observed in the data is used. 
       Otherwise all distances greater than xmax is
       omitted.}
  \item{na.rm}{if TRUE, NA's will be dealt with through 
           pairwise deletion of missing values for each
           pair of time series -- it will dump if any one
           pair has less than two (temporally) overlapping
           observations.}
  \item{latlon}{if TRUE, coordinates are latitude and 
           longitude.}
  \item{circ}{if TRUE, the observations are assumed to be 
           angular (in radians), and circular correlation is used.}
  \item{quiet}{if TRUE the counter is supressed during execution.}
}

\details{
  Missing values are allowed -- values are assumed missing at 
  random.

  The circ argument computes a circular version of the Pearson's product 
  moment correlation (see \code{\link{cor2}}). This option is to calculate
  the 'nonparametric phase coherence function' (Grenfell et al. 2001)
}

\value{
  An object of class "Sncf" is returned, consisting of the following components:
  \item{real}{The list of estimates from the data.}
  \item{$cbar}{the regional average correlation.}
  \item{$x.intercept}{the lowest value at which the function is = 0. 
    If correlation is initially negative, the distance is given as negative.}
  \item{$e.intercept}{the lowest value at which the function 1/e.}
  \item{$y.intercept}{the extrapolated value at x=0 (nugget).}
  \item{$cbar.intercept}{distance at which regional average
        correlation is reach.}
  \item{$predicted$x}{the x-axes for the fitted covariance function.}
  \item{$predcited$y}{the values for the covariance function.}

  \item{boot}{A list with the analogous output from the 
              bootstrap or null distribution.} 
  \item{$summary}{gives the full vector of output for the
              x.intercept, 
              y.intercept, 
              e.intercept, 
              cbar.intercept, 
              cbar 
              and a quantile summary for the resampling distribution.}
  \item{$boot}{if save=TRUE the full raw matrices from the 
              resampling is saved.}
  \item{max.distance}{the maximum spatial distance considered.}
} 

\references{
Hall, P. & Patil, P. (1994) Properties of nonparametric estimators of autocovariance 
for stationary random fields. Probability Theory and Related Fields, 99:399-424. 

Hall, P., Fisher, N.I. & Hoffmann, B. (1994) On the nonparametric 
estimation of covariance functions. Annals of Statistics, 22:2115-2134. 

Bjornstad, O.N. & Falck, W. (2001) Nonparametric spatial covariance 
functions: estimation and testing. Environmental and Ecological Statistics, 8:53-70.
 
Bjornstad, O.N., Ims, R.A. & Lambin, X. (1999) Spatial 
population dynamics: Analysing patterns and processes of 
population synchrony. Trends in Ecology and Evolution, 11:427-431.

Bjornstad, O. N., and J. Bascompte. (2001) Synchrony and second order 
spatial correlation in host-parasitoid systems. Journal of Animal Ecology 70:924-933.

Grenfell, B.T., Bjornstad, O.N., & Kappey, J. (2001) Travelling waves and 
spatial hierarchies in measles epidemics. Nature 414:716-723.
}

\author{Ottar N. Bjornstad \email{onb1@psu.edu}}

\seealso{\code{\link{summary.Sncf}} 
\code{\link{plot.Sncf}} 
\code{\link{Sncf2D}}
\code{\link{Sncf.srf}}
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
#w data from a gaussian random field
    w <- cbind(
        rmvn.spa(x=x, y=y, p=2, method="gaus"),
        rmvn.spa(x=x, y=y, p=2, method="gaus")
        )
#multivariate nonparametric covariance function
    fit1 <- Sncf(x=x, y=y, z=z, resamp = 5)
    \dontrun{plot.Sncf(fit1)}
    summary.Sncf(fit1)

#multivariate nonparametric cross-covariance function
    fit2 <- Sncf(x=x, y=y, z=z, w=w, resamp = 5)
    \dontrun{plot.Sncf(fit2)}
    summary.Sncf(fit2)
}

\keyword{smooth}
\keyword{regression}
\keyword{spatial}
