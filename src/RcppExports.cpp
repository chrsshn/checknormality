// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// C_get_W
double C_get_W(NumericVector vec_value);
RcppExport SEXP _checknormality_C_get_W(SEXP vec_valueSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type vec_value(vec_valueSEXP);
    rcpp_result_gen = Rcpp::wrap(C_get_W(vec_value));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_checknormality_C_get_W", (DL_FUNC) &_checknormality_C_get_W, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_checknormality(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
