#!/usr/bin/env python3
import numpy as np
import scipy as sp
import scipy.spatial as spspace
import scipy.linalg as spla
import matplotlib.pyplot as plt
import math
import random


#-----------------------------------------------------------------------------------------
def point_to_line(p1,p2,pt):
    # INPUT:
    # p1 = [x0,y0]
    # p2 = [x1,y1]
    # pt = [xt,yt] - point to test by line defined by p1 and p2

    if (p2[0] - p1[0] == 0.0):
        # line is vertical, distance is difference in x
        dist = abs(pt[0]-p1[0])
    else:
        # put line in form of ax+by+c = 0
        slope = (p2[1]-p1[1])/(p2[0]-p1[0])
        a = -slope
        b = 1.0
        c = slope*p1[0]-p1[1]
        dist = abs( (a*pt[0]+b*pt[1] + c))/math.sqrt(a**2+b**2)
        print('slope,abc,dist',slope,a,b,c,dist)
    return dist

#-----------------------------------------------------------------------------------------
def triangle_area(p1,p2,p3):
    base = math.sqrt((p2[0]-p1[0])**2 + (p2[1]-p1[1])**2)
    height = point_to_line(p1,p2,p3)
    area = base * height / 2
    print('base, height, area',base,height,area)
    return area

#-----------------------------------------------------------------------------------------
def point_to_plane(p1,p2,p3,pt):
    # get normal vector
    nv = np.cross(p1,p2)
    nvmag = math.sqrt(nv[0]**2+nv[1]**2+nv[2]**2)
    nva = nv/nvmag
    # The plane is now defined by the normal vector and a point
    # Ax+By+Cz+D = 0
    # A = nva[0]
    # B = nva[1]
    # C = nva[2]
    # D = -(A*p1[0]+B*p1[1]+C*p1[2])
    # now find vector from test point pt to any p1,p2,p3 and project
    # this onto the unit normal vector to get perpendicular componet
    vec = pt-p1
    dist = abs(np.dot(nva,vec))
    return dist

#-----------------------------------------------------------------------------------------
def tetra_vol(p1,p2,p3,p4):
    a = p1-p4
    b = p2-p4
    c = p3-p4
    V = abs(np.dot(a,np.cross(b,c)))/6
    return V


#-----------------------------------------------------------------------------------------
if (__name__ == '__main__'):
    points = np.array([[0, 0], [0, 1.1], [1, 0], [1, 1]])
    tri = Delaunay(points)

    plt.triplot(points[:,0], points[:,1], tri.simplices)
    plt.plot(points[:,0], points[:,1], 'o')
#    plt.show()

    print(tri.simplices)


    Npts = 10

    pts = np.zeros((Npts,2))
    for i in range(Npts):
        pts[i,0] = random.randrange(0,11)
        pts[i,1] = random.randrange(0,11)

    test1 = Delaunay(pts)
    plt.triplot(pts[:,0],pts[:,1],test1.simplices)
#    plt.show()

    Npts = 44
    Xmin=0.0
    Xmax=10.0
    Ymin=0.0
    Ymax=10.0
    # Include Corner points by force
    pts = np.zeros((Npts,2))
    pts[0,0] = Xmin
    pts[0,1] = Ymin
    pts[1,0] = Xmax
    pts[1,1] = Ymin
    pts[2,0] = Xmax
    pts[2,1] = Ymax
    pts[3,0] = Xmin
    pts[3,1] = Ymax
    for i in range(4,Npts):
        pts[i,0] = random.randrange(0,11)
        pts[i,1] = random.randrange(0,11)

    test1 = spspace.Delaunay(pts)
    figR = plt.figure(figsize=(10,10))
    plt.triplot(pts[:,0],pts[:,1],test1.simplices)
    plt.plot(pts[:,0],pts[:,1],'go')
    plt.show()

