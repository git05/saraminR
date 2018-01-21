#' get Keywords Pages
#' @import XML
#' @import xml2
#' @import dplyr


pagecount.func = function(url.frame){
  list.count = url.frame %>% xml2::xml_find_all("//jobs") %>% xml2::xml_attr("total")
  re = ceiling(as.numeric(list.count)/100)
  list = seq(from=0,to=re,by=1)
  return(list)}
