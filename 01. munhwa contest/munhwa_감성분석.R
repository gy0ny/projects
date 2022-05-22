#########5. 감성분석(R)##############

#감성 사전 불러오기
library(dplyr)
library(readr)
dic <- read_csv("C:/Users/82105/Desktop/data/knu_senti_dict.csv")


#감성 분석을 위한 라이브러리 불러오기
library(stringr)


# 실제 텍스트 데이터 불러오기
library(readxl)
raw_news_comment <- read_excel("C:/Users/82105/Desktop/data/crawling/충청북도_증평군_2.xlsx")




# 결측치 행 제거
raw_news_comment = raw_news_comment[!is.na(raw_news_comment$content), ]
```

# 기본적인 전처리  

library(textclean)
news_comment <- raw_news_comment %>%
  mutate(id = row_number(),
         content = str_squish(replace_html(content)))


# 데이터 구조 확인
glimpse(news_comment)


library(tidytext)

# 토큰화
word_comment <- news_comment %>%
  unnest_tokens(input = content,
                output = word,
                token = "words",
                drop = F)
word_comment %>%
  select(word, content)


# 감정 점수 부여
word_comment <- word_comment %>%
  left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))
word_comment %>%
  select(word, polarity)


#댓글별 감정 점수 구하고 댓글 살펴보기
score_comment <- word_comment %>% group_by(id, content) %>% summarise(score = sum(polarity)) %>% ungroup()
score_comment %>% select(score, content)


#감정 점수 높은 댓글 살펴보기
#긍정 댓글
score_comment %>% select(score, content) %>% arrange(-score)

#부정 댓글
score_comment %>% select(score, content) %>% arrange(score)


write.csv(score_comment, "C:/Users/82105/Desktop/data/네이버블로그_감성분석_결과/충청북도_증평군_2.csv")




boxplot(score_comment$score)
q <- boxplot(score_comment$score)$stats



# 결측값 제거하고 지역별 평균 구하기 -> 최종 감성 점수

score_comment$score <- ifelse(score_comment$score < q[2]| score_comment$score > q[4], NA, score_comment$score)
score_comment = na.omit(score_comment)
senti_score = mean(score_comment$score)
senti_score
