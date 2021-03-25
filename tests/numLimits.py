#!/usr/bin/env python3
import numpy as np
import math
import scipy.special as sps
import scipy as sp

N = 1001

for i in range(N):
    try:
        x = 1.0*math.factorial(i)
    except:
        print('math.factorial failed to convert to float at i=',i)
        raise

print('done')
