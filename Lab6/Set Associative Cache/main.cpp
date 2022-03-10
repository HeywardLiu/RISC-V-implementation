#include <iostream>
#include <stdio.h>
#include <math.h>
#include <iomanip>
#include <vector>
#include <list>
#include <bitset>

using namespace std;

const int K = 1024;
const int BlockSize = 64;
int CacheSize[] = {1, 2, 4, 8, 16, 32, 64};       // K-Bytes{1, 2, 4, 8, 16, 32, 64}
int Associativity[] = {1, 2, 4, 8};

struct Set {
    bool v;
    unsigned int tag;
};

struct N_way_Cache {
  Set *Set;
  list<int> LRU;
};

double log2(double n) {
    return log(n) / log(double(2));
}

vector<double> simulate(int cache_size, int block_size, int associativity) {
    vector<double> result;
    result.clear();
    unsigned int tag, index;
    int Miss = 0, Hit = 0;
    unsigned long long x = 0;

    int line = cache_size / (block_size * associativity);
    int offset_bit = (int)log2(block_size); // # of offset_bit
    int index_bit = (int)log2(line); // # of index_bit

    N_way_Cache *L1 = new N_way_Cache[line]; // declaration of blocks
  
    for(int a = 0; a < line; a++) {
      L1[a].Set = new Set[associativity]; // # of Set in a block line
      for(int b = 0; b<associativity; b++) {
        L1[a].Set[b].v = false;
        L1[a].LRU.push_back(b); //initialization of LRU
      }
    }

    FILE *fp;
    fp = fopen("LRU.txt", "r");

    while(fscanf(fp, "%llx", &x) != EOF) {
        index = (x >> offset_bit) % (line);  
        tag = x >> (index_bit + offset_bit);

        int counter = 0;
        for(int i = 0; i < associativity; i++) {
          if(L1[index].Set[i].v && L1[index].Set[i].tag == tag) {
              L1[index].Set[i].v = true;    // hit
              L1[index].LRU.remove(i);
              L1[index].LRU.push_back(i);
              Hit += 1;
              break;
          }
          else {  
            counter = counter + 1;
          }
        }
        if(counter == associativity) {     //Miss
            int Set_idx = *L1[index].LRU.begin();
            L1[index].LRU.pop_front();
            L1[index].Set[Set_idx].v = true;  
            L1[index].Set[Set_idx].tag = tag;
            L1[index].LRU.push_back(Set_idx);
            Miss += 1;
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
  for (int i = 0; i < 7; i++) {      // i = cache size
    for (int j = 0; j < 4; j++) {    // j = N-way
      vector<double> result = simulate(CacheSize[i]*K, BlockSize, Associativity[j]);
      
      cout << Associativity[j] << "-Way" << endl;
      cout << "Cache_Size: " << CacheSize[i] << "K" << endl;
      cout << "Block_Size: " << BlockSize << endl;
      cout << "Hit rate: " << fixed << setprecision(2) << result[0] << "% ("<<int(result[1]) << "), ";
      cout << "Miss rate: " << fixed << setprecision(2) << result[2] << "% ("<<int(result[3]) << ")";
      cout << endl;

    }
    cout<<endl;
  }
  return 0;
}



/*
#include <iostream>
#include <stdio.h>
#include <math.h>
#include <iomanip>
#include <vector>
#include <list>
#include <bitset>

using namespace std;

const int K = 1024;
const int BlockSize = 64;
int CacheSize[] = {1, 2, 4, 8, 16, 32, 64};       // K-Bytes
int Associativity[] = {1, 2, 4, 8};

struct Set {
    bool v;
    unsigned int tag;
};

struct N_way_Cache {
  Set *Set;
  list<int> LRU;
};

double log2(double n) {
    return log(n) / log(double(2));
}

vector<double> simulate(int cache_size, int block_size, int associativity, int InputFile) {
    vector<double> result;
    unsigned int tag, index;
    int Miss = 0, Hit = 0;
    unsigned long long x = 0;

    
    cout << "Cache Size: " << (cache_size/K) << "K" << endl;
    cout << "Block Size: " << block_size << endl;
    cout << "Associativity: "<< associativity << endl;
    

    int line = cache_size / (block_size * associativity);
    int offset_bit = (int)log2(block_size); // # of offset_bit
    int index_bit = (int)log2(line); // # of index_bit
    
    cout << "Block numbers(lines): " << line << endl;
    cout << "offset_bit: " << offset_bit << endl;
    cout << "index_bit: " << index_bit << endl;
    cout << "tag_bit: " << 64 - (index_bit + offset_bit) << endl << endl;
    
    N_way_Cache *L1 = new N_way_Cache[line]; // declaration of blocks
  
    for(int a = 0; a < line; a++) {
      L1[a].Set = new Set[associativity]; // # of Set in a block line
      for(int b = 0; b<associativity; b++) {
        L1[a].Set[b].v = false;
        L1[a].LRU.push_back(b); //initialization of LRU
      }
    }




    FILE *fp;
    if (InputFile == 0) fp = fopen("ICACHE.txt", "r");
    if (InputFile == 1) fp = fopen("DCACHE.txt", "r");
    if (InputFile == 1) fp = fopen("Test.txt", "r");

    while(fscanf(fp, "%x", &x) != EOF) {
        
        cout<<"Memory Adrress, Decimal: "<< x << endl;
        cout<<"Binary: "<<bitset<32>(x)<<endl;;

        index = (x >> offset_bit) % (line);  
        tag = x >> (index_bit + offset_bit);

        
        cout << "LRU before hit/miss: ";
        for(list<int>::iterator it = L1[index].LRU.begin(); it!= L1[index].LRU.end(); ++it ) {
            cout << *it <<", ";
        }
        cout << endl;
        

        cout << "index:" << index << ", " << bitset<32>(index) << endl;;
        cout << "tag:" << tag << ", " << bitset<32>(tag) << endl;
        

        int counter = 0;
        for(int i = 0; i < associativity; i++) {
          if(L1[index].Set[i].v && L1[index].Set[i].tag == tag) {
              L1[index].Set[i].v = true;    // hit
              L1[index].LRU.remove(i);
              L1[index].LRU.push_back(i);
              Hit += 1;
              cout<<"Hit"<<endl;
              break;
          }
          counter = counter + 1;
        } 
        if(counter == associativity) {     //Miss
            int Set_idx = *L1[index].LRU.begin();
            L1[index].LRU.pop_front();
            L1[index].Set[Set_idx].v = true;  
            L1[index].Set[Set_idx].tag = tag;
            L1[index].LRU.push_back(Set_idx);
            Miss += 1;
            cout<<"Miss"<<endl;
        }

        
        //Traverse LRU
        
        cout << "LRU after hit/miss: ";
        for(list<int>::iterator it = L1[index].LRU.begin(); it!= L1[index].LRU.end(); ++it ) {
            cout << *it <<", ";
        }
        cout << endl << endl;
        
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

    for (int a = 1; a < 2; a++) {
				if(a==0) {
          cout<<"~*~*~*~*~ I-Cache ~*~*~*~*~"<<endl;
        }
        if(a==1) {
          cout<<endl<<endl;;
          cout<<"~*~*~*~*~ D-Cache ~*~*~*~*~"<<endl;
        }
        for (int i = 0; i < 1; i++) {
            for (int j = 0; j < 4; j++) {
              vector<double> result = simulate(CacheSize[i]*K, BlockSize, Associativity[j], a);

              cout << "Cache_Size: " << CacheSize[i] << "K" << endl;
              cout << "Block_Size: " << BlockSize << endl;
              cout << "Associativity: " << Associativity[j] <<endl;
              cout << "Hit rate: " << fixed << setprecision(2) << result[0] << "% ("<<int(result[1]) << "), ";
              cout << "Mis rate: " << fixed << setprecision(2) << result[2] << "% ("<<int(result[3]) << ")";
              cout << endl << "~~~~~~~~~~~~~~~~~~~~~~~~~~~";
              cout << endl << endl;
              //cout << fixed << setprecision(2) << result[2] << " ";
            }
            cout<<endl;

        }
    }
}
*/