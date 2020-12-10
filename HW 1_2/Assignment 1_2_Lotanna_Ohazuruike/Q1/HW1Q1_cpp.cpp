#include <iostream>
#include <math.h>       /* pow */
#include <cmath>        // std::abs
#include <fstream>

int t = 2;
	std::ofstream dtfile("del dt cpp.txt");  //outfile is the file we will print period data
// Functions
double x_t(int t){
    double x=1/(1+9*exp(-t));
    return x;
}

double x_t_prime(int t){
    double xprime=9*exp(-t)/(1 + 9*pow(exp(-t),2));
    return xprime;
}

// Main loop
int main(){
    int nmax=10;
    double del_dt_mat[nmax] = {0};
    for (int n=0;n<nmax;n++){                       // run for different values of n
        double del_t = 10^-n;
        double x1 = x_t(t);                                // computes x at current time
        double x2 = x_t(t + del_t);                        // computes x at next time
        double xprime = x_t_prime(t);                      // computes exact value of differential x

        double del_dt = abs(xprime-(x2-x1)/del_t);   // difference between exact and numerical 

        del_dt_mat[n] = del_dt;                     // save results to a vector
            std::cout<<del_dt_mat[n]<<"\n";
    	dtfile<<del_dt_mat[n]<<","<<"\n";    
	}
   // std::cout<<del_dt_mat<<"\n";

return 0;
    
}
