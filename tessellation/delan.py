#!/usr/bin/python3
import scipy.spatial as spspace
import math
import numpy as np
import scipy as sp
import random
import matplotlib.pyplot as plt
import tess

random.seed()

# define a bounding box
Npts = 14
Xmin=0.0
Xmax=10.0
Ymin=0.0
Ymax=10.0

Points = np.zeros((Npts,2),dtype=np.double)
Points[0,0] = Xmin
Points[0,1] = Ymin
Points[1,0] = Xmax
Points[1,1] = Ymin
Points[2,0] = Xmax
Points[2,1] = Ymax
Points[3,0] = Xmin
Points[3,1] = Ymax

for i in range(4,Npts):
    Points[i,0] = random.random()*(Xmax-Xmin)+Xmin
    Points[i,1] = random.random()*(Ymax-Ymin)+Ymin

dela = spspace.Delaunay(Points)

fig = plt.figure(figsize=(10,10))
plt.triplot(Points[:,0],Points[:,1],dela.simplices)
plt.plot(Points[:,0],Points[:,1],'go')

print(dela)
print(type(dela.simplices))
print(dela.simplices[0])
print(dir(dela))

Ntris = len(dela.simplices)

Area = np.zeros(Ntris,dtype=np.double)
for i in range(len(dela.simplices)):
    a = dela.points[dela.simplices[i,0]]
    b = dela.points[dela.simplices[i,1]]
    c = dela.points[dela.simplices[i,2]]
    ar=tess.triangle_area(a,b,c)
    print(a,b,c,ar)
    Area[i] = ar
    
print('\n Points')
print(dela.points)

area_total = math.fsum(Area)
print("area", area_total)


# OK, now compute weights
wgts = np.zeros(Npts,dtype=np.double)
for i in range(Ntris):
    a = dela.points[dela.simplices[i,0]]
    b = dela.points[dela.simplices[i,1]]
    c = dela.points[dela.simplices[i,2]]
    ar=tess.triangle_area(a,b,c)
    wgts[dela.simplices[i,0]] += ar/3.0
    wgts[dela.simplices[i,1]] += ar/3.0
    wgts[dela.simplices[i,2]] += ar/3.0

print('wgts', math.fsum(wgts))


plt.show()
