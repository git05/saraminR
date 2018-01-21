#' get saraminData
#' @export
#' @import XML
#' @import xml2
#' @import dplyr
#' @import magrittr

saram.func = function(pagecount,keyword){
  url = paste0("http://api.saramin.co.kr/job-search?keywords=",keyword,"&fields=posting-date+expiration-date+keyword-code+count&count=100&start=",pagecount)
  url.frame = xml2::read_xml(url)
  url = url.frame %>% xml2::xml_find_all("//url") %>% xml_text
  name  = url.frame %>% xml2::xml_find_all("//name") %>% xml_text
  title = url.frame %>% xml2::xml_find_all("//title") %>% xml_text
  posting_timestamp = url.frame %>% xml2::xml_find_all("//posting-timestamp") %>% xml_text
  modification_timestamp = url.frame %>% xml2::xml_find_all("//modification-timestamp") %>% xml_text
  opening_timestamp = url.frame %>% xml2::xml_find_all("//opening-timestamp") %>% xml_text
  expiration_timestamp = url.frame %>% xml2::xml_find_all("//expiration-timestamp") %>% xml_text
  close_type = url.frame %>% xml2::xml_find_all("//expiration-timestamp") %>% xml_text
  location_code = url.frame %>% xml2::xml_find_all("//location") %>% xml2::xml_attr("code")
  location_name = url.frame %>% xml2::xml_find_all("//location") %>% xml_text
  job_type_code = url.frame %>% xml2::xml_find_all("//job-type") %>% xml2::xml_attr("code")
  job_type_name = url.frame %>% xml2::xml_find_all("//job-type") %>% xml_text
  industry_code = url.frame %>% xml2::xml_find_all("//industry") %>% xml2::xml_attr("code")
  industry_name = url.frame %>% xml2::xml_find_all("//industry") %>% xml_text
  job_category_code = url.frame %>% xml2::xml_find_all("//job-category") %>% xml2::xml_attr("code")
  job_category_name = url.frame %>% xml2::xml_find_all("//job-category") %>% xml_text
  experience_level_code = url.frame %>% xml2::xml_find_all("//experience-level") %>% xml2::xml_attr("code")
  experience_level_min = url.frame %>% xml2::xml_find_all("//experience-level") %>% xml2::xml_attr("min")
  experience_level_max = url.frame %>% xml2::xml_find_all("//experience-level") %>% xml2::xml_attr("max")
  experience_level_name = url.frame %>% xml2::xml_find_all("//experience-level") %>% xml_text
  required_education_level_code = url.frame %>% xml2::xml_find_all("//required-education-level") %>% xml2::xml_attr("code")
  required_education_level_name = url.frame %>% xml_find_all("//required-education-level") %>% xml_text
  read = url.frame %>% xml2::xml_find_all("//read-cnt") %>% xml_text
  apply = url.frame %>% xml2::xml_find_all("//apply-cnt") %>% xml_text
  reply = url.frame %>% xml2::xml_find_all("//reply-cnt") %>% xml_text
  data = data.frame(url,
                    name,
                    title,
                    posting_timestamp,
                    modification_timestamp,
                    opening_timestamp,
                    expiration_timestamp,
                    close_type,
                    location_code,
                    location_name,
                    job_type_code,
                    job_type_name,
                    job_category_code,
                    job_category_name,
                    experience_level_code,
                    experience_level_min,
                    experience_level_max,
                    experience_level_name,
                    required_education_level_code,
                    required_education_level_name,
                    read=as.numeric(read),
                    apply=as.numeric(apply),
                    reply=as.numeric(reply),
                    conversionrate = as.numeric(apply)/as.numeric(read)
  )

  return(data)
}
