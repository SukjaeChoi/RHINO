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


getMorph <- function(sentence, type="noun", file=FALSE)
{
  sentence <- gsub("\r\n", " ", sentence)
  sentence <- gsub("\r", " ", sentence)
  sentence <- gsub("\n", " ", sentence)
  sentence <- gsub("^\\s+|\\s+$", "", sentence)
  
  if(identical(sentence, "")||identical(sentence, " ")){     #newly input!!!
    #print("No characters")
    #return("")
  }
  else if(file==TRUE) {
    if(type=="noun") {
      .jcall(.connRHINO, returnSig = "V", "analyzingText_rJava", "N")  #The rightest option: N-> Noun(NNG, NNP, NP), V-> Verb(VV, VA, XR), NV-> Noun and Verb
      print("Created noun result file result.txt in ./RHINO2.5.3/WORK/RHINO/")
    } else if(type=="verb") {
      .jcall(.connRHINO, returnSig = "V", "analyzingText_rJava", "V")  #The rightest option: N-> Noun(NNG, NNP, NP), V-> Verb(VV, VA, XR), NV-> Noun and Verb
      print("Created verb result file result.txt in ./RHINO2.5.3/WORK/RHINO/")
    } else{
      print("Not Supported Type")
    }
  } else {
    result <- .jcall(.connRHINO, returnSig = "S", "getMorph", sentence, type)
    Encoding(result) <- "UTF-8"
    resultVec <- unlist(strsplit(result, '\r\n'))
    return(resultVec)
  }
}




