####신한카드 
foreigner <- read.table("FOREIGNER.txt",sep="|",header=TRUE)
native <- read.table("NATIVE_RE.txt",sep="|",header=TRUE)
#결측치 제거, 지역 바꾸기
# 분류 1. 외국인 2. 내국인
# 데이터 바꾸고 내외국인 합치기 


#내국인 
native_1 <- native %>% separate(ta_ym,into = c("year","month"),sep=-2, convert=TRUE) %>% select(month,year)
native<- tibble(cbind(native,native_1))
native_2 <- native %>% unite(v4,v2,v3,sep=" ") %>% select(v4)
native<- tibble(cbind(native,native_2))

## 교통 삭제, 쇼핑, 숙박, 스포츠, 음식, 의료,체험
n_trip <- native %>% filter(v1 != v2)
n_trip  <- n_trip  %>% mutate( gb_new = fct_collapse(gb2,
                                                     "쇼핑" = c("관광쇼핑","종합쇼핑","패션쇼핑"),
                                                     "숙박" = c("숙박"),
                                                     "스포츠" = c("골프","레저스포츠","스키","운동경기관람","자전거","헬스"),
                                                     "음식" = c("외식","유흥"),
                                                     "의료,미용" = c("미용"),
                                                     "체험" = c("체험"),
                                                     "문화" = c("공연관람","미술공예참여"),
                                                     "관광" = c("여행사"),
                                                     "기타" = c("악기연주","음악감상","스포츠용품구매","교통","교육훈련","독서","목욕","애완동물돌보기","인터넷게임","종교활동","사진촬영")
))




#외국인 
foreigner_1 <- foreigner %>% separate(ta_ym,into = c("year","month"),sep=-2, convert=TRUE) %>% select(month,year)
foreigner<- tibble(cbind(foreigner,foreigner_1))
foreigner_2 <- foreigner %>% unite(v4,v2,v3,sep=" ") %>% select(v4)
foreigner<- tibble(cbind(foreigner,foreigner_2))
foreigner <- foreigner %>% filter(v2 != "*" & v3 != "*")
foreigner1 <- foreigner %>% filter(v1 == ""| v1 == "*") 
foreigner2 <- foreigner %>% filter(v1 != "" & v1 != "*") %>% select(-v4) # 모두 2020년 7월 이후 자료 
foreigner_2 <- foreigner2 %>% unite(v4,v1,v2,sep=" ") %>% select(v4)
foreigner2<- tibble(cbind(foreigner2,foreigner_2))
ff<- tibble(rbind(foreigner1,foreigner2))
ff <- ff %>% separate(v4, into=c("v5","v6"), sep=" ")
ff_1 <- ff %>% unite(v4,v5,v6,sep=" ") %>% select(v4)
ff<- tibble(cbind(ff,ff_1))
ff <- ff  %>% mutate( gb_new = fct_collapse(gb2,
                                            "쇼핑" = c("가전전자제품","기타쇼핑","기타지출","면세점","백화점","쇼핑몰","의류잡화","할인점/편의점","화장품"),
                                            "숙박" = c("1급2급호텔","특급호텔","그외숙박"),
                                            "스포츠" = c("당구장","레저스포츠","보트판매","볼링장","수영장","수중장비","스키장","스포츠센타/레포츠클럽","실내골프장","실외골프장","운동경기관람","자전거(성인용)","테니스장"),
                                            "음식" = c("유흥","음료제과","한식","한식외"),
                                            "의료,미용" = c("개인병원","보건소","산후조리원","약국","응급실운영  병원","의료기기,건강진단","접골원","종합병원","치과병원","한의원,한약방","이용,미용","피부미용"),
                                            "체험" = c("종합레저타운/놀이동산","오락시설","동물농장","목욕시설","수련원,체험장","수족관"),
                                            "문화" = c("공연장,극장"),
                                            "관광" = c("관광상품","관광여행사"),
                                            "기타" = c("기타")
))

##########EDA 그래프 그릴 자료 
EDA <- ff %>% group_by(v5) %>% count(wt=usec) %>% arrange(desc(n))
write.csv(EDA,"외국인 지역별 이용건수 EDA.csv",fileEncoding = "UTF-8")




############신한카드 업종 매출 
clu_f <- ff %>% filter(gb_new != "기타")  %>% group_by(v4,gb_new) %>% count(wt=vlm)
clu_n <- n_trip %>% filter(gb_new != "기타") %>% group_by(v4,gb_new) %>% count(wt=vlm)

clust <- full_join(clu_n,clu_f) %>% arrange(v4) %>% group_by(v4,gb_new) %>% count(wt=n) %>% spread(key=gb_new, value=n)
clust <- clust %>% mutate( v4 = fct_collapse(v4,
                                             "세종 세종시" = c("세종 .","세종 세종"),
)) 

names(clust) <- c("v4","s1","s2","s3","s4","s5","s6","s7","s8")
clust2 <- clust %>% group_by(v4) %>% count(wt=s1)
clust1 <- clust %>% group_by(v4) %>% count(wt=s1)
clust1$s1 <- clust2$n
clust1 <- clust1 %>% select(-n)
clust2 <- clust %>% group_by(v4) %>% count(wt=s2)
clust1$s2 <- clust2$n
clust2 <- clust %>% group_by(v4) %>% count(wt=s3)
clust1$s3 <- clust2$n
clust2 <- clust %>% group_by(v4) %>% count(wt=s4)
clust1$s4 <- clust2$n
clust2 <- clust %>% group_by(v4) %>% count(wt=s5)
clust1$s5 <- clust2$n
clust2 <- clust %>% group_by(v4) %>% count(wt=s6)
clust1$s6 <- clust2$n
clust2 <- clust %>% group_by(v4) %>% count(wt=s7)
clust1$s7 <- clust2$n
clust2 <- clust %>% group_by(v4) %>% count(wt=s8)
clust1$s8 <- clust2$n
clust <- clust1
write.csv(clust,"cluster_합.csv",fileEncoding = "UTF-8")

clust <- clust %>% mutate(whole=스포츠+문화+쇼핑+`의료,미용`+숙박+관광+음식+체험)
clust <- clust %>% mutate(s1 = 스포츠/whole,
                          s2 = 문화/whole,
                          s3 = 쇼핑/whole,
                          s4 = `의료,미용`/whole,
                          s5 = 숙박/whole,
                          s6 = 관광/whole,
                          s7 = 음식/whole,
                          s8 = 체험/whole,
)
clust <- clust %>% select(v4,s1,s2,s3,s4,s5,s6,s7,s8)
clust$region <- clust$v4
clust <- clust %>% ungroup() %>% select(-v4)







####현지인 이용건수  vs 외지인 이용건수 
(n_in <- native %>% filter(v1 == v2) %>% group_by(v4) %>% count(wt=usec))
(n_ex <- native %>% filter(v1 != v2) %>% group_by(v4) %>% count(wt=usec))
n_new <- n_ex
names(n_new) <-c("region","usec_ex")
n_new$usec_in <- n_in$n
n_new <- n_new %>% mutate( ratio_in_ex = usec_in/usec_ex)
n_new %>% arrange(desc(ratio_in_ex))
n_new %>% arrange(ratio_in_ex)
write.csv(n_new,"현지인 대 외지인.csv",fileEncoding = "UTF-8")




############## 방문자수 데이터 셋 
df <-read.csv(file.choose(),header=T) 
df <- tibble(df)
names(df) <- c("index","region","외국인","전년대비증가","외부방문자","외지인","전년외부","현지인")
df <-  df %>% filter( index != "구분")
unique(df$region)
df <- df %>% select(-전년대비증가)
df <- df %>% mutate( region = fct_collapse(region,
                                           "세종 세종시" = c("세종 세종특별자치시"),
                                           "경기 성남시"=c("경기 성남시 중원구","경기 성남시 수정구","경기 성남시 분당구"),
                                           "경기 수원시"=c("경기 수원시 팔달구","경기 수원시 장안구","경기 수원시 영통구","경기 수원시 권선구"),
                                           "경기 안산시"=c("경기 안산시 상록구","경기 안산시 단원구"),
                                           "경기 안양시"=c("경기 안양시 만안구","경기 안양시 동안구"),
                                           "경기 용인시"=c("경기 용인시 처인구","경기 용인시 수지구",	"경기 용인시 기흥구"),
                                           "경남 창원시"=c("경남 창원시 진해구","경남 창원시 의창구","경남 창원시 성산구","경남 창원시 마산회원구","경남 창원시 마산합포구"),
                                           "경북 포항시"=c("경북 포항시 북구","경북 포항시 남구"),
                                           "인천 남구"=c("인천 남동구"),
                                           "전북 전주시"=c("전북 전주시 완산구","전북 전주시 덕진구"),
                                           "충남 천안시"=c("충남 천안시 서북구","충남 천안시 동남구"),
                                           "충북 청주시" =c("충북 청주시 흥덕구","충북 청주시 청원구","충북 청주시 서원구","충북 청주시 상당구")
)) 


df$외국인 <- as.numeric(df$외국인)
df$외부방문자 <- as.numeric(df$외부방문자)
df$외지인 <- as.numeric(df$외지인)
df$전년외부 <- as.numeric(df$전년외부)
df$현지인 <- as.numeric(df$현지인)
df1 <- df %>% group_by(region) %>% count(wt=외국인)
df2 <- df %>% group_by(region) %>% count(wt=외국인)
df1$외국인 <- df2$n
df1 <- df1 %>% select(-n)
df2 <- df %>% group_by(region) %>% count(wt=외부방문자)
df1$외부방문자 <- df2$n
df2 <- df %>% group_by(region) %>% count(wt=외지인)
df1$외지인 <- df2$n
df2 <- df %>% group_by(region) %>% count(wt=전년외부)
df1$전년외부 <- df2$n
df2 <- df %>% group_by(region) %>% count(wt=현지인)
df1$현지인 <- df2$n
df <- df1
df %>% view()
write.csv(df,"방문자수.csv",fileEncoding = "UTF-8")




########### 크롤링데이터 지역 한글이름 대치
cc1 <-read.csv(file.choose(),header=T) 
cc <-read.csv(file.choose(),header=T) 
cc <- cc %>% mutate( region = fct_collapse(region,
                                           "강원 강릉시" = 'gangneung', 
                                           "강원 동해시" = 'donghae' , 
                                           "강원 춘천시" = 'chuncheon' , 
                                           "강원 삼척시" = 'samcheok', 
                                           "강원 원주시" = 'wonju' , 
                                           "강원 속초시" = 'sokcho'  , 
                                           "강원 고성군" = 'gangwon_goseong', 
                                           "강원 양구군" = 'yanggu' ,
                                           "강원 태백시" = 'taebaek' ,
                                           "강원 양양군" = 'yangyang' , 
                                           "강원 영월군" = 'yeongwol', 
                                           "강원 인제군" = 'inje',
                                           "강원 횡성군"  = 'hoengseong', 
                                           "강원 평창군"= 'pyeongchang', 
                                           "강원 정선군" = 'jeongseon', 
                                           "강원 홍천군" = 'hongcheon', 
                                           "강원 철원군" = 'cheolwon', 
                                           "강원 화천군" = 'hwacheon',
                                           
                                           "경기 김포시"= 'gimpo',
                                           "경기 군포시" = 'gunpo',
                                           "경기 광명시" = 'gwangmyeong',
                                           "경기 연천군" = 'yeoncheon', 
                                           "경기 안성시" = 'anseong', 
                                           "경기 부천시" = 'bucheon',
                                           "경기 이천시" = 'icheon', 
                                           "경기 포천시" = 'pocheon', 
                                           "경기 가평군"= 'gapyeong', 
                                           "경기 고양시" = 'goyang', 
                                           "경기 안산시" = 'ansan', 
                                           "경기 구리시" = 'guri', 
                                           "경기 오산시" = 'osan', 
                                           "경기 양평군" = 'yangpyeong', 
                                           "경기 의정부시" = 'uijeongbu', 
                                           "경기 동두천시" = 'dongducheon',
                                           "경기 과천시" = 'gwacheon',
                                           "경기 안양시" = 'anyang', 
                                           "경기 수원시" = 'suwon', 
                                           "경기 남양주시" = 'namyangju',
                                           "경기 화성시" = 'hwaseong',
                                           "경기 용인시" = 'yongin',
                                           "경기 파주시" = 'paju',
                                           "경기 평택시" = 'pyeongtaek',
                                           "경기 하남시" = 'hanam',
                                           "경기 시흥시" = 'siheung',
                                           "경기 양주시" = 'yangju', 
                                           "경기 광주시" = 'gyeonggi_gwangju',
                                           "경기 여주시" = 'yeoju',
                                           "경기 성남시"= 'seongnam',
                                           "경기 의왕시" = 'uiwang',
                                           
                                           "경남 거제시" = 'geoje',
                                           "경남 밀양시" = 'miryang',
                                           "경남 김해시" = 'gimhae',
                                           "경남 통영시" = 'tongyeong',
                                           "경남 거창군" = 'geochang', 
                                           "경남 진주시" = 'jinju',
                                           "경남 고성군" = 'gyeongnam_goseong',
                                           "경남 사천시" = 'sacheon', 
                                           "경남 남해군" = 'namhae',
                                           "경남 양산시" = 'yangsan', 
                                           "경남 산청군" = 'sancheong', 
                                           "경남 하동군" = 'hadong', 
                                           "경남 창녕군" = 'changnyeong', 
                                           "경남 함안군" = 'haman',
                                           "경남 함양군" = 'hamyang',
                                           "경남 의령군" = 'uiryeong',
                                           "경남 창원시"  = 'changwon',
                                           "경남 합천군" = 'hapcheon',
                                           
                                           "경북 경주시"=  'gyeongju',
                                           "경북 경산시" = 'gyeongsan',
                                           "경북 고령군"='goryeong',
                                           "경북 안동시" = 'andong', 
                                           "경북 김천시" ='gimcheon', 
                                           "경북 포항시"='pohang', 
                                           "경북 영주시" = 'yeongju', 
                                           "경북 문경시"='mungyeong',
                                           "경북 상주시"='sangju',
                                           "경북 구미시"='gumi',
                                           "경북 영천시" ='yeongcheon',
                                           "경북 군위군" = 'gunwi', 
                                           "경북 봉화군"  ='bonghwa',
                                           "경북 영덕군" ='yeongdeok',
                                           "경북 성주군" ='seongju', 
                                           "경북 울릉군"  ='ulleung',
                                           "경북 예천군"  ='yecheon', 
                                           "경북 의성군" ='uiseong',
                                           "경북 영양군" ='yeongyang',
                                           "경북 청송군" ='cheongsong',
                                           "경북 청도군" ='cheongdo',
                                           "경북 울진군" ='uljin',
                                           "경북 칠곡군" ='chilgok',
                                           
                                           "광주 서구" = 'gwangju_seogu', 
                                           "광주 동구"  =  'gwangju_donggu', 
                                           "광주 광산구"= 'gwangsan', 
                                           "광주 북구"  = 'gwangju_bukgu', 
                                           "광주 남구" = 'gwangju_namgu',
                                           
                                           "대구 동구" =   'daegu_donggu', 
                                           "대구 남구" =   'daegu_namgu',
                                           "대구 서구" = 'daegu_seogu',
                                           "대구 중구" = 'daegu_junggu',
                                           "대구 달서구" =  'dalseo', 
                                           "대구 북구"  ='daegu_bukgu', 
                                           "대구 수성구" = 'suseong', 
                                           "대구 달성군" = 'dalseong',
                                           
                                           "대전 중구" = 'daejeon_junggu',
                                           "대전 동구" = 'daejeon_donggu',
                                           "대전 대덕구" = 'daedeok',
                                           "대전 서구" = 'daejeon_seogu', 
                                           "대전 유성구" = 'yuseong',
                                           
                                           "부산 서구" ='busan_seogu',
                                           "부산 영도구" ='yeongdo',
                                           "부산 중구" ='busan_junggu', 
                                           "부산 동구"  ='busan_donggu',
                                           "부산 해운대구" ='haeundae', 
                                           "부산 금정구"='Geumjeong',
                                           "부산 동래구"  ='dongnae',
                                           "부산 북구"   ='busan_bukgu',
                                           "부산 사하구" ='saha',
                                           "부산 부산진구" ='busanjin', 
                                           "부산 남구"  ='busan_namgu', 
                                           "부산 수영구"  ='suyeong', 
                                           "부산 연제구" ='yeonje', 
                                           "부산 강서구" = 'busan_gangseo',
                                           "부산 사상구"  ='sasang',
                                           "부산 기장군" = 'gijang',
                                           '서울 종로구'='jongno', 
                                           '서울 중구'='seoul_junggu', 
                                           '서울 용산구'='yongsan', 
                                           '서울 노원구'='nowon', 
                                           '서울 성동구'='seongdong', 
                                           '서울 동대문구'='dongdaemun', 
                                           '서울 강북구'='seoul_gangbuk', 
                                           '서울 도봉구'='dobong', 
                                           '서울 중랑구'='jungnang', 
                                           '서울 성북구'='seongbuk', 
                                           '서울 광진구'='gwangjin', 
                                           '서울 은평구'='eunpyeong', 
                                           '서울 양천구'='yangcheon', 
                                           '서울 구로구'='guro', 
                                           '서울 강서구'='seoul_gangseo', 
                                           '서울 서대문구'='seodaemun',  
                                           '서울 영등포구'='yeongdeungpo', 
                                           '서울 마포구'='mapo', 
                                           '서울 금천구'='geumcheon',  
                                           '서울 서초구'='seocho', 
                                           '서울 동작구'='dongjak', 
                                           '서울 관악구'='gwanak', 
                                           '서울 송파구'='songpa', 
                                           '서울 강동구'='seoul_gangdong', 
                                           '서울 강남구'='seoul_gangnam',  
                                           
                                           "울산 중구"  ='ulsan_junggu', 
                                           "울산 남구" ='ulsan_namgu',  
                                           "울산 동구"  ='ulsan_donggu', 
                                           "울산 북구"='ulsan_bukgu', 
                                           "울산 울주군"='ulju',
                                           
                                           "인천 동구"  ='incheon_donggu', 
                                           "인천 중구"='incheon_junggu', 
                                           "인천 옹진군" ='ongjin', 
                                           "인천 서구"='incheon_seogu', 
                                           "인천 연수구"='yeonsu', 
                                           "인천 부평구" ='bupyeong', 
                                           '인천 남동구'='namdonggu', 
                                           "인천 미추홀구" ='michuhol', 
                                           "인천 계양구" ='gyeyang', 
                                           "인천 강화군"  ='ganghwa',
                                           
                                           "전남 완도군" ='wando', 
                                           "전남 신안군"  ='sinan',
                                           "전남 진도군" ='jindo', 
                                           "전남 무안군" ='muan',
                                           "전남 보성군"='boseong', 
                                           "전남 화순군"='hwasun', 
                                           "전남 광양시"='gwangyang', 
                                           "전남 순천시"='suncheon', 
                                           "전남 함평군"='hampyeong', 
                                           "전남 담양군" ='damyang',
                                           "전남 목포시" ='mokpo', 
                                           "전남 나주시" ='naju', 
                                           "전남 해남군"='haenam', 
                                           "전남 구례군"='gurye', 
                                           "전남 장성군"='jangseong', 
                                           "전남 고흥군" ='goheung', 
                                           "전남 영광군"='yeonggwang', 
                                           "전남 장흥군"='jangheung', 
                                           "전남 곡성군" ='gokseong', 
                                           "전남 강진군"='gangjin', 
                                           "전남 영암군"='yeongam', 
                                           "전남 여수시" ='yeosu',
                                           
                                           "전북 김제시"='gimje', 
                                           "전북 부안군"='buan',
                                           "전북 군산시"='gunsan',
                                           "전북 정읍시"='jeongeup',
                                           "전북 남원시"='namwon', 
                                           "전북 장수군" ='jangsu',
                                           "전북 익산시"='iksan',
                                           "전북 무주군"='muju', 
                                           "전북 전주시" ='jeonju', 
                                           "전북 완주군"='wanju', 
                                           "전북 임실군"='imsil', 
                                           "전북 진안군"='jinan', 
                                           "전북 고창군" ='gochang', 
                                           "전북 순창군" ='sunchang',
                                           
                                           "충남 태안군"='taean', 
                                           "충남 보령시"='boryeong', 
                                           "충남 당진시"='dangjin',
                                           "충남 논산시"='nonsan', 
                                           "충남 서천군"='seocheon', 
                                           "충남 부여군"='buyeo', 
                                           "충남 공주시" ='gongju', 
                                           "충남 예산군" ='yesan', 
                                           "충남 홍성군"='hongseong', 
                                           "충남 천안시" ='cheonan', 
                                           "충남 서산시"='seosan', 
                                           "충남 아산시"='asan', 
                                           "충남 계룡시"='gyeryong', 
                                           "충남 금산군"='geumsan', 
                                           "충남 청양군" ='cheongyang',
                                           
                                           "충북 청주시"  ='cheongju', 
                                           "충북 보은군" ='boeun',
                                           "충북 음성군" ='eumseong',
                                           "충북 진천군"='jincheon', 
                                           "충북 괴산군"='goesan', 
                                           "충북 충주시"='chungju',
                                           "충북 제천시"='jecheon',
                                           "충북 단양군"='danyang',
                                           "충북 옥천군"='okcheon', 
                                           "충북 증평군"='jeungpyeong',
                                           "충북 영동군"='yeongdong',
                                           "세종 세종시" = "sejong",
                                           "제주 제주시" = "jejusi",
                                           "제주 서귀포시" = "seogwipo"
))

cc1$region1 <- cc$region
write.csv(cc1,"cluster_result_한글추가.csv",fileEncoding = "UTF-8")



##### 기초지자체 방문자수 전처리 ##############
library(tidyverse)
dat1<-read.csv("기초지자체 방문자수_20210723.csv", header=T) 
dat2<-read.csv("기초지자체 방문자수_20210723-2.csv", header=T) 
dat3<-read.csv("기초지자체 방문자수_20210723-3.csv", header=T) 
dat4<-read.csv("기초지자체 방문자수_20210723-4.csv", header=T) 
dat5<- read.csv("기초지자체 방문자수_20210723-5.csv", header=T) 
dat6<-read.csv("기초지자체 방문자수_20210723-6.csv", header=T) 
dat7<-read.csv("기초지자체 방문자수_20210723-7.csv", header=T) 
dat8<-read.csv("기초지자체 방문자수_20210723-8.csv", header=T) 
dat9<-read.csv("기초지자체 방문자수_20210723-9.csv", header=T) 
dat10<-read.csv("기초지자체 방문자수_20210723-10.csv", header=T) 
dat11<-read.csv("기초지자체 방문자수_20210723-11.csv", header=T) 
dat12<-read.csv("기초지자체 방문자수_20210723-12.csv", header=T) 
dat13<-read.csv("기초지자체 방문자수_20210723-13.csv", header=T) 
dat14<-read.csv("기초지자체 방문자수_20210723-14.csv", header=T) 
dat15<-read.csv("기초지자체 방문자수_20210723-15.csv", header=T) 
dat16<-read.csv("기초지자체 방문자수_20210723-16.csv", header=T) 
dat17<-read.csv("기초지자체 방문자수_20210723-17.csv", header=T) 

dat1 <- tibble(dat1) #서울
dat2 <- tibble(dat2) # 부산
dat3 <- tibble(dat3) # 대구
dat4 <- tibble(dat4) # 인천
dat5<- tibble(dat5) #광주
dat6 <- tibble(dat6)#대전
dat7 <- tibble(dat7)#울산
dat8 <- tibble(dat8) #세종
dat9 <- tibble(dat9)#경기
dat10 <- tibble(dat10)#강원
dat11 <- tibble(dat11)#충북
dat12 <- tibble(dat12)#충남
dat13 <- tibble(dat13)#전북
dat14 <- tibble(dat14)#전남
dat15 <- tibble(dat15)#경북
dat16 <- tibble(dat16)#경남
dat17 <- tibble(dat17)#제주

dat1$도 <- rep("서울",nrow(dat1))
dat1 <- dat1 %>% unite(지역,도,지역,sep=" ")
dat2$도 <- rep("부산",nrow(dat2))
dat2 <- dat2 %>% unite(지역,도,지역,sep=" ")
dat3$도 <- rep("대구",nrow(dat3))
dat3 <- dat3 %>% unite(지역,도,지역,sep=" ")
dat4$도 <- rep("인천",nrow(dat4))
dat4 <- dat4 %>% unite(지역,도,지역,sep=" ")
dat5$도 <- rep("광주",nrow(dat5))
dat5 <- dat5 %>% unite(지역,도,지역,sep=" ")
dat6$도 <- rep("대전",nrow(dat6))
dat6 <- dat6 %>% unite(지역,도,지역,sep=" ")
dat7$도 <- rep("울산",nrow(dat7))
dat7 <- dat7 %>% unite(지역,도,지역,sep=" ")
dat8$도 <- rep("세종",nrow(dat8))
dat8 <- dat8 %>% unite(지역,도,지역,sep=" ")
dat9$도 <- rep("경기",nrow(dat9))
dat9 <- dat9 %>% unite(지역,도,지역,sep=" ")
dat10$도 <- rep("강원",nrow(dat10))
dat10 <- dat10 %>% unite(지역,도,지역,sep=" ")
dat11$도 <- rep("충북",nrow(dat11))
dat11 <- dat11 %>% unite(지역,도,지역,sep=" ")
dat12$도 <- rep("충남",nrow(dat12))
dat12 <- dat12 %>% unite(지역,도,지역,sep=" ")
dat13$도 <- rep("전북",nrow(dat13))
dat13 <- dat13 %>% unite(지역,도,지역,sep=" ")
dat14$도 <- rep("전남",nrow(dat14))
dat14 <- dat14 %>% unite(지역,도,지역,sep=" ")
dat15$도 <- rep("경북",nrow(dat15))
dat15 <- dat15 %>% unite(지역,도,지역,sep=" ")
dat16$도 <- rep("경남",nrow(dat16))
dat16 <- dat16 %>% unite(지역,도,지역,sep=" ")
dat17$도 <- rep("제주",nrow(dat17))
dat17 <- dat17 %>% unite(지역,도,지역,sep=" ")

dat<-rbind(dat1,dat2,dat3,dat4,dat5,dat6,dat7,dat8,dat9,dat10,dat11,dat12,dat13,dat14,dat15,dat16,dat17)
dat <- dat %>% spread(key=구분,value=X2019)
dat <- dat %>% mutate( region = fct_collapse(지역,
                                               "세종 세종시" = c("세종 세종특별자치시"),
                                               "경기 고양시" = c("경기 고양시 일산동구","경기 고양시 일산서구","경기 고양시 덕양구"),
                                               "경기 성남시"=c("경기 성남시 중원구","경기 성남시 수정구","경기 성남시 분당구"),
                                               "경기 수원시"=c("경기 수원시 팔달구","경기 수원시 장안구","경기 수원시 영통구","경기 수원시 권선구"),
                                               "경기 안산시"=c("경기 안산시 상록구","경기 안산시 단원구"),
                                               "경기 안양시"=c("경기 안양시 만안구","경기 안양시 동안구"),
                                               "경기 용인시"=c("경기 용인시 처인구","경기 용인시 수지구",	"경기 용인시 기흥구"),
                                               "경남 창원시"=c("경남 창원시 진해구","경남 창원시 의창구","경남 창원시 성산구","경남 창원시 마산회원구","경남 창원시 마산합포구"),
                                               "경북 포항시"=c("경북 포항시 북구","경북 포항시 남구"),
                                               "전북 전주시"=c("전북 전주시 완산구","전북 전주시 덕진구"),
                                               "충남 천안시"=c("충남 천안시 서북구","충남 천안시 동남구"),
                                               "충북 청주시" =c("충북 청주시 흥덕구","충북 청주시 청원구","충북 청주시 서원구","충북 청주시 상당구")
)) 


dat <- dat %>% filter( 지역 != "인천 남구") %>% select(-지역)
dat <- dat[,c(7,1,2,3,4,5,6)]
write.csv(dat,"방문자수_r.csv",fileEncoding = "UTF-8")



## pca를 위한 데이터 처리


세개를 하나로 pca 자료 통합

in_outer <- n_new %>% select(region,ratio_ex_in)
visit <-read.csv("방문자수_final (1).csv",header=T) 
visit <- visit %>% select(-X)

tour <- tour %>% separate(region, into = c("region1","region2"),sep=" ")
tour<- tour %>% select(-X)
tour <- tour %>% mutate(region1 = fct_collapse(region1,"강원" = "강원도",
                                               "경기" = "경기도",
                                               "경남" = "경상남도",
                                               "경북"= "경상북도",
                                               "광주"= "광주광역시",
                                               "대구" = "대구광역시",
                                               "대전" = "대전광역시",
                                               "부산" = "부산광역시",  
                                               "서울"= "서울특별시",
                                               "세종" = "세종특별자치시",
                                               "울산" = "울산광역시",
                                               "인천" = "인천광역시",
                                               "전남" = "전라남도",
                                               "전북" = "전라북도",
                                               "제주" = "제주특별자치도",
                                               "충남" = "충청남도",
                                               "충북" =  "충청북도"))

tour <- tour %>% mutate(region2 = fct_collapse(region2,
                                               "세종시"="세종특별자치시", 
                                               "창원시"="통합창원시",
))

tour <- tour %>% unite(region,region1,region2,sep=" ")
tour <- tibble(tour)
tour <- tour %>% filter(region != "경남 창원시") #tour 자료의 place_num 변수는 사용하지 않기로 함 

sort(unique(in_outer$region))
data_pca1 <- right_join(tour,in_outer)
data_pca2 <- full_join(data_pca1,visit, by="region")
data_pca2 <- data_pca2 %>% select(-외국인,-외지인)
data_pca2$ratio_ex_in[230] <- 0.5463074
data_pca2 <- data_pca2 %>% filter(region != "세종 .")
names(data_pca2) <- c("region","place_num","ratio_ex_in","ratio_visit")
data_pca2$place_num[which(is.na(data_pca2$place_num))] <- 0
write.csv(data_pca2,"pca_data.csv",fileEncoding = "UTF-8")


final <-read.csv(file.choose(),header=T) 
final <- final %>% select(-Column1)
final <-  final %>% group_by(cluster_label) %>% arrange(cluster_label,pca1) 
write.csv(final,"FINAL.csv",fileEncoding = "UTF-8")



