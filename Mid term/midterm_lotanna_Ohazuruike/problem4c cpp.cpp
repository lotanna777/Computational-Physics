#include <iostream>
#include <chrono>
using namespace std;

int main(){
int n = 10;

	double Amat[n][n]={{1}}; 
	double Imat[n][n]={{1}}; 
	double dmat[n][n]={{1}}; 
	double logA[n][n] = {{1}};
	for(int i=0;i<n;i++){
		for(int j=0;j<n;j++){
			if(j==i){
				Imat[j][i]=1;
			}
				else{
				Imat[j][i]=0;
				}
			
		Amat[j][i] = (1 + Imat[j][i])/(n+1);
		dmat[j][i] = -(Imat[j][i] - Amat[j][i]);
		logA[j][i]=0;
		}
	}
	
	auto start=std::chrono::steady_clock::now();  //this the start timer
	for(int k=1;k<100;k++){	
	for(int i=0;i<n;i++){
		for(int j=0;j<n;j++){
			logA[j][i] += -(dmat[j][i]*dmat[j][i])/k;
		}
	}
	}

	auto end=std::chrono::steady_clock::now();  //this the start timer
	auto timediff=std::chrono::duration_cast<std::chrono::microseconds>(end-start);
	cout<<"Time to compute the product logA was "<<timediff.count()<<" us\n";
//  ofstream myfile;
//  myfile.open ("problem 4c cpp.txt");	

	for(int i=0;i<n;i++){
		for(int j=0;j<n;j++){
	cout<<logA[j][i]<< " ";
//  myfile << logA[j][i] << " ";;
		}
		cout<<endl;
//  myfile<<endl;
	} 
// myfile.close();
	return 0;
}