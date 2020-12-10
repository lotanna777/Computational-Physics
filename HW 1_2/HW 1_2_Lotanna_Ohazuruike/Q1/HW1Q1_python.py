#!/usr/bin/env python
# coding: utf-8

# In[21]:


import math
import matplotlib.pyplot as plt

t = 2;
# Functions
def x_t(t):
    x=1/(1+9*math.exp(-t));
    return x

def x_t_prime(t):
    xprime=9*math.exp(-t)/(1+9*math.exp(-t))**2;
    return xprime

# Main loop
nmax=10;
del_dt_mat = [0]*nmax;
for n in range(1,nmax):                           # run for different values of n
    del_t = 10^-n;
    x1 = x_t(t);                                # computes x at current time
    x2 = x_t(t + del_t);                        # computes x at next time
    xprime = x_t_prime(t);                      # computes exact value of differential x

    del_dt = math.fabs(xprime-(x2-x1)/del_t);         # difference between exact and numerical 

    del_dt_mat[n] = del_dt;                     # save results to a vector

print(del_dt_mat)
ax = plt.loglog(del_dt_mat)  # Create a figure and an axes.
plt.xlabel('n')  # Add an x-label to the axes.
plt.ylabel('del dt')  # Add a y-label to the axes.
plt.title("Difference between exact and numerical solution")  # Add a title to the axes.
plt.savefig('Q1_python.png')


# In[ ]:





# In[ ]:




