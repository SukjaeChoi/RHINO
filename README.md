# RHINO: A most cogent and efficient Morphological Analyser for Hangeul.
- RHINO is abbreviation of the '**R**ealistic **H**angeul morpheme **I**nterpreter for complex-structured **N**atural language **O**bject'. RHINO can call as '**R**eal **H**angul **IN**put **O**bject' already officially presented the name in Choi (2014).
- RHINO is most cogent and efficient Korean Morphological Analyser what may solve issues of morphological ambiguity and compound words in Korean Natural Language Text Processing with the innovatively designed and developed dynamic dictionary related techniques by subject matter expert of Korean Linguistics.
- So that RHINO run lightly but processing rightly even without sophisticated statistical techniques like the Deep Neural Network.
- RHINO parses Korean words by morpheme and part-of-speech, dictionaries are base on Korean Modern Tagged Corpus(12 million phrases scale) which was made by the Korean government.
- The current version of RHINO is 2.5.4
- Developer: Sukjae Choi <lingua72@gmail.com> (PhD in Korean Linguistics)
- Related blog (in Korean): http://blog.naver.com/lingua/220844372930

## Citation (Style of American Psychological Association)
Please cite when you got any result with RHINO for improving performance. 
- Choi, S. (2014). Implementation of Open Type Korean Morphological
Analyzer Based on Collective Intelligence. *Language & Information Society, 22*, 53-82. Retrieved from http://kiss.kstudy.com/journal/thesis_name.asp?key=3261537
- (Korean citation): 최석재 (2014). 집단지성을 이용하는 개방형 형태소 분석기의 설계와 구현. *언어와 정보사회, 22*, 53-82. http://kiss.kstudy.com/journal/thesis_name.asp?key=3261537

## Installation
- RHINO requires Oracle Java 8 Environments.
- If you want to run RHINO on R, you can run it.
- If you want to run with Graphical User Interface on Windows environment or hard to use R, Download here: https://sourceforge.net/projects/koreananalyzer/
- For Ubuntu user, If you do not have any Oracle Java 8 Environments, execute this in the bash shell.
```BASH
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-set-default
sudo R CMD javareconf -e
R CMD javareconf -e
```

- You can install the RHINO in R console. If you have Windows environment, you may need the Rtools.
```R
install.packages('devtools')
install.packages('rJava')
devtools::install_devtools('SukjaeChoi/RHINO')
```

## Example
```R
> # Noun Extraction
> RHINO::getMorph('국립국어원은 국어 발전을 위한 어문 정책을 수립‧시행하고, 
+                 국민의 바른 언어생활을 위하여 다양한 연구 사업을 수행하고자 설립된
+                 문화체육관광부 소속 기관입니다.
+                 역사적으로는 세종대왕이 창제한 한글의 운용 방안을 마련했던 ‘집현전’의
+                 전통을 잇고자 1984년에 설립한
+                 ‘국어연구소’가 1991년 ‘국립국어연구원’으로 승격되었고,
+                 2004년에 지금의 ‘국립국어원’으로 거듭나
+                 오늘에 이릅니다.', file = T, fileName = 'getMorph.txt', type = 'noun')
 [1] "국립"           "국어"           "원"             "국어"          
 [5] "발전"           "어문"           "정책"           "수립"          
 [9] "국민"           "언어생활"       "연구"           "사업"          
[13] "문화체육관광부" "소속"           "기관"           "역사"          
[17] "세종대왕"       "한글"           "운용"           "방안"          
[21] "집현전"         "전통"           "국어"           "연구소"        
[25] "가"             "국립국어연구원" "지금"           "국립"          
[29] "국어"           "원"             "오늘"          
> 
> # Differ with KoNLP; RHINO was better
> library('KoNLP')
Checking user defined dictionary!

> get_dictionary('woorimalsam')
> get_dictionary('insighter')
> get_dictionary('sejong')
> useNIADic()
> extractNoun('국립국어원은 국어 발전을 위한 어문 정책을 수립‧시행하고, 
+                  국민의 바른 언어생활을 위하여 다양한 연구 사업을 수행하고자 설립된
+                  문화체육관광부 소속 기관입니다.
+                  역사적으로는 세종대왕이 창제한 한글의 운용 방안을 마련했던 ‘집현전’의
+                  전통을 잇고자 1984년에 설립한
+                  ‘국어연구소’가 1991년 ‘국립국어연구원’으로 승격되었고,
+                  2004년에 지금의 ‘국립국어원’으로 거듭나
+                  오늘에 이릅니다.', autoSpacing = T) # auto spacing on
 [1] "국립"                   "국어"                   "원"                    
 [4] "국어"                   "발전"                   "어문"                  
 [7] "정책"                   "수립‧"                  "시행"                  
[10] "국민"                   "언어"                   "생활"                  
[13] "다양"                   "한"                     "연구"                  
[16] "사업"                   "수행"                   "하고"                  
[19] "설립"                   "문화체육관"             "광부"                  
[22] "소속"                   "기관"                   "역사"                  
[25] "적"                     "세종대왕"               "창제"                  
[28] "한"                     "한글"                   "운용"                  
[31] "방안"                   "마련"                   "‘집"                  
[34] "현전’"                 "전"                     "통"                    
[37] "1984"                   "년"                     "설립"                  
[40] "한"                     "‘국어연구소’가"       "1991"                  
[43] "년"                     "‘국립국어연구원’으로" "승격"                  
[46] "되"                     "2004"                   "년"                    
[49] "지금"                   "‘국립국어"             "원’"                  
[52] "으"                     "것"                     "오늘"                  
> 
> extractNoun('국립국어원은 국어 발전을 위한 어문 정책을 수립‧시행하고, 
+                  국민의 바른 언어생활을 위하여 다양한 연구 사업을 수행하고자 설립된
+                  문화체육관광부 소속 기관입니다.
+                  역사적으로는 세종대왕이 창제한 한글의 운용 방안을 마련했던 ‘집현전’의
+                  전통을 잇고자 1984년에 설립한
+                  ‘국어연구소’가 1991년 ‘국립국어연구원’으로 승격되었고,
+                  2004년에 지금의 ‘국립국어원’으로 거듭나
+                  오늘에 이릅니다.', autoSpacing = F) # auto spacing off
 [1] "국립"                   "국어"                   "원"                    
 [4] "국어"                   "발전"                   "어문"                  
 [7] "정책"                   "수립‧시행하고"          "국민"                  
[10] "언어"                   "생활"                   "다양"                  
[13] "한"                     "연구"                   "사업"                  
[16] "수행"                   "하고"                   "설립"                  
[19] "문화체육관"             "광부"                   "소속"                  
[22] "기관"                   "역사"                   "적"                    
[25] "세종대왕"               "창제"                   "한"                    
[28] "한글"                   "운용"                   "방안"                  
[31] "마련"                   "‘집현전’"             "전통"                  
[34] "1984"                   "년"                     "설립"                  
[37] "한"                     "‘국어연구소’가"       "1991"                  
[40] "년"                     "‘국립국어연구원’으로" "승격"                  
[43] "되"                     "2004"                   "년"                    
[46] "지금"                   "‘국립국어원’으로"     "오늘"                  
> 
> useSejongDic() # change dictionary
Backup was just finished!
370957 words dictionary was built.
> extractNoun('국립국어원은 국어 발전을 위한 어문 정책을 수립‧시행하고, 
+                  국민의 바른 언어생활을 위하여 다양한 연구 사업을 수행하고자 설립된
+                  문화체육관광부 소속 기관입니다.
+                  역사적으로는 세종대왕이 창제한 한글의 운용 방안을 마련했던 ‘집현전’의
+                  전통을 잇고자 1984년에 설립한
+                  ‘국어연구소’가 1991년 ‘국립국어연구원’으로 승격되었고,
+                  2004년에 지금의 ‘국립국어원’으로 거듭나
+                  오늘에 이릅니다.', autoSpacing = T) # auto spacing on
 [1] "국립"                   "국어"                   "원"                    
 [4] "국어"                   "발전"                   "어문"                  
 [7] "정책"                   "수립‧"                  "시행"                  
[10] "국민"                   "언어"                   "생활"                  
[13] "다양"                   "한"                     "연구"                  
[16] "사업"                   "수행"                   "설립"                  
[19] "문화체육관"             "광부"                   "소속"                  
[22] "기관"                   "역사"                   "적"                    
[25] "세종대왕이"             "창제"                   "한"                    
[28] "한글"                   "운용"                   "방안"                  
[31] "마련"                   "‘집현전’"             "전통"                  
[34] "1984"                   "년"                     "설립"                  
[37] "한"                     "‘국어연구소’가"       "1991"                  
[40] "년"                     "‘국립국어연구원’으로" "승격"                  
[43] "2004"                   "년"                     "지금"                  
[46] "‘국립국어원’으로"     "오늘"                  
> 
> extractNoun('국립국어원은 국어 발전을 위한 어문 정책을 수립‧시행하고, 
+                  국민의 바른 언어생활을 위하여 다양한 연구 사업을 수행하고자 설립된
+                  문화체육관광부 소속 기관입니다.
+                  역사적으로는 세종대왕이 창제한 한글의 운용 방안을 마련했던 ‘집현전’의
+                  전통을 잇고자 1984년에 설립한
+                  ‘국어연구소’가 1991년 ‘국립국어연구원’으로 승격되었고,
+                  2004년에 지금의 ‘국립국어원’으로 거듭나
+                  오늘에 이릅니다.', autoSpacing = F) # auto spacing off
 [1] "국립"                   "국어"                   "원"                    
 [4] "국어"                   "발전"                   "어문"                  
 [7] "정책"                   "수립‧시행하고"          "국민"                  
[10] "언어"                   "생활"                   "다양"                  
[13] "한"                     "연구"                   "사업"                  
[16] "수행"                   "설립"                   "문화체육관"            
[19] "광부"                   "소속"                   "기관"                  
[22] "역사"                   "적"                     "세종대왕이"            
[25] "창제"                   "한"                     "한글"                  
[28] "운용"                   "방안"                   "마련"                  
[31] "‘집현전’"             "전통"                   "1984"                  
[34] "년"                     "설립"                   "한"                    
[37] "‘국어연구소’가"       "1991"                   "년"                    
[40] "‘국립국어연구원’으로" "승격"                   "2004"                  
[43] "년"                     "지금"                   "‘국립국어원’으로"    
[46] "오늘"                  
```

## software quality check
### windows environment
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/seonghobae/RHINO?branch=master&svg=true)](https://ci.appveyor.com/project/seonghobae/RHINO)
### ubuntu environment
[![Travis-CI Build Status](https://travis-ci.org/seonghobae/RHINO.svg?branch=master)](https://travis-ci.org/seonghobae/RHINO)
### code coverage test
[![Coverage Status](https://img.shields.io/codecov/c/github/seonghobae/RHINO/master.svg)](https://codecov.io/github/seonghobae/RHINO?branch=master)
