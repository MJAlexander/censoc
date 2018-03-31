#' Principal components from HMD
#'
#' Calculate principal components (on logit scale) based on death distributions from HMD.
#'
#' @param dx_data HMD data on death distribution
#' @param single_country whether or not dataset contains single or multiple countries
#' @param n_pcs number of principal components to return. Default is 10.
#' @return a matrix that contains principal components by age of logit death distributions.


get_hmd_death_pcs <- function(dx_data,
                              single_country,
                              n_pcs = 10){
  if(single_country){
    px <- dx_data %>%  select(age, year, prop) %>% spread(age, prop)
    px <- as.matrix(px %>%  ungroup() %>% select(-year))
    px <- px[!is.na(apply(px, 1, sum)),]
    px[px==0]<- 0.0001
    logit_px <- logit(px)
    svd_px <- svd(logit_px)
  }
  else{
    px <- dx_data %>%  select(age, country, year, prop) %>% spread(age, prop)
    px <- as.matrix(px %>%  ungroup() %>% select(-country, -year))
    px <- px[!is.na(apply(px, 1, sum)),]
    px[px==0]<- 0.0001
    logit_px <- logit(px)
    svd_px <- svd(logit_px)
  }

  pcs <- c()
  for(i in 1:n_pcs){
    pcs <- cbind(pcs, svd_px$v[, i])
  }
  return(pcs)
}
