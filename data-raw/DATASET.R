## code to prepare `DATASET` dataset goes here

modified_sw_coefs <- sw_coefs
modified_sw_coefs[26:50,] = NA


for (j in 1:49) {
  #need to "repeat" values of each column backwards and add 0 if n is odd
  if ((j+1)%%2 == 1) {
    replacement = c(unlist(na.omit (modified_sw_coefs[,j])), 0, sort (unlist(na.omit (modified_sw_coefs[,j])), decreasing = F))
  }  else {
    replacement = c(unlist(na.omit (modified_sw_coefs[,j])), sort (unlist(na.omit (modified_sw_coefs[,j])), decreasing = F))
  }

  length(replacement) = 50
  modified_sw_coefs[,j] = replacement

  #need to change the sign for values less than n/2
  for (i in 1:25) {
    if (i <= (j + 1)/2) {
      modified_sw_coefs[i,j] <- -1 * modified_sw_coefs[i,j]
    }
  }


}


usethis::use_data(sw_pvals, sw_coefs, modified_sw_coefs, overwrite = TRUE, internal = T)
