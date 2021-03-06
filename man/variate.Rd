% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/variate.R
\name{variate}
\alias{variate}
\title{Simplify to variate}
\usage{
variate(
  x,
  type = c("prop", "non_prop"),
  prop_log = TRUE,
  mapping = NULL,
  degree = 1
)
}
\arguments{
\item{x}{Unquoted symbol. Predictor to be simplified. Must be present in the modeling dataset.}

\item{type}{Character scalar. One of \code{prop} or \code{non_prop}, specifying proportional and unproportional variate.}

\item{prop_log}{Boolean scalar. Whether the proportional variate should be logged (recommended).}

\item{mapping}{Integer vector. Mapping to use for simplification. Length must be equal to length of unique levels of the predictor.}

\item{degree}{Integer scalar. Polynomial degree to use.}
}
\value{
Original vector with updated attributes.
}
\description{
Simplifies simple factor to variate, which usually means that monotonic trend is enforced and some of the levels may be merged together.
Must be used within \code{factor_modify} function. This is usually done with originally continuous variables.
}
\examples{
require(dplyr) # for the pipe operator
data('sev_train')

setup <- setup(
  data_train = sev_train,
  target = 'sev',
  weight = 'numclaims',
  family = 'gamma',
  keep_cols = c('pol_nbr', 'exposure', 'premium')
)

modeling <- setup \%>\%
  factor_add(pol_yr) \%>\%
  factor_add(agecat) \%>\%
  model_fit() \%>\%
  model_save('model1') \%>\%
  factor_modify(agecat = variate(agecat, type = 'non_prop', mapping = c(1, 2, 3, 4, 5, 6))) \%>\%
  model_fit()

}
\seealso{
\code{\link{factor_modify}}
}
