#' @import "rJava"
.onLoad <- function(libname, pkgname) {
  .jpackage(pkgname, lib.loc = libname)
}

  
.connRHINO <- .jnew("rhino/RHINO")
.jcall(connRHINO, returnSig = "V", "ExternInit", "R")
