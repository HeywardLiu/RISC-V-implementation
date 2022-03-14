# Computer Organization Lab
## See the requirements and details in each folder
## lab 0: Set up
* Get familiar with RISC-V assembly
* Set up develop environment
---
## lab 1: RISC-V assembly programming
#### Translate the given C programs written in recursion into RISC-V assembly programs 
* ```fib(n)```: return the $n 'th$ number of the [**fibonacci sequence**](https://en.wikipedia.org/wiki/Fibonacci_number)
![image](https://user-images.githubusercontent.com/54396044/158107247-a35ee0ab-1515-4540-b963-b022e30c0181.png)

* ```fact(n)```: return the value of [**factorial number**](https://en.wikipedia.org/wiki/Factorial) $n!$
![image](https://user-images.githubusercontent.com/54396044/158107971-4334bf22-7c9e-47f8-b0fd-1aa686502499.png)

* ```gcd(m, n)```: return the [**great common divisor**](https://en.wikipedia.org/wiki/Greatest_common_divisor) of $m$ and $n$
![image](https://user-images.githubusercontent.com/54396044/158107363-ae5a4e9d-712f-41d8-9512-eb137554ede5.png)
---
## lab 2: ALU implementation
#### Implement 32-bit Arithmetic Logic Unit including the following operation:
* addition
* subtraction
* logical AND
* logical OR
* logical NAND
* logical NOR
* set less than
* ![](https://i.imgur.com/60YOUNH.png)
---
## lab 3: Single-Cycle RISC-V  implementation without memory transfer instruction
#### 
* Implement a **subset** of RISC-V microarchitecture
* **Architecture Diagram**![](https://i.imgur.com/pudyg6T.png)

* **Spec**![](https://i.imgur.com/P54brKg.png)
![](https://i.imgur.com/iw5mCWh.png)
---

## lab 4 : Complete Single-Cycle RISC-V microprocessor
* Implement the microarchitecture with memory transfer instrcution
* Addtional instruction support based on lab 3
![](https://i.imgur.com/jQgFd9X.png)
![](https://i.imgur.com/vYgqPLa.png)

* **Architecture Diagram** ![](https://i.imgur.com/Bwei3lq.png)
---

## lab 5 : 5-staged pipelined RISC-V microprocessor implementation with forwarding unit 
* **Architecture Diagram**![](https://i.imgur.com/y4kz4HR.png)

* **Forwarding Unit** ![](https://i.imgur.com/QNanHgY.png)

## lab 6 : Cache experiment, the incluence of locality and block size on cahce hit rate
* **Direct-mapped** cache: **block size** and miss rate![](https://i.imgur.com/52wOyqH.png)

* **Set-associative** cache: **associativity** and miss rate ![](https://i.imgur.com/Bsp7JX5.png)
