# -*- coding: utf-8 -*-
"""
Created on Sun May 22 22:25:38 2022

@author: amy71
"""

######## 텍스트 clustering ##############

#변수로 사용할 영어, 한글 지역명 가져오기 

import pandas as pd

region_name = pd.read_csv('C:/Users/82105/Desktop/data/지역명 한글.csv', encoding="utf-8")
region_name

#강원도

# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/강원도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])


gangwon = region_name['region'][0:18]
gangwon = gangwon.tolist()


# dictionary에 지역명은 key값, 명사 키워드는 value값으로 할당
reg1 = {}
for i in range(len(vars)):
    reg1[gangwon[i]] = vars[i]
reg1


# 경기도
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/경기도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

gyeonggi = region_name['region'][18:49]
gyeonggi = gyeonggi.tolist()

reg2 = {}
for i in range(len(vars)):
    reg2[gyeonggi[i]] = vars[i]


#경상남도

import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/경상남도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

gyeongnam = region_name['region'][49:67]
gyeongnam = gyeongnam.tolist()

reg3= {}
for i in range(len(vars)):
    reg3[gyeongnam[i]] = vars[i]


# 경상북도

import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/경상북도/'
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

gyeongbuk = region_name['region'][67:90]
gyeongbuk = gyeongbuk.tolist()

reg4= {}
for i in range(len(vars)):
    reg4[gyeongbuk[i]] = vars[i]

#광주광역시

# 텍스트 파일 불러오기

import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/광주광역시/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])


gwangju = region_name['region'][90:95]
gwangju = gwangju.tolist()
gwangju

reg5= {}
for i in range(len(vars)):
    reg5[gwangju[i]] = vars[i]

# 대구광역시

# 텍스트 파일 불러오기

import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/대구광역시/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

daegu = region_name['region'][95:103]
daegu = daegu.tolist()
daegu

reg6= {}
for i in range(len(vars)):
    reg6[daegu[i]] = vars[i]

# 대전광역시
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/대전광역시/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

daejeon = region_name['region'][103:108]
daejeon = daejeon.tolist()
daejeon

reg7= {}
for i in range(len(vars)):
    reg7[daejeon[i]] = vars[i]

# 부산광역시
# 텍스트 파일 불러오기

import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/부산광역시/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])
busan = region_name['region'][108:124]
busan = busan.tolist()
busan

reg8= {}
for i in range(len(vars)):
    reg8[busan[i]] = vars[i]


# 서울특별시
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/서울특별시/' 
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

seoul = region_name['region'][124:149]
seoul = seoul.tolist()
seoul

reg9= {}
for i in range(len(vars)):
    reg9[seoul[i]] = vars[i]

# 세종특별자치시
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/세종특별자치시/' 
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])
sejong = region_name['region'][149]

sejong


reg10= {}
for i in range(len(vars)):
    reg10[sejong] = vars[i]

# 울산광역시
# 텍스트 파일 불러오기

import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/울산광역시/' 
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

ulsan = region_name['region'][150:155]
ulsan = ulsan.tolist()
ulsan


reg11 = {}
for i in range(len(vars)):
    reg11[ulsan[i]] = vars[i]


# 인천광역시
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/인천광역시/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

incheon = region_name['region'][155:165]
incheon = incheon.tolist()
incheon


reg12 = {}
for i in range(len(vars)):
    reg12[incheon[i]] = vars[i]


# 전라남도
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/전라남도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

jeonnam = region_name['region'][165:187]
jeonnam = jeonnam.tolist()
jeonnam


reg13 = {}
for i in range(len(vars)):
    reg13[jeonnam[i]] = vars[i]


# 전라북도
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/전라북도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

jeonbuk = region_name['region'][187:201]
jeonbuk = jeonbuk.tolist()
jeonbuk


reg14 = {}
for i in range(len(vars)):
    reg14[jeonbuk[i]] = vars[i]

# 제주특별자치도
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/제주특별자치도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])


jeju = region_name['region'][201:203]
jeju = jeju.tolist()
jeju


reg15 = {}
for i in range(len(vars)):
    reg15[jeju[i]] = vars[i]


# 충청남도
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/충청남도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py


# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])


chungnam = region_name['region'][203:218]
chungnam = chungnam.tolist()
chungnam



reg16 = {}
for i in range(len(vars)):
    reg16[chungnam[i]] = vars[i]


# 충청북도
# 텍스트 파일 불러오기
import os
path = 'C:/Users/82105/Desktop/텍스트 전처리_2차_최종/noun_keyword/충청북도/' # 여행 부분만 바꿔주기
file_list = os.listdir(path)
file_list_py = [file for file in file_list if file.endswith('.txt')] 

file_list_py

# 각 텍스트 파일 불러오기
vars = []
for i in range(len(file_list_py)):
    globals()['variable{}'.format(i)] = open(path + file_list_py[i], 'r', encoding = 'utf-8').readlines()
    globals()['variable{}'.format(i)] = ' '.join(globals()['variable{}'.format(i)])
    vars.append(globals()['variable{}'.format(i)])

chungbuk = region_name['region'][218:229]
chungbuk = chungbuk.tolist()
chungbuk

reg17 = {}
for i in range(len(vars)):
    reg17[chungbuk[i]] = vars[i]

#딕셔너리 합치기

reg1.update(reg2)
reg1.update(reg3)
reg1.update(reg4)
reg1.update(reg5)
reg1.update(reg6)
reg1.update(reg7)
reg1.update(reg8)
reg1.update(reg9)
reg1.update(reg10)
reg1.update(reg11)
reg1.update(reg12)
reg1.update(reg13)
reg1.update(reg14)
reg1.update(reg15)
reg1.update(reg16)
reg1.update(reg17)
final = reg1

# 총 개수 확인
len(final)


region = []
info = []
for key in final.keys():
    region.append(key)
for value in final.values():
    info.append(value)

#TF-IDF 벡터화

from sklearn.feature_extraction.text import TfidfVectorizer
tfidf_vectorizer = TfidfVectorizer() # TF-IDF 만드는 모델
tfidf_vectorizer.fit(info) # 전체 문서인 info를 모델에 적용

# 모든 지역을 벡터화 시킴
tfidf_vect = tfidf_vectorizer.transform(info).toarray()
tfidf_vect


data_df = pd.DataFrame(tfidf_vect)
data_df


#####  지역별 클러스터링 (1차)
# K-Means
from sklearn.cluster import KMeans

import pandas as pd
import numpy as np
import tensorflow as tf
import seaborn as sns
import matplotlib.pyplot as plt

%matplotlib inline
# k-means 클러스터링 모델 생성
model = KMeans(n_clusters = 8, max_iter = 1000, random_state = 1234)
model.fit(tfidf_vect)
model.fit_predict(tfidf_vect)


pred = model.fit_predict(tfidf_vect)
pred is model.labels_

model.cluster_centers_

a = model.transform(tfidf_vect)
a

transform_data = pd.DataFrame(a, columns = ['c1','c2','c3','c4','c5','c6','c7','c8'])
transform_data

region = pd.DataFrame(region)
region

distance = pd.concat([region_name['region1'], transform_data], axis=1)
distance

#이너셔 시각화
inertia_arr=[]
k_range=range(2,15)

for k in k_range:
    kmedoids=KMedoids(n_clusters=k,random_state=42)
    kmedoids.fit(x_scaled)
    inin=kmedoids.inertia_
    print('k:',k,'inerita:', inin)
    
    inertia_arr.append(inin)
inertia_arr=np.array(inertia_arr)

plt.plot(k_range,inertia_arr)
save_fig('cluster_inertia_elbow')
plt.show()


#실루엣 계수 시각화
from sklearn.metrics import silhouette_score, silhouette_samples
def visualize_silhouette(cluster_lists, X_features): 
    
    from sklearn.datasets import make_blobs
    import matplotlib.cm as cm
    import math
    
    n_cols = len(cluster_lists)
    
    fig, axs = plt.subplots(figsize=(4*n_cols, 4), nrows=1, ncols=n_cols)
    
    for ind, n_cluster in enumerate(cluster_lists):
        
        clusterer = KMedoids(n_clusters = n_cluster, max_iter=500, random_state=0)
        cluster_labels = clusterer.fit_predict(X_features)
        
        sil_avg = silhouette_score(X_features, cluster_labels)
        sil_values = silhouette_samples(X_features, cluster_labels)
        
        y_lower = 10
        axs[ind].set_title('Number of Cluster : '+ str(n_cluster)+'\n' \
                          'Silhouette Score :' + str(round(sil_avg,3)) )
        axs[ind].set_xlabel("The silhouette coefficient values")
        axs[ind].set_ylabel("Cluster label")
        axs[ind].set_xlim([-0.1, 1])
        axs[ind].set_ylim([0, len(X_features) + (n_cluster + 1) * 10])
        axs[ind].set_yticks([])  # Clear the yaxis labels / ticks
        axs[ind].set_xticks([0, 0.2, 0.4, 0.6, 0.8, 1])
        
        for i in range(n_cluster):
            ith_cluster_sil_values = sil_values[cluster_labels==i]
            ith_cluster_sil_values.sort()
            
            size_cluster_i = ith_cluster_sil_values.shape[0]
            y_upper = y_lower + size_cluster_i
            
            color = cm.nipy_spectral(float(i) / n_cluster)
            axs[ind].fill_betweenx(np.arange(y_lower, y_upper), 0, ith_cluster_sil_values, \
                                facecolor=color, edgecolor=color, alpha=0.7)
            axs[ind].text(-0.05, y_lower + 0.5 * size_cluster_i, str(i))
            y_lower = y_upper + 10
            
        axs[ind].axvline(x=sil_avg, color="red", linestyle="--")
    save_fig('silhuette')    
        

def visualize_kmedoids_plot_multi(cluster_lists, X_features):    
    
    n_cols = len(cluster_lists)
    fig, axs = plt.subplots(figsize=(16*n_cols, 16), nrows=1, ncols=n_cols)
    
    pca = PCA(n_components=2)
    pca_transformed = pca.fit_transform(X_features)
    dataframe = pd.DataFrame(pca_transformed, columns=['PCA1','PCA2'])
    
    for ind, n_cluster in enumerate(cluster_lists):
        
        clusterer = KMedoids(n_clusters = n_cluster, max_iter=500, random_state=0)
        cluster_labels = clusterer.fit_predict(pca_transformed)
        dataframe['cluster']=cluster_labels
        
        unique_labels = np.unique(clusterer.labels_)
        markers=['o', 's', '^', 'x', '*','.','1','d',',','v','+','X','D','>','<','2']
       
        for label in unique_labels:
            label_df = dataframe[dataframe['cluster']==label]
            if label == -1:
                cluster_legend = 'Noise'
            else :
                cluster_legend = 'Cluster '+str(label)           
            axs[ind].scatter(x=label_df['PCA1'], y=label_df['PCA2'], s=70,\
                        edgecolor='k', marker=markers[label], label=cluster_legend)

        axs[ind].set_title('Number of Cluster : '+ str(n_cluster))    
        axs[ind].legend(loc='upper right')
    save_fig('clustering_scatter_plot')
    plt.show()

data_features = tfidf_vect

visualize_silhouette([2,3,4,5,6,7,8,9,10],data_features)
visualize_kmeans_plot_multi([2,3,4,5,6,7,8,9,10],data_features)


#군집 평가
import pandas as pd

n_iter_cluster = 20 # 최대 군집 생성 개수
cluster_range = [i+1 for i in range(n_iter_cluster)]
clus_error = []
for v_n_clus in cluster_range:
    clus = KMeans(v_n_clus)
    clus.fit(tfidf_vect)
  # 각 데이터로부터 가장 가까운 군집 중심점까지 거리 제곱합
    clus_error.append(clus.inertia_)
ds_error = pd.DataFrame({"Number of Cluster":cluster_range, "Error":clus_error})
ds_error


# 이너셔- 군집별 군집 중심점까지 거리 제곱합을 시각화
plt.figure(figsize=(10,10))
plt.plot(ds_error["Number of Cluster"], ds_error["Error"])
plt.title("Sum of squared distance")
plt.xlabel("Clusters")
plt.ylabel("Sum of squared distance")


# 어떤 군집으로 분류되었는지 라벨링
model.labels_

name = []
name = model.labels_.tolist()

# name 
df = pd.DataFrame({'region':region_name['region1'],
                   'cluster':name})
df



#####  지역별 클러스터링 (2차)

#필요한 패키지 import 및 install
import matplotlib.pyplot as plt
%matplotlib inline
plt.rcParams['font.family'] = 'NanumGothic'
import json
import numpy as np
from pandas.io.json import json_normalize
import os
import webbrowser
#!pip install folium
import folium
from folium import plugins
print(folium.__version__)
#!pip install scikit-learn-extra
from sklearn_extra.cluster import KMedoids
from sklearn.cluster import KMeans
from sklearn.preprocessing import OneHotEncoder
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import MinMaxScaler

#파일 불러오기
df_t=pd.read_csv("C:\\Users\\SamSung\\tour\\cluster_합1.csv",encoding='utf)
df_t_sc=df_t.copy()

#스케일링
df_t_sc.drop(['v4'],axis=1,inplace=True)
mmscaler = MinMaxScaler()
x_scaled = mmscaler.fit_transform(df_t_sc)
x_scaled=pd.DataFrame(x_scaled,columns=df_t_sc.columns, index=df_t_sc.index)



data_features = x_scaled.values

visualize_silhouette([5,6,7,8,9,10],data_features)
visualize_kmedoids_plot_multi([5,6,7,8,9,10],data_features)

#k=8로 클러스터링
k=8
kmedoids=KMedoids(n_clusters=k,random_state=42)
y_pred_med=kmedoids.fit(df_tt)
x_scaled['cluster_label']=kmedoids.labels_

x_scaled['region']=df_t['v4']
