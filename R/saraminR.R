#' get saraminData
#' @export
#' @import XML
#' @import xml2
#' @import dplyr

saramin = function(keyword){
  url = paste0("http://api.saramin.co.kr/job-search?keywords=",keyword,"&fields=posting-date+expiration-date+keyword-code+count")
  url.frame = xml2::read_xml(url)
  pagecount = pagecount.func(url.frame)
  saram.data= lapply(X=pagecount,FUN=saram.func,keyword=keyword)
  saram.data2 = do.call(saram.data,what=rbind)
  return(saram.data2)
}


