# -*- coding: utf-8 -*-
"""
Created on Sun May 22 22:26:20 2022

@author: amy71
"""



#########1. 네이버 블로그 본문 요약 크롤링(python)##############
import os
import sys
import urllib.request
import json

client_id = "dQpiAFv6zE64JqA4SsOQ"
client_secret = "429hU2_AbB"

def naver_api(where, what, how): 
    
    # where :  뉴스, cafearticle, blog 등등
    # what : 찾을 검색어
    # how : 어떤 파일로 저장할지
    
    encText = urllib.parse.quote(what)
    
    for i in range(1,1001,100):
        url = "https://openapi.naver.com/v1/search/" + where +"?query=" + encText +"&display=100" + '&start=' + str(i) + "&sort=sim"
        
        request = urllib.request.Request(url)
        request.add_header("X-Naver-Client-Id",client_id)
        request.add_header("X-Naver-Client-Secret",client_secret)
        response = urllib.request.urlopen(request)
        rescode = response.getcode()
        if(rescode==200):
            response_body = response.read()
            results = response_body.decode('utf-8') # 사람 언어로 바꾸는 코드
            # print(response_body.decode('utf-8'))
            items = json.loads(results)['items'] # 딕셔너리로 바꿔주는 코드

            for item in items:
                f = open(how, 'a', encoding = "utf-8")
                #title = item['title']
                description = item['description']

                #title = title.replace('<b>', '')
                #title = title.replace('</b>','')
                description = description.replace('<b>', '')
                description = description.replace('</b>','')
                description = description.replace('...', '')
                description = description.replace('\n',' ')

                #f.write(title + '\n')
                f.write(description + '\n')
                f.close()
        else:
            print("Error Code:" + rescode)


# 경기도
Gyeonggido = ['고양시', '과천시', '광명시', '광주시', '구리시', '군포시', '김포시', '남양주시', '동두천시', '부천시','성남시', '수원시', '시흥시', '안산시', '안성시', '안양시', '양주시', '여주시', '오산시', '용인시','의왕시', '의정부시', '이천시', '파주시', '평택시', '포천시', '하남시', '화성시', '가평군', '양평군', '연천군']

for region in Gyeonggido:
    naver_api('blog','경기도' + ' ' + region + '' + '여행', str(region)+'.txt')

# 경상남도

Gyeongsangnamdo = ['거제시', '김해시', '밀양시', '사천시', '양산시', '진주시', '창원시', '통영시',
'거창군', '고성군', '남해군', '산청군', '의령군', '창녕군', '하동군', '함안군',
'함양군', '합천군']

for region in Gyeongsangnamdo:
    naver_api('blog','경상남도' + ' ' + region + '' + '여행', str(region)+'.txt')

# 경상북도

Gyeongsangbukdo = ['경산시', '경주시', '구미시', '김천시', '문경시', '상주시', '안동시', '영주시', '영천시', '포항시','고령군', '군위군', '봉화군', '성주군', '영덕군', '영양군', '예천군', '울릉군', '울진군', '의성군', '청도군',
'청송군', '칠곡군']

for region in Gyeongsangbukdo:
    naver_api('blog','경상북도' + ' ' + region + '' + '여행', str(region)+'.txt')


#전라남도

Jeollanamdo = ['광양시', '나주시', '목포시', '순천시', '여수시', '강진군', '고흥군', '곡성군', '구례군', '담양군', '무안군', '보성군', '신안군', '영광군', '영암군', 
'완도군', '장성군', '장흥군', '진도군', '함평군', '해남군', '화순군' ]

for region in Jeollanamdo:
    naver_api('blog','전라남도' + ' ' + region + '' + '여행', str(region)+'.txt')

#전라북도

Jeollabukdo = ['군산시', '김제시', '남원시', '익산시', '전주시', '정읍시', '고창군', '무주군', '부안군', '순창군', '완주군', '임실군', '장수군', '진안군' ]

for region in Jeollabukdo:
    naver_api('blog','전라북도' + ' ' + region + '' + '여행', str(region)+'.txt') 


#세종특별자치시

Sejong = ['세종시']

for region in Sejong:
    naver_api('blog', region + '' + '여행', str(region)+'.txt')


#제주특별자치도

Jeju = ['제주시', '서귀포시']

for region in Jeju:
    naver_api('blog', '제주도' + region + '' + '여행', str(region)+'.txt')


#서울특별시

seoul = ['종로구', '중구', '용산구', '성동구', '광진구', '동대문구', '중랑구', 
         '성북구', '강북구', '도봉구', '노원구', '은평구','서대문구', '마포구', 
         '양천구', '강서구', '구로구', '금천구', '영등포구', '동작구', '관악구', 
         '서초구', '강남구', '송파구', '강동구' ]

for region in seoul:
    naver_api('blog','서울' + ' ' + region + '' + '여행', str(region)+'.txt')


#강원도

gangwon = ['강릉시', '동해시', '삼척시', '속초시', '원주시', '춘천시', '태백시',
           '고성군', '양구군', '양양군', '영월군', '인제군', '정선군', '철원군', 
           '평창군', '홍천군', '화천군', '횡성군']

for region in gangwon:
    naver_api('blog','강원도' + ' ' + region + '' + '여행', str(region)+'.txt')


#충청북도

chungbuk = ['제천시', '청주시', '충주시', '괴산군', '단양군', '보은군', 
            '영동군', '옥천군', '음성군', '증평군', '진천군' ]

for region in chungbuk:
    naver_api('blog','충청북도' + ' ' + region + '' + '여행', str(region)+'.txt')


#충청남도
chungnam = ['계룡시', '공주시', '논산시', '당진시', '보령시', '서산시', 
            '아산시', '천안시', '금산군', '부여군', '서천군', '예산군', 
            '청양군', '태안군', '홍성군']

for region in chungnam:
    naver_api('blog','충청남도' + ' ' + region + '' + '여행', str(region)+'.txt')


#부산광역시
busan = ['중구', '서구', '동구', '영도구', '부산진구', '동래구', '남구', 
         '북구', '해운대구', '사하구', '금정구', '강서구', '연제구', '수영구', 
         '사상구','기장군']

for region in busan:
    naver_api('blog','부산' + ' ' + region + '' + '여행', str(region)+'.txt')


#대구광역시
daegu = ['중구', '동구', '서구', '남구', '북구', '수성구', '달서구','달성군']

for region in daegu:
    naver_api('blog','대구' + ' ' + region + '' + '여행', str(region)+'.txt')


#인천광역시
incheon = ['중구', '동구', '미추홀구', '연수구', '남동구', 
           '부평구', '계양구', '서구', '강화군', '옹진군']

for region in incheon:
    naver_api('blog','인천' + ' ' + region + '' + '여행', str(region)+'.txt')


#대전광역시
daejeon = ['동구', '중구', '서구', '유성구', '대덕구']

for region in daejeon:
    naver_api('blog','대전' + ' ' + region + '' + '여행', str(region)+'.txt')


#울산광역시
ulsan = ['중구', '남구', '동구', '북구', '울주군']

for region in ulsan:
    naver_api('blog','울산' + ' ' + region + '' + '여행', str(region)+'.txt')


#광주광역시
gwangju = ['동구', '서구', '남구', '북구', '광산구']


for region in gwangju:
    naver_api('blog','광주' + ' ' + region + '' + '여행', str(region)+'.txt')



#########1. 네이버 블로그 본문 전체 크롤링(python)##############

from selenium import webdriver
import time
 
# 크롬 웹브라우저 실행
path = "C:/Users/82105/Downloads/chromedriver_win32/chromedriver.exe"
 
driver = webdriver.Chrome(path)
url_list = []
title_list = []
content_list = []




for i in range(0,20):  # 1~20페이지까지의 블로그 내용을 읽어옴
    url = 'https://section.blog.naver.com/Search/Post.nhn?pageNo='+ str(i+1) + '&rangeType=ALL&orderBy=sim&keyword=' + '경기도' + ' ' + '양주시' + ' ' + '여행'

    driver.get(url)
    time.sleep(1)
 
    for j in range(1, 8): # 각 블로그 주소 저장
        titles = driver.find_element_by_xpath('/html/body/ui-view/div/main/div/div/section/div[2]/div['+str(j)+']/div/div[1]/div[1]/a[1]')
        title = titles.get_attribute('href')
        url_list.append(title)

     
        
print("url 수집 끝, 해당 url 데이터 크롤링")
 

dict = {}  # 전체 크롤링 데이터를 담을 그릇

# 수집할 글 갯수

for i in range(len(url_list)): 
    # 글 띄우기
    driver = webdriver.Chrome("C:/Users/82105/Downloads/chromedriver_win32/chromedriver.exe")
    driver.get(url_list[i])   # 글 띄우기
    
    
    # 크롤링
    
    try : 
        # iframe 접근
        driver.switch_to_frame('mainFrame')

        target_info = {}

        # 제목 크롤링 시작
        overlays = ".se-fs-.se-ff-"                                 
        tit = driver.find_element_by_css_selector(overlays)         # title
        title = tit.text
        title

        # 글쓴이 크롤링 시작
        overlays = ".nick"                                 
        nick = driver.find_element_by_css_selector(overlays)         # nick
        nickname = nick.text
       # 날짜 크롤링
        overlays = ".se_publishDate.pcol2"                                 
        date = driver.find_element_by_css_selector(overlays)         # date
        datetime = date.text

        # 내용 크롤링
        overlays = ".se-component.se-text.se-l-default"                                 
        contents = driver.find_elements_by_css_selector(overlays)         # content

        content_list = []
        for content in contents:
            content_list.append(content.text)

        content_str = ' '.join(content_list)

        # 글 하나는 target_info라는 딕셔너리에 담기게 되고,
        target_info['title'] = title
        target_info['nickname'] = nickname
        target_info['datetime'] = datetime
        target_info['content'] = content_str
        
        # 각각의 글은 dict라는 딕셔너리에 담기게 됩니다.
        dict[i] = target_info
        time.sleep(1)
        
        print(i, title)

        # 글 하나 크롤링 후 크롬 창 닫기
        driver.close()       
    
    # 에러나면 다음 글(i+1)로 이동
    except:
        driver.close()
#        print("에러나는 글: " + i + ", " + title)
        continue

print('수집한 글 갯수: ', len(dict))
print(dict)    
    
# 데이터 프레임으로 만들기
import pandas as pd
result_df = pd.DataFrame.from_dict(dict, 'index')

# 저장하기
result_df.to_excel("C:/Users/82105/Desktop/data/네이버블로그_본문전체_크롤링/경기도_양주시_4.xlsx")



#########2. 네이버 블로그 텍스트 전처리 1차(python)##############
import os

path = 'C:/Users/82105/Desktop/data/네이버블로그_크롤링/서울특별시/'
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

#지역별 텍스트 불러오기 
f = open('C:/Users/82105/Desktop/data/네이버블로그_크롤링/서울특별시/중랑구.txt', 'r', encoding = 'utf-8')
txt = f.readlines()
f.close() 


# 텍스트 데이터 전처리 함수
import re
def clean_str(text):
    pattern = '([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)' # E-mail제거
    text = re.sub(pattern=pattern, repl='', string=text)
    pattern = '(http|ftp|https)://(?:[-\w.]|(?:%[\da-fA-F]{2}))+' # URL제거
    text = re.sub(pattern=pattern, repl='', string=text)
    pattern = '([ㄱ-ㅎㅏ-ㅣ]+)'  # 한글 자음, 모음 제거
    text = re.sub(pattern=pattern, repl='', string=text)
    pattern = '<[^>]*>'         # HTML 태그 제거
    text = re.sub(pattern=pattern, repl='', string=text)
    pattern = '[^\w\s]'         # 특수기호제거
    text = re.sub(pattern=pattern, repl='', string=text)
    pattern = '[0-9]+'          # 숫자제거
    text = re.sub(pattern=pattern, repl='', string=text)
    return text   


# 텍스트 데이터 전처리 함수 적용
clean_txt = []
for i in range(len(txt)):
    clean_txt.append(clean_str(txt[i]))


# 명사 찾는 함수 만들기(Kkma 클래스 이용)
from konlpy.tag import Kkma
kkma = Kkma()
def find_noun(txt):
    noun_list = []
    for i in txt:
        nouns = kkma.nouns(i)
        for noun in nouns:
            noun_list.append(noun)
    return noun_list

noun_list = find_noun(clean_txt)


#한글자 명사 제거 
noun_f_list = []
for i,v in enumerate(noun_list):
    if len(v)>=2:
        text2 = noun_list.pop(i)
        noun_f_list.append(text2)


# 불용어 사전 만들기 (지역 관광 특성을 나타내지 않는 명사, 지역명과 같은 고유명사 포함)
stop_word = '울릉도 독도 북도 남도 있음 주소 위치 여행 관광 번호 영업 시간 지역 계획 관리 이번 가성 강릉여행 강원도여행 댓글 도착 영업시간 우리 전화번호 다음 주차장 안녕 한번 포스팅 번째 정도 하나 소개 여기 최대 리뷰 투어 공유 이웃신청 첫날 나라 지방 홈페이지 아 휴 아이구 아이쿠 아이고 어 나 우리 저희 따라 의해 을 를 에 의 가 으로 로 에게 뿐이다 의거하여 근거하여 입각하여 기준으로 예하면 예를 들면 예를 들자면 저 소인 소생 저희 지말고 하지마 하지마라 다른 물론 또한 그리고 비길수 없다 해서는 안된다 뿐만 아니라 만이 아니다 만은 아니다 막론하고 관계없이 그치지 않다 그러나 그런데 하지만 든간에 논하지 않다 따지지 않다 설사 비록 더라도 아니면 만 못하다 하는 편이 낫다 불문하고 향하여 향해서 향하다 쪽으로 틈타 이용하여 타다 오르다 제외하고 이 외에 이 밖에 하여야 비로소 한다면 몰라도 외에도 이곳 여기 부터 기점으로 따라서 할 생각이다 하려고하다 이리하여 그리하여 그렇게 함으로써 하지만 일때 할때 앞에서 중에서 보는데서 으로써 로써 까지 해야한다 일것이다 반드시 할줄알다 할수있다 할수있어 임에 틀림없다 한다면 등 등등 제 겨우 단지 다만 할뿐 딩동 댕그 대해서 대하여 대하면 훨씬 얼마나 얼마만큼 얼마큼 남짓 여 얼마간 약간 다소 좀 조금 다수 몇 얼마 지만 하물며 또한 그러나 그렇지만 하지만 이외에도 대해 말하자면 뿐이다 다음에 반대로 반대로 말하자면 이와 반대로 바꾸어서 말하면 바꾸어서 한다면 만약 그렇지않으면 까악 툭 딱 삐걱거리다 보드득 비걱거리다 꽈당 응당 해야한다 에 가서 각 각각 여러분 각종 각자 제각기 하도록하다 와 과 그러므로 그래서 고로 한 까닭에 하기 때문에 거니와 이지만 대하여 관하여 관한 과연 실로 아니나다를가 생각한대로 진짜로 한적이있다 하곤하였다 하 하하 허허 아하 거바 와 오 왜 어째서 무엇때문에 어찌 하겠는가 무슨 어디 어느곳 더군다나 하물며 더욱이는 어느때 언제 야 이봐 어이 여보시오 흐흐 흥 휴 헉헉 헐떡헐떡 영차 여차 어기여차 끙끙 아야 앗 아야 콸콸 졸졸 좍좍 뚝뚝 주룩주룩 솨 우르르 그래도 또 그리고 바꾸어말하면 바꾸어말하자면 혹은 혹시 답다 및 그에 따르는 때가 되어 즉 지든지 설령 가령 하더라도 할지라도 일지라도 지든지 몇 거의 하마터면 인젠 이젠 된바에야 된이상 만큼 어찌됏든 그위에 게다가 점에서 보아 비추어 보아 고려하면 하게될것이다 일것이다 비교적 좀 보다더 비하면 시키다 하게하다 할만하다 의해서 연이서 이어서 잇따라 뒤따라 뒤이어 결국 의지하여 기대여 통하여 자마자 더욱더 불구하고 얼마든지 마음대로 주저하지 않고 곧 즉시 바로 당장 하자마자 밖에 안된다 하면된다 그래 그렇지 요컨대 다시 말하자면 바꿔 말하면 즉 구체적으로 말하자면 시작하여 시초에 이상 허 헉 허걱 바와같이 해도좋다 해도된다 게다가 더구나 하물며 와르르 팍 퍽 펄렁 동안 이래 하고있었다 이었다 에서 로부터 까지 예하면 했어요 해요 함께 같이 더불어 마저 마저도 양자 모두 습니다 가까스로 하려고하다 즈음하여 다른 다른 방면으로 해봐요 습니까 했어요 말할것도 없고 무릎쓰고 개의치않고 하는것만 못하다 하는것이 낫다 매 매번 들 모 어느것 어느 로써 갖고말하자면 어디 어느쪽 어느것 어느해 어느 년도 라 해도 언젠가 어떤것 어느것 저기 저쪽 저것 그때 그럼 그러면 요만한걸 그래 그때 저것만큼 그저 이르기까지 할 줄 안다 할 힘이 있다 너 너희 당신 어찌 설마 차라리 할지언정 할지라도 할망정 할지언정 구토하다 게우다 토하다 메쓰겁다 옆사람 퉤 쳇 의거하여 근거하여 의해 따라 힘입어 그 다음 버금 두번째로 기타 첫번째로 나머지는 그중에서 견지에서 형식으로 쓰여 입장에서 위해서 단지 의해되다 하도록시키다 뿐만아니라 반대로 전후 전자 앞의것 잠시 잠깐 하면서 그렇지만 다음에 그러한즉 그런즉 남들 아무거나 어찌하든지 같다 비슷하다 예컨대 이럴정도로 어떻게 만약 만일 위에서 서술한바와같이 인 듯하다 하지 않는다면 만약에 무엇 무슨 어느 어떤 아래윗 조차 한데 그럼에도 불구하고 여전히 심지어 까지도 조차도 하지 않도록 않기 위하여 때 시각 무렵 시간 동안 어때 어떠한 하여금 네 예 우선 누구 누가 알겠는가 아무도 줄은모른다 줄은 몰랏다 하는 김에 겸사겸사 하는바 그런 까닭에 한 이유는 그러니 그러니까 때문에 그 너희 그들 너희들 타인 것 것들 너 위하여 공동으로 동시에 하기 위하여 어찌하여 무엇때문에 붕붕 윙윙 나 우리 엉엉 휘익 윙윙 오호 아하 어쨋든 만 못하다 하기보다는 차라리 하는 편이 낫다 흐흐 놀라다 상대적으로 말하자면 마치 아니라면 쉿 그렇지 않으면 그렇지 않다면 안 그러면 아니었다면 하든지 아니면 이라면 좋아 알았어 하는것도 그만이다 어쩔수 없다 하나 일 일반적으로 일단 한켠으로는 오자마자 이렇게되면 이와같다면 전부 한마디 한항목 근거로 하기에 아울러 하지 않도록 않기 위해서 이르기까지 이 되다 로 인하여 까닭으로 이유만으로 이로 인하여 그래서 이 때문에 그러므로 그런 까닭에 알 수 있다 결론을 낼 수 있다 으로 인하여 있다 어떤것 관계가 있다 관련이 있다 연관되다 어떤것들 에 대해 이리하여 그리하여 여부 하기보다는 하느니 하면 할수록 운운 이러이러하다 하구나 하도다 다시말하면 다음으로 에 있다 에 달려 있다 우리 우리들 오히려 하기는한데 어떻게 어떻해 어찌됏어 어때 어째서 본대로 자 이 이쪽 여기 이것 이번 이렇게말하자면 이런 이러한 이와 같은 요만큼 요만한 것 얼마 안 되는 것 이만큼 이 정도의 이렇게 많은 것 이와 같다 이때 이렇구나 것과 같이 끼익 삐걱 따위 와 같은 사람들 부류의 사람들 왜냐하면 중의하나 오직 오로지 에 한하다 하기만 하면 도착하다 까지 미치다 도달하다 정도에 이르다 할 지경이다 결과에 이르다 관해서는 여러분 하고 있다 한 후 혼자 자기 자기집 자신 우에 종합한것과같이 총적으로 보면 총적으로 말하면 총적으로 대로 하다 으로서 참 그만이다 할 따름이다 쿵 탕탕 쾅쾅 둥둥 봐 봐라 아이야 아니 와아 응 아이 참나 년 월 일 령 영 일 이 삼 사 오 육 륙 칠 팔 구 이천육 이천칠 이천팔 이천구 하나 둘 셋 넷 다섯 여섯 일곱 여덟 아홉 령 영 이 있 하 것 들 그 되 수 이 보 않 없 나 사람 주 아니 등 같 우리 때 년 가 한 지 대하 오 말 일 그렇 위하 때문 그것 두 말하 알 그러나 받 못하 일 그런 또 문제 더 사회 많 그리고 좋 크 따르 중 나오 가지 씨 시키 만들 지금 생각하 그러 속 하나 집 살 모르 적 월 데 자신 안 어떤 내 내 경우 명 생각 시간 그녀 다시 이런 앞 보이 번 나 다른 어떻 여자 개 전 들 사실 이렇 점 싶 말 정도 좀 원 잘 통하 놓'
st_ls = stop_word.split(' ')

stop_word_region = '서울특별시 서울시 서울 종로구 중구 용산구 성동구 광진구 동대문구 중랑구 성북구 강북구 도봉구 노원구 은평구 서대문구 마포구 양천구 강서구 구로구 금천구 영등포구 동작구 관악구 서초구 강남구 송파구 강동구 서울여행 서울시여행 서울특별시여행 종로 용산 성동 광진 중랑 성북 강북 도봉 노원 은평 마포 양천 강서 구로 금천 영등포 동작 관악 서초 강남 송파 강동 부산광역시 부산시 부산 중구 서구 동구 영도구 부산진구 동래구 남구 북구 해운대구 사하구 금정구 강서구 연제구 수영구 사상구 기장군 부산여행 부산광역시여행 부산시여행 영도 부산진 동래 사하 금정 연제 사상 기장 해운대 대구광역시 대구시 대구 수성구 달서구 달성군 수성 달서 달성 대구여행 대구광역시여행 대구시여행 인천광역시 인천시 인천 미추홀구 연수구 남동구 부평구 계양구 강화군 옹진군 인천여행 인천광역시여행 인천시여행 미추홀 연수 남동 부평 계양 강화 옹진 대전광역시 대전시 대전 유성구 대덕구 유성 대덕 대전여행 대전광역시여행 대전시여행 울산광역시 울산시 울산 울주군 울주 울산여행 울산광역시여행 울산시여행 광주광역시 광주시 광주 광산구 광산 광주여행 광주광역시 여행 광주시여행 강원도 강원 강릉시 동해시 삼척시 속초시 원주시 춘천시 태백시 고성군 양구군 양양군 영월군 인제군 정선군 철원군 평창군 홍천군 화천군 횡성군 강릉 삼척 속초 원주 춘천 태백 고성 양구 양양 영월 인제 정선 철원 평창 홍천 화천 횡성 강원도여행 강원여행 충청북 충청북도 충청도 충청 충북 제천 청주 충주 제천시 청주시 충주시 충청도여행 충청여행 충북여행 충남여행 충청북도여행 충청남도여행 괴산군 단양군 보은군 영동군 옥천군 음성군 증평군 진천군 괴산 단양 보은 영동 옥천 음성 증평 진천 충청남도 충청북 충청남 충남 계룡시 공주시 논산시 당진시 보령시 서산시 아산시 천안시 계룡 공주 논산 당진 보령 서산 아산 천안 금산군 부여군 서천군 예산군 청양군 태안군 홍성군 금산 부여 서천 예산 청양 태안 홍성 경기도 경기 고양시 과천시 광명시 광주시 구리시 군포시 김포시 남양주시 동두천시 부천시 성남시 수원시 시흥시 안산시 안성시 안양시 양주시 여주시 오산시 용인시 의왕시 의정부시 이천시 파주시 평택시 포천시 하남시 화성시 가평군 양평군 연천군 경기도여행 경기여행 고양 과천 광명 구리 군포 김포 남양주 동두천 부천 성남 수원 시흥 안산 안성 안양 양주 여주 오산 용인 의왕 의정부 이천 파주 평택 포천 하남 화성 가평 양평 연천 경상남도 경상도 경상 경남 경남여행 경상여행 경상도여행 경상남도여행 경상북도여행 경상북 경상남 거제시 김해시 밀양시 사천시 양산시 진주시 창원시 통영시 거제 김해 밀양 사천 양산 진주 창원 통영 거창군 고성군 남해군 산청군 의령군 창녕군 하동군 함안군 함양군 합천군 거창 고성 산청 의령 창녕 하동 함안 함양 합천 경상북도 경북 경북여행 경산시 경주시 구미시 김천시 문경시 상주시 안동시 영주시 영천시 포항시 경산 경주 구미 김천 문경 상주 안동 영주 영천 포항 고령군 군위군 봉화군 성주군 영덕군 영양군 예천군 울릉군 울진군 의성군 청도군 청송군 칠곡군 고령 군위 봉화 성주 영덕 영양 예천 울릉 울진 의성 청도 청송 칠곡 전라남도 전라도 전남 전라 광양시 나주시 목포시 순천시 여수시 광양 나주 목포 순천 여수 전라여행 전라도여행 전라북도여행 전라남도여행 전라남 전라북 전남여행 전북여행 강진군 고흥군 곡성군 구례군 담양군 무안군 보성군 신안군 영광군 영암군 강진 고흥 곡성 구례 담양 무안 보성 신안 영광 영암 완도군 장성군 장흥군 진도군 함평군 해남군 화순군 완도 장성 장흥 진도 함평 해남 화순 전라북도 전북 군산시 김제시 남원시 익산시 전주시 정읍시 군산 김제 남원 익산 전주 정읍 고창군 무주군 부안군 순창군 완주군 임실군 장수군 진안군 고창 무주 부안 순창 완주 임실 장수 진안'
st_ls2 = stop_word_region.split(' ')

st_ls.extend(st_ls2)


# 불용어 제거 
fffnal_ls = []
for word in noun_f_list:
    if word not in st_ls:
        fffnal_ls.append(word)
final = ' '.join(fffnal_ls)


# 1차 전처리 후 저장
f = open("C:/Users/82105/Desktop/지자체/서울특별시/중랑구.txt", 'w', encoding="UTF8")
f.write(final)
f.close()



#########3. 네이버 블로그 텍스트 전처리 2차(python)############## (지역명을 포함하는 명사 모두 제거)
import os
import pandas as pd 

path = 'C:/Users/82105/Desktop/지자체/서울특별시/'
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] #해당 폴더에 있는 모든 txt 파일 불러오기

file_list_py 


# 폴더에 있는 txt 파일 내용 저장 자동화
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    #globals()['variable{}'.format(i)] = globals()['variable{}'.format(i)].split()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])


# 불용어 제거 (지역명 포함 단어 모두 삭제)
import re
def clean_str(text):
    
    pattern = '특별|여행|관광|서울|종로|용산|성동|광진|중랑|성북|세종|제주|서귀포|강북|도봉|노원|은평|마포|양천|강서|구로|금천|영등포|동작|관악|서초|강남|송파|강동|부산|중구|서구|동구|부산진|동래|사하|금정|연제|사상|기장|해운대구|대구|수성|달서|달성|인천|미추홀|연수|남동|부평|계양|강화|옹진|대전|유성|대덕|울산|울주|광주|광산|강원|강릉|삼척|속초|원주|춘천|태백|고성|양구|양양|영월|인제|정선|철원|평창|홍천|화천|횡성|충청|충북|제천|청주|충주|충남|괴산|단양|보은|영동|옥천|음성|증평|진천|충청남도|계룡|공주|논산|당진|보령|서산|아산|천안|금산|부여|서천|예산|청양|태안|홍성|경기|고양|과천|광명|구리|군포|김포|남양주|동두천|부천|성남|수원|시흥|안산|안성|안양|양주|여주|오산|용인|의왕|의정부|이천|파주|평택|포천|하남|화성|가평|양평|연천|경상|경남|경북|거제|김해|밀양|사천|양산|진주|창원|통영|거창|고성|산청|의령|창녕|하동|함안|함양|합천|경상북도|경산|경주|구미|김천|문경|상주|안동|영주|영천|포항|고령|군위|봉화|성주|영덕|영양|예천|울릉|울진|의성|청도|청송|칠곡|전라|전남|광양|나주|목포|순천|여수|전북|강진|고흥|곡성|구례|담양|무안|보성|신안|영광|영암|완도|장성|장흥|진도|함평|해남|화순|전북|군산|김제|남원|익산|전주|정읍|고창|무주|부안|순창|완주|임실|장수|진안|울릉도|독도|북도|남도|있음|주소|위치|여행|관광|번호|영업|시간|지역|계획|관리|이번|가성|댓글|도착|우리|다음|주차|안녕|한번|포스팅|번째|정도|하나|소개|여기|최대|리뷰|오늘|투어|공유|이웃신청|첫날|나라|지방|홈페이지|저희'
    text = re.sub(pattern=pattern, repl='', string=text)
    
    return text   


vars_clean = []
for i in range(len(file_list_py)):
    vars_clean.append(clean_str(vars[i]))

for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = vars_clean[i].split()


# 한글자 단어 제거 함수
def find_noun(nouns):
    noun_list=[]
    for j,v in enumerate(nouns):
        if len(v)>=2:
            nouns2 = nouns.pop(j)
            noun_list.append(nouns2)
            
    return noun_list

for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = find_noun(globals()['variable{}'.format(i)])

vars_noun = []
for i in range(len(file_list_py)):
   
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars_noun.append(globals()['variable{}'.format(i)])
    

# 2차 전처리 후 txt파일로 저장
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/서울특별시/'

for i in range(len(file_list_py)):
    open(path+file_list_py[i], 'w',encoding = 'utf-8').write(vars_noun[i])  

