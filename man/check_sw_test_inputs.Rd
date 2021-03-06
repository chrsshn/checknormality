% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sw_test.R
\name{check_sw_test_inputs}
\alias{check_sw_test_inputs}
\title{Check for valid parameters for a sw_test call}
\usage{
check_sw_test_inputs(vec_value, approach)
}
\arguments{
\item{vec_value}{vector containing data points; integer or double}

\item{approach}{designation of the approach to be used; character, one of
"original", "modified", or "royston"}
}
\value{
approach_to_use is the recommended approach and may not be identical
to what the user initially chose; character, one of "original", "modified",
or "royston"
}
\description{
This function checks that the parameters for a sw_test call are acceptable.
When parameters are not acceptable, errors are thrown. When parameters need
minor adjustments, warnings are thrown. Because this function is highly
specific to checknormality::sw_test(), this function is not exported.
}
