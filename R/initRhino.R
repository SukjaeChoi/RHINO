#' initRhino
#'
#' Initializing RHINO.
#' @export
#' @examples
#' initRhino()

initRhino <- function() {
  if(grep("1.8.0", .jcall("java/lang/System", "S", "getProperty", "java.runtime.version")) != 1){
    stop('RHINO requires Oracle Java 8 environment. Stop initiation of Rhino. If you using Ubuntu Linux and you did install Java 8 correctly, try to R CMD javareconf -e and retry to init')
  }
  
  if(.Platform$OS.type == "unix"){ # temporary patch for unix-like operation system (Ubuntu linux, Mac, FreeBSD, etc.)
    
    if(grep("home", .libPaths()[1]) == 1){
      if(!file.exists('home')){
        message('current version of RHINO, connRHINO will generate symbolic link of "home" on your working directory for load dictionary. Inspect this soon. Sorry to inconvinence.')
        
        system(paste0('ln -s ', '/home ', 'home'))
      }
    } else if(grep("usr", .libPaths()[1]) == 1){
      if(!file.exists('usr')){
        message('current version of RHINO, connRHINO will generate symbolic link of "usr" on your working directory for load dictionary. Inspect this soon. Sorry to inconvinence.')
        
        system(paste0('ln -s ', '/usr ', 'usr'))
      }
    }
  }
  
  message('current version of RHINO, connRHINO will generate for keep-alive connection with java. Do not remove connRHINO object. Inspect this soon. Sorry to inconvinence.')
  connRHINO <- .jnew("rhino/RHINO")
  .jcall(connRHINO, returnSig = "V", "ExternInit", "R")
}
