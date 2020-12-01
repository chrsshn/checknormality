#include <Rcpp.h>
#include <math.h>
#include <cmath>
using namespace Rcpp;


//' Calculate the Rational Approximation
//'
//' This function was taken from https://www.johndcook.com/blog/cpp_phi_inverse/
//'
//'
//' @param t double
//' @return Product of v1 and v2
double RationalApproximation (double t) {
  // Abramowitz and Stegun formula 26.2.23.
  // The absolute value of the error should be less than 4.5 e-4.
  double c[] = {2.515517, 0.802853, 0.010328};
  double d[] = {1.432788, 0.189269, 0.001308};
  return t - ((c[2]*t + c[1])*t + c[0]) /
    (((d[2]*t + d[1])*t + d[0])*t + 1.0);
}

//' Calculate the Normal CDF Inverse
//'
//' This function was taken from https://www.johndcook.com/blog/cpp_phi_inverse/
//' @param double p
//' @return value for which the normal CDF < p
//'
double NormalCDFInverse(double p) {
  if (p <= 0.0 || p >= 1.0) {
    std::stringstream os;
    os << "Invalid input argument (" << p
       << "); must be larger than 0 but less than 1.";
    throw std::invalid_argument( os.str() );
  }

  // See article above for explanation of this section.
  if (p < 0.5)  {
    // F^-1(p) = - G^-1(p)
    return -RationalApproximation( sqrt(-2.0*log(p)) );
  } else {
    // F^-1(p) = G^-1(1-p)
    return RationalApproximation( sqrt(-2.0*log(1-p)) );
  }
}

//' Sort a vector in ascending order
//'
//' @param NumericVector x
//' @return x in ascending order
//'
NumericVector rcpp_sort (NumericVector x) {
  NumericVector y = clone(x);
  std::sort(y.begin(), y.end());
  return y;
}

//' Calculate the W statistic for the Royston approach (implemented in Rcpp)
//'
//' This function calculates the W test statistic for the Royston approach for
//' the Shapiro-Wilk test. This function is comparable to the R implementation
//' of the Royston approach (which can be found in the R folder). For a
//' step-by-step explanation of this function, look at the Readme file under
//' "A Note on the Algorithms".
//'
//' @param vec_value vector containing data points; integer or double
//' @return the test statistic for the Shapiro-Wilk test; double, between 0 and
//' 1
//'
//' @export
//'
//'
// [[Rcpp::export]]
double C_get_W (NumericVector vec_value) {
  int n = vec_value.size();
  NumericVector m_vec(n);
  double m_val = 0.0;

  for (int i = 0; i < n; i++) {
    m_vec[i] = NormalCDFInverse (((i+1) - 0.375) / (n + 0.25));
    m_val += m_vec[i] * m_vec[i];
  }

  double u = 1.0/sqrt (n);

  NumericVector dat_coef(n);
  dat_coef[n - 1] = -2.706056*pow (u, 5) +
    4.434685*pow (u, 4) -
    2.2071190*pow (u, 3)-
    0.147981*pow (u, 2) +
    0.221157*u +
    m_vec[n - 1] * pow (m_val, -0.5);

  dat_coef[0] = -1 * dat_coef[n - 1];

  dat_coef[n-2] = -3.582633*pow (u, 5) +
    5.682633*pow (u, 4) -
    1.752461*pow (u, 3) -
    0.293762*pow (u, 2) +
    0.042981*u +
    m_vec[n-2] * pow (m_val,-0.5);

  dat_coef[1] = -1 * dat_coef[n-2];

  for (int i = 1; i < n-2; i++) {
    double epsilon = (m_val - (2*pow(m_vec[n-1],2)) - (2*pow(m_vec[n-2],2))) /
      (1 - (2 *pow( dat_coef[n-1],2)) - (2 * pow( dat_coef[n-2],2)));

    dat_coef[i] = m_vec[i]/sqrt (epsilon);
  }

  double numerator = 0;
  double denominator = 0;
  NumericVector sorted_vec_value = rcpp_sort (vec_value);

  for (int i = 0; i < n; i++) {
    numerator += dat_coef[i] * sorted_vec_value[i];
    denominator += pow (sorted_vec_value[i] - mean(vec_value),2);
  }

  double W = pow (numerator, 2)/denominator;

  return W;
}
