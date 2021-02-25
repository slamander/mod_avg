mod_avg <- function(mods_set, 
                    model_type,
                    predict = FALSE, 
                    delta_aic = Inf, 
                    aic_csv = FALSE, 
                    aic_rds = FALSE, 
                    preds_csv = FALSE, 
                    preds_rds = FALSE, 
                    append_file = FALSE){
  
  list.of.packages <- c("AICcmodavg", "tidyverse", "readr", "MuMIn")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  
  library(AICcmodavg)
  library(tidyverse)
  library(readr)
  library(MuMIn)
  
  mods_names <- list()
  vec <- vector()
  output <- list()
  
  for (i in 1:length(mods_set)){

    if (class(mods_set[[i]]) %in% c("lm","glm","lmerMod","glmerMod","glmmTMB")){
      name <- mods_set[[i]]$call$formula
      mods_names[[i]] <- paste(name[2],name[1],name[3]) 
    } 
    
    else (class(mods_set[[i]]) %in% c("lmerMod","glmerMod")) {
      name <- mods_set[[i]]@call$formula
      mods_names[[i]] <- paste(name[2],name[1],name[3])
    }
    
    else {
      print("Alex hasn't coded for your model type yet... Email him and ask nicely")
    }
    
    if (i == length(mods_set)){
      mods_names <- mods_names %>%
        unlist()
      output[["aic_tab"]] <- AICcmodavg::aictab(cand.set = mods_set,
                                                modnames = mods_names,
                                                method = "raw") %>%
        subset(Delta_AICc < delta_aic)
      
      if (predict == TRUE) {
        output[["model_preds"]] <- mods_set %>%
          model.sel() %>%
          subset(delta < delta_aic) %>%
          MuMIn::model.avg() %>%
          predict(type = "response")
      }
      
      else{
        return(output)
      }
      
      if (aic_csv == TRUE) {
        return(output[["aic_tab"]]) %>%
          as.data.frame() %>%
          write_csv("aic_tab.csv", append = append_file)
      }
      
      if (aic_rds == TRUE) {
        return(output[["aic_tab"]]) %>%
          as.data.frame() %>%
          write_rds("aic_tab.rds", append = append_file)
      }
      
      if (preds_csv == TRUE) {
        return(output[["model_preds"]]) %>%
          as.data.frame() %>%
          rename(preds = ".") %>%
          write_csv("preds.csv", append = append_file)
      }
      
      if (preds_rds == TRUE) {
        return(output[["model_preds"]]) %>%
          as.data.frame() %>%
          rename(preds = ".") %>%
          write_rds("preds.rds", append = append_file)
      }
      
      else {
        return(output)
      }
    }
  }
}

mod_avg <- function(mods_set, 
                    model_type,
                    predict = FALSE, 
                    delta_aic = Inf, 
                    aic_csv = FALSE, 
                    aic_rds = FALSE, 
                    preds_csv = FALSE, 
                    preds_rds = FALSE, 
                    append_file = FALSE){
  
  list.of.packages <- c("AICcmodavg", "tidyverse", "readr", "MuMIn")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  
  library(AICcmodavg)
  library(tidyverse)
  library(readr)
  library(MuMIn)
  
  mods_names <- list()
  vec <- vector()
  output <- list()
  
  for (i in 1:length(mods_set)){
    if (class(mods_set[[i]]) %in% c("lm","glm")){
      name <- mods_set[[i]]$call$formula
      mods_names[[i]] <- paste(name[2],name[1],name[3]) 
    } 
    if (class(mods_set[[i]]) %in% c("lmerMod","glmerMod")) {
      name <- mods_set[[i]]@call$formula
      mods_names[[i]] <- paste(name[2],name[1],name[3]) 
    }
    
    else {
      print("Alex hasn't coded for your model type yet... Email him and ask nicely")
    }
    
    if (i == length(mods_set)){
      mods_names <- mods_names %>%
        unlist()
      output[["aic_tab"]] <- AICcmodavg::aictab(cand.set = mods_set,
                                                modnames = mods_names,
                                                method = "raw") %>%
        subset(Delta_AICc < delta_aic)
      
      if (predict == TRUE) {
        output[["model_preds"]] <- mods_set %>%
          model.sel() %>%
          subset(delta < delta_aic) %>%
          MuMIn::model.avg() %>%
          predict(type = "response")
      }
      
      else{
        return(output)
      }
      
      if (aic_csv == TRUE) {
        return(output[["aic_tab"]]) %>%
          as.data.frame() %>%
          write_csv("aic_tab.csv", append = append_file)
      }
      
      if (aic_rds == TRUE) {
        return(output[["aic_tab"]]) %>%
          as.data.frame() %>%
          write_rds("aic_tab.rds", append = append_file)
      }
      
      if (preds_csv == TRUE) {
        return(output[["model_preds"]]) %>%
          as.data.frame() %>%
          rename(preds = ".") %>%
          write_csv("preds.csv", append = append_file)
      }
      
      if (preds_rds == TRUE) {
        return(output[["model_preds"]]) %>%
          as.data.frame() %>%
          rename(preds = ".") %>%
          write_rds("preds.rds", append = append_file)
      }
      
      else {
        return(output)
      }
    }
  }
}







