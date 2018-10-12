5 graphic 1,1:color 0,1:color 4,1:color 1,8
10 spheres=2:if spheres then dim c(spheres,3):dim r(spheres):dim q(spheres)
20 for k=1 to spheres:read c(k,1),c(k,2),c(k,3),r:r(k)=r:q(k)=r*r:next k
30 data -0.3,-0.8,3,0.6
40 data 0.9,-1.1,2,0.2
50 for i=0 to 199:for j=0 to 319
60 x=0.3:y=-0.5:z=0
70 dx=j-160:dy=i-100:dz=375:dd=dx*dx+dy*dy+dz*dz
80 gosub 100:next j:next i
90 stop
100 n=y>=0 or dy<=0:if not n then s=-y/dy
110 for k=1 to spheres
120 px=c(k,1)-x:py=c(k,2)-y:pz=c(k,3)-z
130 pp=px*px+py*py+pz*pz
140 sc=px*dx+py*dy+pz*dz
150 if sc<=0 then goto 200
160 bb=sc*sc/dd
170 aa=q(k)-pp+bb
180 if aa<=0 then goto 200
190 sc=(sqr(bb)-sqr(aa))/sqr(dd):if sc<s or n<0 then n=k:s=sc
200 next k
210 if n<0 then return 
220 dx=dx*s:dy=dy*s:dz=dz*s:dd=dd*s*s
230 x=x+dx:y=y+dy:z=z+dz
240 if n=0 then goto 300
250 nx=x-c(n,1):ny=y-c(n,2):nz=z-c(n,3)
260 nn=nx*nx+ny*ny+nz*nz
270 l=2*(dx*nx+dy*ny+dz*nz)/nn
280 dx=dx-nx*l:dy=dy-ny*l:dz=dz-nz*l
290 goto 100
300 for k=1 to spheres
310 u=c(k,1)-x:v=c(k,3)-z:if u*u+v*v<=q(k) then return 
320 next k
330 if (x-int(x)>.5)<>(z-int(z)>.5) then draw ,j,i
340 return