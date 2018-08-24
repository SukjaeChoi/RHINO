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
#' @param type The Part-Of-Speech type you want to extract. ALL(Every POS), noun(NNG, NNP, NP), verb(VV, VA, XR), NV(noun, verb), END(EC, EF), NNG, NNP, NP, NNB, VV, VA, XR, VX, EC, EF, EP. Default is noun.
#' @param file Currently not realized. Default is FALSE.
#' @return vector of extracted morph result
#' @export
#' @examples
#' initRhino()
#' getMorph("Input Korean sentences here.", "noun")

getMorph <- function(sentence, type="noun", file=FALSE)
{
  tryCatch({
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
    .jcall(rhinoObj, returnSig = "V", "analyzingText_rJava", "N")  #The rightest option: N-> Noun(NNG, NNP, NP), V-> Verb(VV, VA, XR), NV-> Noun and Verb
      print("Created noun result file result.txt in ./RHINO2.5.5/WORK/RHINO/")
    } else if(type=="verb") {
      .jcall(rhinoObj, returnSig = "V", "analyzingText_rJava", "V")  #The rightest option: N-> Noun(NNG, NNP, NP), V-> Verb(VV, VA, XR), NV-> Noun and Verb
      print("Created verb result file result.txt in ./RHINO2.5.5/WORK/RHINO/")
    } else{
      print("Not Supported Type")
    }
  } else {   #### This is the currently used. Above is not used!!
    result <- .jcall(rhinoObj, returnSig = "S", "getMorph", sentence, type)
    Encoding(result) <- "UTF-8"
    resultVec <- unlist(strsplit(result, '\r\n'))
    return(resultVec)
  }

  },
  error = function (condition) {
    #print("RPART_ERROR:")
    #print(paste("  Message:",conditionMessage(condition)))
    #print(paste("  Call: ",conditionCall(condition)))
  },
  finally= function() {

  }
  )
}




