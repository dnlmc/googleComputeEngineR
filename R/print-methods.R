#' @export
print.gce_instanceList <- function(x, ...){
  
  cat("==Google Compute Engine Instance List==\n")
  out <- x$items
  if (!is.null(out)) {
    out$zone <- basename(out$zone)
    out$machineType <- basename(out$machineType)
    out$externalIP <- extract_ip(x)
    out$creationTimestamp <- timestamp_to_r(out$creationTimestamp)

    print_cols <- c("name","machineType","status","zone","externalIP","creationTimestamp")
  
    print(out[, print_cols])
  } else {
    cat("<none>\n")
  }
  invisible(x)
}

#' @export
print.machineTypeList <- function(x, ...){

  cat("==Google Compute Engine Machine Type List==\n")  
  out <- x$items
  if (!is.null(out)) {
    out$creationTimestamp <- timestamp_to_r(out$creationTimestamp)
    
    print_cols <- c("name","description","guestCpus","memoryMb",
                    "maximumPersistentDisks","maximumPersistentDisksSizeGb",
                    "creationTimestamp","isSharedCpu","zone")
    
    print(out[, print_cols])
  } else {
    cat("<none>\n")
  }
  invisible(x)  
}

#' @export
print.gce_instance <- function(x, ...){
  
  cat("==Google Compute Engine Instance==\n")
  cat("\nName:               ", x$name)
  cat("\nCreated:            ", as.character(timestamp_to_r(x$creationTimestamp)))
  cat("\nMachine Type:       ", basename(x$machineType))
  cat("\nStatus:             ", x$status)
  cat("\nZone:               ", basename(x$zone))
  cat("\nExternal IP:        ", x$networkInterfaces$accessConfigs[[1]]$natIP)
  cat("\nDisks: \n")
  print(x$disks[ , c("deviceName","type","mode","boot","autoDelete")])
  cat("\nMetadata:  \n")
  print(x$metadata$items[!x$metadata$items$key %in% c("startup-script","user-data"),])
  
}

#' @export
print.gce_gpuList <- function(x, ...){
  
  cat("==Google Compute Engine GPU List==\n")
  out <- x$items
  if (!is.null(out)) {
    out$zone <- basename(out$zone)
    out$creationTimestamp <- timestamp_to_r(out$creationTimestamp)
    
    print_cols <- c("name","description","maximumCardsPerInstance","zone","creationTimestamp")
    
    print(out[, print_cols])
  } else {
    cat("<none>\n")
  }
  invisible(x)
}

#' @export
print.gce_zone_operation <- function(x, ...){
  
  cat("==Zone Operation", x$operationType, ": ", x$status)
  cat("\nStarted: ", as.character(timestamp_to_r(x$insertTime)))
  
  if(!is.null(x$endTime)){
    cat0("\nEnded:", as.character(timestamp_to_r(x$endTime)))
    cat("Operation complete in", 
        format(timestamp_to_r(x$endTime) - timestamp_to_r(x$insertTime)), 
        "\n")
  }

  if(!is.null(x$error)){
    errors <- x$error$errors
    e.m <- paste(vapply(errors, print, character(1)), collapse = " : ", sep = " \n")
    cat("\n# Error: ", e.m)
    cat("\n# HTTP Error: ", x$httpErrorStatusCode, x$httpErrorMessage)
  }
}

#' @export
print.gce_global_operation <- function(x, ...){
  
  cat("==Global Operation", x$operationType, ": ", x$status)
  cat("\nStarted: ", as.character(timestamp_to_r(x$insertTime)))
  
  if(!is.null(x$endTime)){
    cat0("\nEnded:", as.character(timestamp_to_r(x$endTime)))
    cat("Operation complete in", 
        format(timestamp_to_r(x$endTime) - timestamp_to_r(x$insertTime)), 
        "\n")
  }
  
  if(!is.null(x$error)){
    errors <- x$error$errors
    e.m <- paste(vapply(errors, print, character(1)), collapse = " : ", sep = " \n")
    cat("\n# Error: ", e.m)
    cat("\n# HTTP Error: ", x$httpErrorStatusCode, x$httpErrorMessage)
  }
}

#' @export
print.gce_region_operation <- function(x, ...){
  
  cat("==Region Operation", x$operationType, ": ", x$status)
  cat("\nStarted: ", as.character(timestamp_to_r(x$insertTime)))
  
  if(!is.null(x$endTime)){
    cat0("\nEnded:", as.character(timestamp_to_r(x$endTime)))
    cat("Operation complete in", 
        format(timestamp_to_r(x$endTime) - timestamp_to_r(x$insertTime)), 
        "\n")
  }
  
  if(!is.null(x$error)){
    errors <- x$error$errors
    e.m <- paste(vapply(errors, print, character(1)), collapse = " : ", sep = " \n")
    cat("\n# Error: ", e.m)
    cat("\n# HTTP Error: ", x$httpErrorStatusCode, x$httpErrorMessage)
  }
}