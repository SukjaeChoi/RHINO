#' initRhino
#'
#' Initializing RHINO.
#' @export
#' @examples
#' initRhino()

initRhino <- function() {
  rhinoObj <<- .jnew("rhino/RHINO")
  .jcall(rhinoObj, returnSig = "V", "ExternInit", "R")
}




#' getMorph
#'
#' Get analyzed Korean morph. The initRhino() must be executed once the first.
#' @param sentence Korean sentences. Try Korean words or sentences.
#' @param type the Part-Of-Speech type you want to extract. noun(NNG, NNP, NP), verb(VV, VA, XR), NNG, NNP, NP, NNB, VV, VA, XR, VX. Default is noun.
#' @return vector of extracted morph result
#' @export
#' @examples 
#' initRhino()
#' getMorph("Input Korean sentences here.", "NNP")

getMorph <- function(sentence, type="noun")
{
  sentence <- gsub("\r\n", " ", sentence)
  sentence <- gsub("\r", " ", sentence)
  sentence <- gsub("\n", " ", sentence)
  sentence <- gsub("^\\s+|\\s+$", "", sentence)
  
  if(identical(sentence, "")||identical(sentence, " ")){
    #print("No characters")
    #return("")
  }
  else if(endsWith(sentence, ".txt")) {
    if(type=="noun") {
    .jcall(rhinoObj, returnSig = "V", "analyzingText_rJava", "N")  #The rightest option: N-> Noun(NNG, NNP, NP), V-> Verb(VV, VA, XR), NV-> Noun and Verb
      print("Created noun result file result.txt in ./RHINO2.5.3/WORK/RHINO/")
    } else if(type=="verb") {
      .jcall(rhinoObj, returnSig = "V", "analyzingText_rJava", "V")  #The rightest option: N-> Noun(NNG, NNP, NP), V-> Verb(VV, VA, XR), NV-> Noun and Verb
      print("Created verb result file result.txt in ./RHINO2.5.3/WORK/RHINO/")
    } else{
      print("Not Supported Type")
    }
  } else {
    result <- .jcall(rhinoObj, returnSig = "S", "getMorph", sentence, type)
    Encoding(result) <- "UTF-8"
    resultVec <- unlist(strsplit(result, '\r\n'))
    return(resultVec)
  }
}




