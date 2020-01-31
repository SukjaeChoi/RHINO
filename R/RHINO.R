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
#' Get analyzed Korean morph.
#' @param sentence Korean sentences. Try Korean words or sentences.
#' @param type The Part-Of-Speech type you want to extract. ALL(Every POS), noun(NNG, NNP, NP, XR), verb(VV, VA), NV(noun, verb), NVI(noun, verb, IC), END(EC, EF), SIGN(SF, SO, SW, SS, SP,SE), and all every POS(NNG, NNP, NP, NNB, NR, VV, VA, VX, VCP, VCN, MM, MAG, MAJ, IC, JKS, JKC, JKG, JKO, JKB, JKV, JKQ, JX, JC, EP, EF, EC, ETN, ETM, XPN, XSN, XSV, XSA, XR, SF, SS, SP, SE, SO, SL, SH, NF, SW, NV, SN, NA). Default is noun.
#' @param file Currently not realized. Default is FALSE.
#' @return vector of extracted morph result
#' @export
#' @examples
#' getMorph("Input Korean sentences here.", "NV")

getMorph <- function(sentence, type="noun", file=FALSE)
{
  if(!exists("rhinoObj"))   # upload dictionary at the first
    initRhino()

  tryCatch({
  sentence <- gsub("\r\n", " ", sentence)
  sentence <- gsub("\r", " ", sentence)
  sentence <- gsub("\n", " ", sentence)
  sentence <- gsub("^\\s+|\\s+$", "", sentence)

  # replace exit character with other one
  if(identical(sentence, "Q")){
    sentence <- "Q."
  }


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


#' getKeywords
#'
#' Get keywords.
#' @param data vector. Source data for keywords
#' @param n integer. Maximum number of keywords. Default is 10
#' @param length Minimum length of character of every keyword. Default is 1
#' @param pos The Part-Of-Speech type you want to extract. Default is "noun"
#' @return Vector of extracted keywords
#' @export
#' @examples
#' getKeywords("Input Korean sentences here here here", n=3, length = 2, pos ="ALL")

getKeywords <- function(data, n = 10, length = 1, pos = "noun") {
  library(RHINO)

  words.vec <- unlist(lapply(data, getMorph, pos))
  words.vec.n <- words.vec[nchar(words.vec) >= length]

  return(names(head(sort(table(words.vec.n), decreasing = T), n)))
}


