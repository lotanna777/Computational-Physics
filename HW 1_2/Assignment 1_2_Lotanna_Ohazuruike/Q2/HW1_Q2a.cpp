#include <iostream>
#include <fstream>
#include <math.h>       /* pow */

using namespace std;

int main(){
    int x=2;
    //cout << "Enter a positive integer: ";
    //cin >> n;
	std::ofstream mfile("int_mult_q2a.txt");
    for (int i = 0; ; i++) {
        cout << x << " ^ " << i << " = " << pow(x,i)<< endl;
    	mfile<<"for int 2, i = "<<i<<", "<<pow(x,i)<<","<<"\n"; 		
    }
    
    return 0;
}