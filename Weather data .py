#!/usr/bin/env python
# coding: utf-8

# # Weather Data with Python coding 
# ### finding the related answers

# In[1]:


#IMPORTING REQUIRED LIBRARIES
import pandas as pd
import numpy as np


# In[6]:


wea_data = pd.read_csv('Weather Data.csv')
wea_data.head()


# In[44]:


wea_data.info()


# In[72]:


#find all the unique windspeed values in data

ws_uniq=wea_data['Wind Speed_km/h'].unique()
ws_uniq


# In[74]:


#find all the times when the whether is 'exactly clear ' 

Wea_clear = wea_data[wea_data['Weather Condition']== 'Clear'].shape
Wea_clear


# In[75]:


#the correct answer is 
wea_data.groupby('Weather Condition').get_group('Clear')


# In[76]:


#Windspeed is exactly 4kmph
ws_4k = wea_data[wea_data['Wind Speed_km/h']== 4]
ws_4k


# In[46]:


#find out all the null values in the data 
null_val = wea_data.isnull().sum()
null_val


# In[51]:


# Rename the weather to weather condition

#wea_data['Weather Condition'] = wea_data.rename(wea_data['Weather'])
rename_wea = wea_data.rename(columns = {'Weather':'Weather Condition'}, inplace = True)
rename_wea
wea_data


# In[62]:


# What is the mean visibity
mean_vis = wea_data['Visibility_km'].mean()
mean_vis


# In[63]:


#what is the std of Pressure
std_pre = wea_data['Press_kPa'].std()
std_pre


# In[64]:


#what is the variance of 'relative humidity'
from statistics import variance
var_humi = variance(wea_data['Rel Hum_%'])
var_humi


# In[77]:


#find all instances when the snow was recorded 
Wea_snow = wea_data[wea_data['Weather Condition']== 'Snow']
Wea_snow


# In[83]:


#str.contains
wea_data[wea_data['Weather Condition'].str.contains('Snow')].head(50)


# In[84]:


#find the all instance where 'wind speed above 24 and visibility is 25'
ws_vis = wea_data[(wea_data['Wind Speed_km/h'] > 24) & (wea_data['Visibility_km'] == 25)]
ws_vis


# In[112]:


# What is the mean value of each column against each weather condition
mean_all = wea_data.groupby (wea_data['Weather Condition']).mean()
mean_all


# In[113]:


# What is the Minimum & Maximum value of each column against each 'Weather Condition ?
min_all = wea_data.groupby (wea_data['Weather Condition']).min() 
min_all


# In[114]:


max_all = wea_data.groupby (wea_data['Weather Condition']).max() 
max_all


# In[115]:


#13) Show all the Records where Weather Condition is Fog.
wea_data[wea_data['Weather Condition']== 'Fog']


# In[118]:


#14) Find all instances when 'Weather is Clear' or 'Visibility is above 40'.
ws_vs_cle = wea_data[(wea_data['Weather Condition']== 'Clear') | (wea_data['Visibility_km'] > 40)]
ws_vs_cle.head(50)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




