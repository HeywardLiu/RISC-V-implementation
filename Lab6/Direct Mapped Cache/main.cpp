#include <iostream>
#include <stdio.h>
#include <math.h>
#include <iomanip>
#include <vector>
using namespace std;

const int K = 1024;
int CacheSize[] = {4, 16, 64, 256};       // K-Bytes
int BlockSize[] = {16, 32, 64, 128, 256}; //Bytes

struct Cache {
    bool v;
    unsigned int tag;
};

double log2(double n) {
    return log(n) / log(double(2));
}


vector<double> simulate(int cache_size, int block_size, int InputFile) {
    vector<double> result;
    unsigned int tag, index, x;
    int Miss = 0, Hit = 0;
    
    int offset_bit = (int)log2(block_size); // # of offset_bit
    int index_bit = (int)log2(cache_size/block_size); // # of index_bit
    int line = cache_size >> (offset_bit); // # of blocks
    
    
    Cache *L1 = new Cache[line]; // declaration of blocks

    for(int j = 0; j < line; j++)
        L1[j].v = false;

    FILE *fp;
    if (InputFile == 0) fp = fopen("ICACHE.txt", "r");
    if (InputFile == 1) fp = fopen("DCACHE.txt", "r");

    while(fscanf(fp, "%x", &x) != EOF) {
        //cout<<"__x:"<<x<<", "; //x = (Mem_Address) in decimal
        index = (x >> offset_bit) % (line); 
        tag = x >> (index_bit + offset_bit);
        //cout<<"index:"<<index<<", ";
        //cout<<"tag:"<<tag;
        if(L1[index].v && L1[index].tag == tag) {
            L1[index].v = true;    // hit
            Hit += 1;
            //cout<<", Hit"<<endl;
        } else {
            L1[index].v = true;  // miss
            L1[index].tag = tag;
            Miss += 1;
            //cout<<", Miss"<<endl;
        }
    }

    fclose(fp);
    double MissRate = ((double)Miss / (double)(Hit + Miss)) * 100;
    double HitRate = ((double)Hit / (double)(Hit + Miss)) * 100;
    result.push_back(HitRate);    
    result.push_back(Hit);
    result.push_back(MissRate);
    result.push_back(Miss);
    delete [] L1;
    return result;
}


int main() {
		double rate;

    for (int a = 0; a < 2; a ++) {
				if(a==0) {
          cout<<"~*~*~*~*~ I-Cache ~*~*~*~*~"<<endl;
        }
        if(a==1) {
          cout<<endl<<endl;;
          cout<<"~*~*~*~*~ D-Cache ~*~*~*~*~"<<endl;
        }
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 5; j++) {
              vector<double> result;
              cout << "Cache_Size: " << CacheSize[i] << "K" << endl;
              cout << "Block_Size: " << BlockSize[j] << endl;
              result = simulate(CacheSize[i]*K, BlockSize[j], a);
              cout << "Hit rate: " << fixed << setprecision(2) << result[0] << "% ("<<int(result[1]) << "), ";
              cout << "Miss rate: " << fixed << setprecision(2) << result[2] << "% ("<<int(result[3]) << ")";
              cout << endl;
            }
            cout<<endl;

        }
    }
}
