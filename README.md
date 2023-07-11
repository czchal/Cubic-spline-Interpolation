# Cubic-spline-Interpolation
The following repository contains a method to computes the cubic spline interpolation of the data points solving TDMA using Thomas algorithim. In addition Lagrangian polynomial interpolation is included for comparison.  

# Cubic spline description 
Cubic spline interpolation is performed by passing through all the given data points, while the points between the data points are cubic. Therefore we define a piecewise cubic function between the data points, such that all the data points are passed through and they are joined smoothly to create a continuous function. 
For the points between xi and xi+1 ( xi <=x<=xi+1) the spline equation is shown below where Δi = xi+1 − xi  

![1](/assets/1.png "MarineGEO logo")



To get the second derivative values for each data point,  we have to solve the following system of equation



![2](/assets/2.png "MarineGEO logo")


Since we have N-1 equations for N+1 endpoint condition is required to solve. For this assignment, we use the free runout( natural spline) condition given below:

	
![3](/assets/3.png "MarineGEO logo")

The resulting system is TDMA and can be solved efficiently using Thomas Algorithm. The following procedure summarizes the Algorithm employed:
Step 1: LU decomposition 
Step2: forward substitution 
Step 3: backward substitution 
