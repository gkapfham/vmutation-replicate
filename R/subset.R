#' FUNCTION: subset_data_generator
#'
#' Remove any data generator results not related to the avsDefaults generator
#' @importFrom magrittr %>%
#' @export

subset_data_generator <- function(d) {
  # remove all of the rows that are not for the avsDefaults data generator
  d %>% filter(datagenerator %in% c("avsDefaults"))
}

#' FUNCTION: subset_chosen_schemas
#'
#' Extract only those schemas that are part of the AST 2016 paper's empirical results.
#' @export

subset_chosen_schemas <- function(d, m) {
  # subset a provided data frame (like the one for virtual or original mutation) so that it only contains the
  # observations for the schemas present in the data frame called m (like the time constrained mutation data)
  ds <- dplyr::semi_join(d, m, by="schema")
  return(ds)
}

#' FUNCTION: subset_correct_pipeline_schemas
#'
#' Extract only those schemas that were run with the correct mutation pipeline, for consistent results.
#' @export

subset_correct_pipeline_schemas <- function(d, v) {
  # extract the names of the schemas that do not have correct data
  incorrect_schemas <- v %>%
    dplyr::select(dbms, schema, mutationpipeline) %>%
    dplyr::filter(mutationpipeline %in% c("AllOperatorsNormalisedWithRemovers")) %>%
    dplyr::distinct(schema)
  # only consider the schemas that did not use the newer (and, not comparable) schemas
  ds <- dplyr::anti_join(d, incorrect_schemas, by="schema")
  return(ds)
}

#' FUNCTION: subset_all_attributes_except_identifier
#'
#' Subsets out all of the attributes except for the (no longer needed) identifier attribute.
#' @importFrom magrittr %>%
#' @export

subset_all_attributes_except_identifier <- function(d) {
  # subset out all of the attributes with the exception of the identifier attribute
  ds <- d %>% dplyr::select(-identifier)
  return(ds)
}

#' FUNCTION: subset_virtual_attributes
#'
#' Subsets out the attributes that are most relevant to the virtual mutation data analysis.
#' @importFrom magrittr %>%
#' @export

subset_virtual_attributes <- function(d) {
  # subset out all of the attributes
  ds <- d %>% dplyr::select(one_of("dbms", "schema", "technique", "scorenumerator", "scoredenominator", "originalresultstime", "mutationanalysistime"))
  return(ds)
}
