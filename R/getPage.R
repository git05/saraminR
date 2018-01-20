#' get Keywords Pages
#' @export
#' @import XML
#' @import xml2
#' @import dplyr

pagecount.func = function(url.frame){
  list.count = url.frame %>% xml_find_all("//jobs") %>% xml_attr("total")
  re = ceiling(as.numeric(list.count)/100)
  list = "0"
  for(i in 2:re) {
    list = append(list,(i-1))}
  return(list)}
