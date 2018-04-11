#' Principal components from HMD
#'
#' Calculate principal components (on logit scale) based on death distributions from HMD.
#'
#' @param dx_data HMD data on death distribution
#' @param single_country whether or not dataset contains single or multiple countries
#' @param demeaned whether the values should be demeaned. If \code{TRUE}, the first column of the returned matrix is the mean.
#' @param n_pcs number of principal components to return. Default is 10.
#' @return a matrix that contains principal components by age of logit death distributions.


get_hmd_death_pcs <- function(dx_data,
                              demeaned = FALSE,
                              single_country,
                              n_pcs = 10){
  if(single_country){
    px <- dx_data %>%  select(age, year, prop) %>% spread(age, prop)
    px <- as.matrix(px %>%  ungroup() %>% select(-year))
    px <- px[!is.na(apply(px, 1, sum)),]
    px[px==0]<- 0.0001
    logit_px <- logit(px)
    if(demeaned){
      ax <- apply(logit_px, 2, mean)
      dm_logit_px <- sweep(logit_px, 2, ax)
      svd_px <- svd(dm_logit_px)
    }
    else{
      svd_px <- svd(logit_px)
    }
  }
  else{
    px <- dx_data %>%  select(age, country, year, prop) %>% spread(age, prop)
    px <- as.matrix(px %>%  ungroup() %>% select(-country, -year))
    px <- px[!is.na(apply(px, 1, sum)),]
    px[px==0]<- 0.0001
    logit_px <- logit(px)
    if(demeaned){
      ax <- apply(logit_px, 2, mean)
      dm_logit_px <- sweep(logit_px, 2, ax)
      svd_px <- svd(dm_logit_px)
    }
    else{
      svd_px <- svd(logit_px)
    }
  }

  pcs <- c()
  if(demeaned){
    pcs <- ax
  }
  for(i in 1:n_pcs){
    pcs <- cbind(pcs, svd_px$v[, i])
  }
  return(pcs)
}
