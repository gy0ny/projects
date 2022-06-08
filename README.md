## Projects
## **1. 2021 문화관광 빅데이터 분석대회 (최우수상)** 
: '서울말고 다른곳은 어때?'

 **대회 주제** 
 
코로나 19 이후, 뉴 노멀(New Normal)시대의 문화 관광

**분석 주제** 

국내의 숨은 관광 명소를 도출하여 방한 외래 관광객에게의 분산 관광을 제안하여 수도권 중심의 오버 투어리즘 문제를 해결할 뿐 아니라 높은 인구 밀집도에 따른 감염 위험 문제를 해결하고자 함

**사용 데이터**

네이버 블로그 본문 텍스트 데이터, 신한카드 데이터, 기초지자체별 방문자수 데이터(관광 데이터랩)

**분석 방향**  

해결방안으로 네이버 블로그 본문 텍스트 데이터와 신한카드 데이터를 활용하여 유사한 특징과 소비 특성을 가진 지역을 군집화하고, 숨은 명소지수와 감성점수를 산출해 통해 각 군집별 관광만족도가 높은 숨은 명소를 채택하여 정책을 제시

**사용된 분석 기술 및 라이브러리**

1) 네이버블로그 텍스트 데이터의 전처리 과정
- 형태소 분석기(Kkma)를 활용한 명사추출, 불용어 제거, TF-IDF화 
2) 텍스트 데이터 Soft Clustering (수치형데이터와 병합하기 위한 전처리 과정)
3) 수치형데이터(신한카드 업종별 매출 데이터)와 병합 후 K-medoids Clustering
4) 파생변수 생성 - 숨은 명소지수
- 신한카드 내국인 데이터(2019) → 외지인 수를 현지인 수로 나눈 ratio_ex_in(=외지인 수/현지인 수) 변수
- 한국 관광데이터랩 기초 지자체 방문자수 데이터 → 외국인수를 외지인수로 나눈 ratio_visit (=외국인수/외지인수) 변수
    ⇒ 두 변수를 PCA를 이용하여 하나의 변수로 축소 
5) 네이버블로그 텍스트 데이터의 감성분석을 통한 감성점수 부여

<br/><br/>

## **2. 2021 빅콘테스트**
: 댐 유입수량 예측을 통한 최적 유입량 예측

**대회 주제** 

최근 10년간 발생했던 홍수사상을 대상으로 유입량에 영향을 미치는 관측소의 강우량 및 수위 데이터를 학습하여 홍수사상 26의 댐 유입 수량 예측

**사용 데이터**

데이터 집단별 A,B,C 지역 관측소의 강우량 및 수위 데이터

**분석 방향**  

1) 각 시점을 독립으로 간주하여 여러 머신러닝 모형 적용 
2) 시계열성을 고려하여 LSTM 적용  

**사용된 분석 기술 및 라이브러리**

1) 데이터 길이를 동일하게하여 LSTM 모델에 적용하기 위해 zero-masking
2) Tensorflow의 keras를 이용한 LSTM 모형 적용
3) scikit-learn을 이용해 Decision Tree, RandomForest, XGBoost, LightGBM 모형 적용 및 튜닝

<br/><br/>

## **3. 교통·문화·통신 빅데이터 플랫폼 융합 분석 경진대회 (최우수상)**
: 'Fun, Cool, Safety in 강릉'

**대회 주제** 

교통/문화/통신 기반의 지역 경제 활성화를 위해 제시된 빅데이터를 분석

**분석 주제** 

코로나 여행 트렌드 ‘S.A.F.E.T.Y’에 맞춰 강릉시를 타겟으로 한 관광 리브랜딩 방안 제시

**사용 데이터**

KORAIL 데이터, KT데이터, 한국문화원 데이터, 네이버카페 크롤링 데이터 등

**분석 방향**  

교통, 통신, 문화 데이터 시각화를 이용해 ‘S.A.F.E.T.Y’에 맞는 관광지역 색출 후 해당 지역(강릉)의 관광 현황 시각화 및 문제 상황 도출, 해결방안 제시

**사용된 분석 기술 및 라이브러리**
1) 태블로를 이용해 시각화 및 대시보드 생성
2) 네이버 카페 텍스트 크롤링, 워드 클라우드 생성
3) Python matplotlib 활용해 EDA

<br/><br/>

## **4-1. 자료분석특론 personal project** 
: Animal Image Classification using Convolution Model

**프로젝트 주제** 

다양한 CNN 모델을 훈련시켜 Animal Image 분류 최적 모델 찾기

**사용 데이터**

Kaggle의 Animal Image dataset

**프로젝트 방향**  

CNN, Resnet, Mobilenet 모델의 성능 비교

**사용된 분석 기술 및 라이브러리**

1) Keras를 이용하여 CNN 모형 구현 및 적용
2) Resnet, Mobilenet 사전학습망 모형 적용

<br/>

## **4-2.자료분석특론 personal project** 
: Wine review point 예측

**프로젝트 주제** 

Categorical 변수들을 고려하여 최적 예측 모델 찾기

**사용 데이터**

Kaggle의 Animal Image dataset

**프로젝트 방향**  

트리 기반 앙상블 모델들의 성능 비교

**사용된 분석 기술 및 라이브러리**

1) scikit-learn를 이용하여 Randomforest, Catboost, Lightgbm 적용
2) scikit-learn Gridsearch 이용하여 하이퍼 파라미터 튜닝

<br/><br/>

## **5. 계산특론 Team project**
: 8-Queens Problem using Genetic Algorithm

**프로젝트 주제** 

Genetic Algorithm을 이용해 8*8 체스보드에 서로 공격하지 않는 Queen을 두는 방법 92가지를 찾는 논문 구현

**구현 논문**

Farhan, Ahmed & Tareq, Wadhah & Awad, Fouad. (2015). Solving N Queen Problem using
Genetic Algorithm. International Journal of Computer Applications. 122. 11-14.10.5120/21750-5005.

**프로젝트 방향**  

논문에서 제시한 세가지 crossover 방법들의 genetic algorithm을 구현하고 각 방법들의 computational time과 iteration을 비교한다.

**사용된 분석 기술 및 라이브러리**

1) 논문에서 제시한 3-way tournament 방법에 대해 직접 R로 구현
2) OX crossover, PMX crossover 방법에 대해 R의 GA 패키지 이용

<br/><br/>

## **6. 일반화선형모형 Team project**
:Garbage Classification with Resnet model

**프로젝트 주제** 

다양한 깊이의 ResNet 모델을 훈련시켜 쓰레기 이미지 분류 최적 모델 찾기

**사용 데이터**

Kaggle의 Garbage Classification[3]과 모바일 환경에서 촬영한 이미지 파일

**프로젝트 방향**  

Resnet 논문의 코드를 구현하여 Resnet18 모델을 적용하고 torch에서 제공하는 사전학습망 모델과 비교, 더 깊은 Resnet 사전학습망 모델들(Resnet34, 50, 101, 152)의 성능 비교

**사용된 분석 기술 및 라이브러리**

1) Pytorch를 이용하여 Resnet 18 모형 구현 및 적용
2) torch에서 제공하는 사전학습망 모형 적용

<br/><br/>

## **7. [포스터논문]Heart rate variability enhances the EEG-based machine learning prediction of Internet gaming disorder (최우수상)**
(한국데이터정보과학회 포스터 논문 발표)

**분석 주제** 

HRV 데이터를 이용한 IGD 분류 성능 개선

**사용 데이터**

EEG, HRV data Collected from SMG-SNU Boramae Medical Center

**분석 방향**  

뇌파 데이터인 EEG와 심박변이도 데이터인 HRV, 두 가지의 데이터로 알코올중독, 인터넷게임중독, 정상군을 분류하는 분석을 진행. 데이터의 차원이 크다는 점을 고려하여  iterative sure independence screening 방법을 적용

**사용된 분석 기술 및 라이브러리**

1) ISIS (R SIS Package)
2) SIS for multiple classes → R을 이용하여 직접 구현 
3) Random Forest, Gradient Boosting, XGBoost, Elastic Net 모델 적용 및 튜닝
4) SHAP value for measuring feature importance

