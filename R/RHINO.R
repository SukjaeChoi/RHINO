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
    
    if(grep("home", .libPaths()[1]) == 1) | grep("usr", .libPaths()[1]) == 1){
       if(!file.exists('usr')){
        message('current version of RHINO, RHINO will generate symbolic link of "usr" on your working directory for load dictionary. Inspect this soon. Sorry to inconvinence.')
        
        system(paste0('ln -s ', '/usr ', 'usr'))
      }
      if(!file.exists('home')){
        message('current version of RHINO, RHINO will generate symbolic link of "home" on your working directory for load dictionary. Inspect this soon. Sorry to inconvinence.')
        
        system(paste0('ln -s ', '/home ', 'home'))
      }
      
    } 
  }
  
  .connRHINO <<- .jnew("rhino/RHINO")
  .jcall(.connRHINO, returnSig = "V", "ExternInit", "R")
  return(.connRHINO)
  
}

#' getMorph
#'
#' Get analyzed Korean morph. The initRhino() must be executed once the first.
#' @param sentence Korean sentences. Try Korean words or sentences.
#' @param type The Part-Of-Speech type you want to extract. noun(NNG, NNP, NP), verb(VV, VA, XR), NNG, NNP, NP, NNB, VV, VA, XR, VX. Default is noun.
#' @param file Currently not realized. Default is FALSE.
#' @return vector of extracted morph result
#' @export
#' @examples 
#' initRhino()
#' getMorph("Input Korean sentences here.", "NNP")


getMorph <- function(sentence, type = "noun", file = FALSE, fileName = 'getMorphResult.txt'){
  if(!exists('.connRHINO')){ # connect with RHINO engine
    .connRHINO <<- initRhino()
  }
  
  if(!is.na(sentence) | !is.null(sentence)){
    # remove any blanks
    sentence <- gsub("\r\n", " ", sentence)
    sentence <- gsub("\r", " ", sentence)
    sentence <- gsub("\n", " ", sentence)
    sentence <- gsub("^\\s+|\\s+$", "", sentence)


    if(identical(sentence, "")||identical(sentence, " ")){     #newly input!!!
      #print("No characters")
      #return("")
    } else if(file==TRUE) {
      result <- .jcall(.connRHINO, returnSig = "S", "getMorph", sentence, type)
      Encoding(result) <- "UTF-8"
      resultVec <- unlist(strsplit(result, '\r\n'))
      write(x = resultVec, file = fileName)
      return(resultVec)
    } else {
      result <- .jcall(.connRHINO, returnSig = "S", "getMorph", sentence, type)
      Encoding(result) <- "UTF-8"
      resultVec <- unlist(strsplit(result, '\r\n'))
      return(resultVec)
    }
  } else {
    stop('Did you enter the sentence rightly?')
  }
  
}




