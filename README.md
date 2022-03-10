# Computer Organization Lab
## See the requirements and details in each folder
## lab 0: Set up
* Get familiar with assembly language 
* Set up develop environment
---
## lab 1: RISC-V assembly programming
#### Translate the given C programs written in recursion into RISC-V assembly programs 
* ```fib(n)```: return the $n 'th$ number of the [**fibonacci sequence**](https://en.wikipedia.org/wiki/Fibonacci_number)
\begin{equation}
  fib(n)=\begin{cases}
    fib(n-1) + fib(n-2), & \text{$n$ $\ge$ $3$} 
    \\ 2, & \text{$n = 2$}
    \\ 1, & \text{$n = 1$}
  \end{cases}
\end{equation}



* ```fact(n)```: return the value of [**factorial number**](https://en.wikipedia.org/wiki/Factorial) $n!$
\begin{equation}
  fact(n)=\begin{cases}
    n*fact(n-1), & \text{$n$ $\ge$ $1$} \\
    1, & \text{$n = 0$}
  \end{cases}
\end{equation}

* ```gcd(m, n)```: return the [**great common divisor**](https://en.wikipedia.org/wiki/Greatest_common_divisor) of $m$ and $n$
\begin{equation}
  gcd(a, b)=\begin{cases}
    a, & \text{$b = 0$} \\
    gcd(b, \space a \space mod \space b), & \text{$n$ $\ge$ $1$}
  \end{cases}
\end{equation}
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
