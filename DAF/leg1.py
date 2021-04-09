#!/usr/bin/python3
import scipy.special as sps
import math
import matplotlib.pyplot as plt
import numpy as np

if (__name__ == '__main__'):
    
    M = 500
    Nray = 11
    Nbar =1001
    Xray = np.linspace(-1,1,Nray)
    Xbar = np.linspace(-1,1,Nbar)

    Pmat = np.zeros((M,Nbar),dtype=np.double)
    dcoef = np.zeros((Nray,M),dtype=np.double)

    for i in range(Nray):
        for m in range(M):
            dcoef[i,m] = sps.eval_legendre(m,Xray[i])*(2*m+1)

    for m in range(M):
        for j in range(Nbar):
            Pmat[m,j] = sps.eval_legendre(m,Xbar[j])
    
    delta = np.zeros((Nray,Nbar),dtype=np.double)
    for i in range(Nray):
        for j in range(Nbar):
            for m in range(M):
                delta[i,j] += dcoef[i,m]*Pmat[m,j]

    for i in range(Nray):
        plt.plot(Xbar,delta[i,:])
    plt.show()
