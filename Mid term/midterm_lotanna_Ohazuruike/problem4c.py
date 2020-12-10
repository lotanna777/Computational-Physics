#!/usr/bin/env python
# coding: utf-8

# In[3]:


import numpy as np
import matplotlib as plt


# In[5]:


n = 10
I = np.identity(n, dtype = None);
#logA = np.zeros(shape=(5,2));
tol = 10**-3;
kmax = 1000;

A = (1 + I)/(n+1);


# In[14]:


k=0;
logA = 0;
#results = np.zeros(shape=(1,2));

var=1;
start=time.time()  #start time
while var==1:
    k = k + 1;
    deltalogA = -((I - A)**k)/k;
    logA = logA + deltalogA ;
      
    if (abs(ele)< tol for ele in deltalogA):
        break

end=time.time();  #end time

savelogA = open("problem 4c py.txt", "w")
# write logA to output file
listToStr = ' '.join([str(elem) for elem in logA]) 
savelogA.write(listToStr)
savelogA.write("\n")
savelogA.close()


# In[ ]:




