
%²Î¿¼https://blog.csdn.net/Courage2018/article/details/89646100#MatlabGLRLM_2
%--------------------------------------------------------------------------
% this program select a roi, qunatize to lower bit level and computing 
% gray level run length matrix and seven texture parameters viz., 
%    1. short run emphasis (sre) 
%    2. long run emphasis(lre)
%    3. gray level non-uniformity (gln)
%    4. run percentage (rp)
%    5. run length non-uniformity (rln)
%    6. low gray level run emphasis (lgre)
%    7. high gray level run emphasis (hgre)
%--------------------------------------------------------------------------
% author: courage
%--------------------------------------------------------------------------
function [sre1,lre1,gln1]= glrlm(im)
im2=rgb2gray(im);
im2=double(im2);
[m,n]=size(im2);
% --------- image quantization to 4 bits (16 gray levels)------------------
imax=max(max(im2));
imin=min(min(im2));
newim=im2-imin;
nmax=max(max(newim));
nmin=min(min(newim));
q=round(nmax/16);
[m,n]=size(newim);
quant=0;
for i=1:m
    for j=1:n
        k=newim(i,j);
        for b = 1:16
            if (i>quant)&(i<=quant+q)
                newim(i,j)=b/16;
                quant=quant+q;
            end            
        end
    end
end
newmax=max(max(newim));
newim1=newim/newmax;
newim2=round(newim1*16)+1;
dir=0; 
dist1=1;
if (dir == 1)
    newim2=newim2';
end
mx = max(max(newim2));
mn = min(min(newim2));
gl = (mx-mn)+1;
[p,q] = size(newim2);
n=p*q;
count=1;
c=1;
col=1;
grl(mx,p)=0;
maxcount(p*q)=0;
mc=0;
%---------------------computing gray level run length matrix---------------
for j=1:p
    for k=1:q-dist1
        mc=mc+1;
        g=newim2(j,k);
        f=newim2(j,k+dist1);
        if (g==f)&(g~=0)
            count=count+1;
            c=count;
            col=count;
            maxcount(mc)=count;
        else grl(g,c)=grl(g,c)+1;col=1;
            count=1;
            c=1;
        end
    end
    grl(f,col)=grl(f,col)+1;
    count=1;
    c=1;
end
i=(mx:mn);
m=grl(mn:mx,:);
m1=m';
maxrun=max(max(maxcount));
s=0;
g(gl)=0;
r(q)=0;
for u=1:gl
    for v=1:q
        g(u)=g(u)+m(u,v);
        s=s+m(u,v);
    end
end
for u1=1:q
    for v1=1:gl
        r(u1)=r(u1)+m1(u1,v1);
    end
end
[dim,dim1]=size(g);
sre=0; lre=0; gln=0; rln=0; rp=0; lgre=0; hgre=0;
for h1= 1:maxrun
    sre=sre+(r(h1)/(h1*h1));
    lre=lre+(r(h1)*(h1*h1));
    rln=rln+(r(h1)*r(h1));
end
sre1=sre/s;
lre1=lre/s;
for h2=1:gl
    gln=(gln+g(h2)^2);
end
gln1=gln/s;

