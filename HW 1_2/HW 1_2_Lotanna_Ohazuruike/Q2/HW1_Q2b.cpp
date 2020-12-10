#include <iostream>
#include <fstream>
#include <math.h>       /* pow */

using namespace std;

int main(){
    double x = 2.0;
    //cout << "Enter a positive integer: ";
    //cin >> n;
	std::ofstream mfile("double_mult_q2b.txt");
    for (int i = 0; ; i++) {      //infinite loop
        cout << x << " ^ " << i << " = " << pow(x,i)<< endl;
    	mfile<<"for double 2, i = "<<i<<", "<<pow(x,i)<<","<<"\n"; 		
    }
    
    return 0;
}