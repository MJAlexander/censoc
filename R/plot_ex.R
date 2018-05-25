#' Plot life expectancy by cohort and group
#'
#' Plots life expectancy estimates and uncertainty over cohort for each group.
#'
#' @param ex_df dataframe containing life expectancy estimates and uncertainty for each cohort, age and group
#' @param ex_age age for life expectancy to be plotted. Minimum is the minimum age of estimation (default is 55).
#' @param group_title string indicating the type of group being considered, e.g. "Education"
#' @return a ggplot object


plot_ex <- function(ex_df, ex_age, group_title){
  p <- ggplot(ex_df %>% filter(age == ex_age), aes(cohort, ex_median)) +
    geom_line(aes(color = group_label), lwd = 1.2) +
    geom_ribbon(aes(ymin = ex_lower, ymax = ex_upper, fill = group_label), alpha = 0.2)+
    ylab(paste0("Life expectancy at age ", ex_age))+
    guides(fill=guide_legend(title=group_title),color=guide_legend(title=group_title))+
    ggtitle(paste0("Life expectancy at age ", ex_age)) + theme_bw(base_size = 16)
  return(p)
}
