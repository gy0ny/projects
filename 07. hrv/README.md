
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

