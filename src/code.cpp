#include <Rcpp.h>
#include <math.h>
#include <cmath>
using namespace Rcpp;


//' Multiplies two doubles
//'
//' @param t double
//' @return Product of v1 and v2
// [[Rcpp::export]]
double RationalApproximation (double t) {
  // Abramowitz and Stegun formula 26.2.23.
  // The absolute value of the error should be less than 4.5 e-4.
  double c[] = {2.515517, 0.802853, 0.010328};
  double d[] = {1.432788, 0.189269, 0.001308};
  return t - ((c[2]*t + c[1])*t + c[0]) /
    (((d[2]*t + d[1])*t + d[0])*t + 1.0);
}

// [[Rcpp::export]]
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


// [[Rcpp::export]]
NumericVector stl_sort (NumericVector x) {
  NumericVector y = clone(x);
  std::sort(y.begin(), y.end());
  return y;
}

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
  NumericVector sorted_vec_value = stl_sort (vec_value);
  for (int i = 0; i < n; i++) {
    numerator += dat_coef[i] * sorted_vec_value[i];
    denominator += pow (sorted_vec_value[i] - mean(vec_value),2);


  }


  double W = pow (numerator, 2)/denominator;

  return W;



}
