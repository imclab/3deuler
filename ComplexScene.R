# Load rgl library
require(rgl)
# Create a vector ranging from -2π to 2π in steps of π/50
re <- seq(from=-4*pi, to=4*pi, by=pi/25)
im <- re

## Create a vector ranging from -2πi to 2πi in steps of πi/50
#im <- re*1i

## Don't need to define this in terms of complex numbers: use trig instead.
## Define the exponential function on the sum of the two vectors
#f <- function(re,im) exp(re+im)
## Create a square matrix with the values of the function over the domain of the two vectors
#complexsurf<-outer(re,im,f)
## Create a square matrix containing the real value of the complex surface
#realsurf<-Re(complexsurf)

# Define the trig function on the sum of the two vectors
f <- function(re,im) exp(re)*cos(im)
# Create a square matrix with the values of the function over the domain of the two vectors
realsurf<-outer(re,im,f)
realsurftrunc <- realsurf

# Truncate the matrix
realsurftrunc[(realsurftrunc < -10) | (realsurftrunc > 10)] <- NA

#Keep a less-truncated version to hide the truncation effect.
realsurf[(realsurf < -75) | (realsurf > 75)] <- NA

# Open a 3D canvas
open3d(windowRect=c(0,0,640,480))
# Plot a surface using the real-valued surface calculated above, coloured red, 20% transparent.  
surface3d(re,re,realsurftrunc,color=c("red"),alpha=0.8)
# Add axes
axis3d("x",pos=c(0,0,0))
axis3d("y",pos=c(0,0,0))
labels<-T

# Save viewport
# M <- par3d("userMatrix")


# Draw parametric cos function
cosfunction <- function(x) cos(x)
coscurve <- cbind(re*0, re, cosfunction(re))
plot3d(coscurve,type="l", lwd=5, col=c("Navy"), add=TRUE)

# Draw parametric exponential function
expfunction <- function(y) exp(y)
expcurve <- cbind(re[expfunction(re)<10], re[expfunction(re)<10]*0, expfunction(re)[expfunction(re)<10])
plot3d(expcurve,type="l", lwd=5, col=c("Green"), add=TRUE)

# Draw negative parametric exponential function
negexpfunction <- function(y) -exp(y)
negexpcurve <- cbind(re[negexpfunction(re)>-10], re[negexpfunction(re)>-10]*0-pi, negexpfunction(re)[negexpfunction(re)>-10])
plot3d(negexpcurve,type="l", lwd=5, col=c("Green"), add=TRUE)

# Add the surface again so that the truncation doesn't show.
surface3d(re,re,realsurf,color=c("red"),alpha=0.8, add=TRUE)

# Set suitable view
M <- matrix( c(1, -0.3, 0, 0, 0, 0.3, 1, 0, -0.3, -1, 0.3, 0, 0, 0, 0, 1), ncol=4, byrow=TRUE)
N <- matrix( c(0,-1,0,0,0,0,1,0,-1,0,0,0,0,0,0,1),  ncol=4, byrow=TRUE)
#par3d(userMatrix=M)
par3d(zoom=0.05)
par3d(userMatrix=M)

# Rotate the scene a bit
play3d( par3dinterp( userMatrix=list(M, N), method="linear", times=c(0,3) ), duration=3 )
movie3d( par3dinterp( userMatrix=list(N, M), method="linear", times=c(0,30) ), duration=30 )
#play3d( par3dinterp( userMatrix=list(N, rotate3d(N,pi/4,1,0,0), rotate3d(N,pi/4,0,1,0) ) , extrapolate="natural"), duration=30 )
#play3d( par3dinterp( userMatrix=list(M,rotate3d(M, pi/6, 1, 0, 0), rotate3d(M, pi/6, 0, 1, 0) ) ), duration=10 )

## Create 3D spiral
#open3d()
#
## Draw parametric sin function
#sinfunction <- function(x) sin(x)
#spiralcurve <- cbind(re, sinfunction(re), cosfunction(re))
#plot3d(c(-10,10),c(-10,10),c(-10,10))
#plot3d(spiralcurve,type="l", lwd=5, col=c("Navy"), add=TRUE,xlim=c(-10,10),ylim=c(-10,10),zlim=c(-10,10))
## Add axes
#axis3d("x",pos=c(0,0,0))
#axis3d("y",pos=c(0,0,0))
#axis3d("z",pos=c(0,0,0))
#labels<-T
