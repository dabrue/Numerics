#!/usr/bin/python3
import scipy.special as sps
import math
import matplotlib.pyplot as plt
import numpy as np


if (__name__ == '__main__'):
    
    M = 1000
    Nray = 9
    Nbar =1001
    Xray = np.linspace(-0.9,0.9,Nray)
    Xbar = np.linspace(-0.99,0.99,Nbar)

    Tmat = np.zeros((M,Nbar),dtype=np.double)
    dcoef = np.zeros((Nray,M),dtype=np.double)

    for i in range(Nray):
        dcoef[i,0] = sps.eval_chebyt(0,Xray[i])/math.pi
        for m in range(1,M):
            dcoef[i,m] = sps.eval_chebyt(m,Xray[i])*2/math.pi

    for m in range(M):
        for j in range(Nbar):
            Tmat[m,j] = sps.eval_chebyt(m,Xbar[j])
    
    delta = np.zeros((Nray,Nbar),dtype=np.double)
    for i in range(Nray):
        for j in range(Nbar):
            for m in range(M):
                delta[i,j] += dcoef[i,m]*Tmat[m,j]/math.sqrt(1-Xbar[j]**2)

    for i in range(Nray):
        plt.plot(Xbar,delta[i,:])
    plt.show()
