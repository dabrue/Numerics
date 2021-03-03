#!/usr/bin/env python3
'''
This is a practice script for FBR/DVR 

Finite Element Representation to Discrete Variable Representation
'''
##########################################################################################
# PREFACE
import math
import numpy as np
import scipy as sp
import scipy.special as sps
import matplotlib.pyplot as plt
import pandas

##########################################################################################
# FUNCTIONS AND DEFINITIONS

def int_trapazoid(X, A, B, W):

    # Sanity Check
    if (len(X) != len(A) or len(X) != len(B) or len(X) != len(W)):
        exit("ERROR: Trapaxoid integrate Length mismatch")
    else: 
        pass

    S = 0.0
    for i in range(1,len(X)):
        S += (A[i]*B[i]*W[i]+A[i-1]*B[i-1]*W[i-1])*(X[i]-X[i-1]) / 2
    return S


##########################################################################################
# MAIN
if (__name__ == '__main__'):

    # First let us see how calling the built-in special functions works
    Npts = 1001
    xmin = -10
    xmax = 10
    xray = np.linspace(xmin,xmax,Npts)
    wray = np.zeros_like(xray)

    # NOTE the SPS hermite functions are different from sps.hermitenorm in the 
    # normalization. I'm using standard hermite here and accounting for the extra
    # factor of 2 in the normalization. Alternatively, one can use hermitenorm.
    H0 = sps.hermite(0)
    H1 = sps.hermite(1)
    H2 = sps.hermite(2)

    H0ray = np.zeros_like(xray)
    H1ray = np.zeros_like(xray)
    H2ray = np.zeros_like(xray)

    for i in range(Npts):
        wray[i] = math.exp(-(xray[i]**2))
        H0ray[i] = H0(xray[i])
        H1ray[i] = H1(xray[i])
        H2ray[i] = H2(xray[i])

    dx = (xmax - xmin)/ (Npts - 1 )
    N02=dx*np.matmul(H0ray.transpose(),H2ray)
    print("Norm 0 2",N02)
    N02=0.0
    for i in range(1,Npts):
        N02 += dx*(H0ray[i]*H2ray[i] + H2ray[i-1]*H0ray[i-1])/2
    print("Norm 0 2",N02)
    N02=0.0

    NHermites = 5
    Hray=[]
    for i in range(NHermites):
        tmp = np.zeros_like(xray)
        H = sps.hermite(i)
        for j in range(Npts):
            tmp[j] = H(xray[j])
        Hray.append(tmp)

    HermiteNorms = np.zeros((NHermites,NHermites),dtype=np.float)
    HermiteNorms2 = np.zeros((NHermites,NHermites),dtype=np.float)

    for i in range(NHermites):
        normConstant= 2**i * math.factorial(i)*math.sqrt(math.pi)
        print('NC',i,normConstant)
        for j in range(NHermites):
            HermiteNorms[i,j] = int_trapazoid(xray,Hray[i],Hray[j],wray) / normConstant
            HermiteNorms2[i,j] = math.fsum(Hray[i]*Hray[j]*wray)*dx / (2**i * math.factorial(i)*math.sqrt(math.pi))

    print(HermiteNorms)
    print("")
    print(HermiteNorms2)

    i = 1
    j = 1
    tmp = math.fsum(Hray[i]*Hray[j]*wray)*dx / (2**i * math.factorial(i)*math.sqrt(math.pi))
    print('tmp int test',tmp)

    fig0 = plt.figure()
    ax0 = fig0.add_subplot(1,1,1)
    for i in range(NHermites):
        plt.plot(xray,Hray[i])
    #plt.show()

    # GOOD. Let's do the same with Lengendre polynomials

    Nfunc = 4
    Npts = 1001
    xmin = -1
    xmax = 1
    dx = (xmax-xmin)/(Npts-1)
    xray = np.linspace(xmin,xmax,Npts)
    Lweight = np.ones_like(xray)
    Legs = []
    for i in range(Nfunc):
        Legs.append(sps.legendre(i))
    Lray = []
    for i in range(Nfunc):
        tray = np.zeros_like(xray)
        for j in range(Npts):
            tray[j] = Legs[i](xray[j])
        Lray.append(tray)

    LegNorms = np.zeros((Nfunc,Nfunc),dtype=np.float)
    LegNormsT = np.zeros((Nfunc,Nfunc),dtype=np.float)
    for n in range(Nfunc):
        normConstant = 2.0/(2.0*n+1)
        for m in range(Nfunc):
            LegNorms[n,m] = math.fsum(Lray[n]*Lray[m]*Lweight)*dx/normConstant
            LegNormsT[n,m] = int_trapazoid(xray,Lray[n],Lray[m],Lweight)/normConstant
    print("\nLegendre Norms MIDPOINT integrate:\n",LegNorms)
    print("\nLegendre Norms TRAPAZOIDAL integrate:\n",LegNormsT)

    fig1 = plt.figure()
    ax1 = fig1.add_subplot(1,1,1)
    for i in range(Nfunc):
        plt.plot(xray,Lray[i])


    ######################################################################################
    # Moving on to quadratures

    Nfunc = 4
    Npts = 10001
    xmin = -1
    xmax = 1
    dx = (xmax-xmin)/(Npts-1)
    xray = np.linspace(xmin,xmax,Npts)
    Lweight = np.ones_like(xray)
    Legs = []
    for i in range(Nfunc):
        Legs.append(sps.legendre(i))
    Lray = []
    for i in range(Nfunc):
        tray = np.zeros_like(xray)
        for j in range(Npts):
            tray[j] = Legs[i](xray[j])
        Lray.append(tray)

    # Let's find the eigenvalues of the position operator. The position operator is 
    # simply the function x(x), or the values of x at the abscissa points. 
    LX = np.zeros((Nfunc,Nfunc),dtype=np.float)
    LXS = np.zeros((Nfunc,Nfunc),dtype=np.float)
    wxtmp = xray * Lweight
    for n in range(Nfunc):
        normConstant = 2.0/(2.0*n+1)
        for m in range(Nfunc):
            LX[n,m] = int_trapazoid(xray,Lray[n],Lray[m],wxtmp)/normConstant
            #LX[m,n] = int_trapazoid(xray,Lray[n],Lray[m],wxtmp)/normConstant
    for n in range(Nfunc):
        for m in range(n+1):
            LXS[n,m] = LX[n,m]
            LXS[m,n] = LX[n,m]

    print('\nLX\n',LX)
    try:
        lx_eig, lx_vec = sp.linalg.eig(LX)
        lxs_eig, lxs_vec = sp.linalg.eigh(LXS)
    except LinAlgError:
        print('ERROR: Failed to compute eigenvalues, eigenvectors')
        exit()
    except:
        raise

    lx_eig = np.real(lx_eig)
    VTV = np.matmul(lx_vec.transpose(),lx_vec)
    VVT = np.matmul(lx_vec,lx_vec.transpose())
    VTVS = np.matmul(lxs_vec.transpose(),lxs_vec)
    VVTS = np.matmul(lxs_vec,lxs_vec.transpose())


    print('\nLX EIGENVALUES\n',lx_eig)
    print('\nLXS  EIGENVALUES\n',lxs_eig)
    print('\nLX EIGENVECTORS\n',lx_vec)
    print('\nLXS  EIGENVECTORS\n',lxs_vec)
    print('\nVT*V\n',VTV)
    print('\nS VT*V\n',VTVS)
    print('\nV*VT\n',VVT)
    print('\nS V*VT\n',VVTS)

    # NOTE OK, so why are the eigenvectors not orthonormal?
    for i in range(len(lx_eig)):
        print(lx_eig[i]/lxs_eig[i])

    LXD = np.matmul(lx_vec.transpose(),np.matmul(LX,lx_vec))
    LXDS = np.matmul(lxs_vec.transpose(),np.matmul(LXS,lxs_vec))

    print('\nLXD\n',LXD)
    print('\nLXDS\n',LXDS)
    #plt.show()
