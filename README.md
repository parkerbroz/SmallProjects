# tsaw
This markdown file is a walkthrough of my current process in trading on [Kalshi's market for TSA check-ins](https://kalshi.com/markets/tsaw/).  

The TLDR about what I did here is:
- data collection through web scraping and API usage
- data analysis to identify trends
- machine learning to create a predictor
- price estimation with some statistics
- backtesting development for trading algorithm testing

And I ended up with an EV of $1.17 for each $1 I traded!

# constant-fib
An $O(1)$ algorithm for finding the $n$-th Fibonacci number. This is an interesting application of some concepts I learned in my Abstract Linear Algebra course. Essentially, iterating from one Fibonacci number to the next can be represented as matrix multiplication. We can use some linear algebra tricks to make this computation
very quick. 

Calling the algorithm $O(1)$ may be slightly misleading, as it assumes multiplication is $O(1)$ with respect to $n$. However, this seems not to matter since in practice the algorithm runs in essentially constant time, as shown by the chart at the end of the notebook.

# grecian
A brute-force algorithm for [this](https://projectgeniusinc.com/grecian-computer/) puzzle I got for Christmas.

I don't feel so bad about using brute-force, since this problem is probably not solvable in poly-time. A sketch of a proof follows (everything is 0-indexed).

We define a Grecian Computer with a target sum $x$ as a set $R$ of rings, where each ring is essentially a matrix. $R_{x,y,z}$ is the z-th value on the y-th radii of the x-th ring.

Any Subset-Sum problem $L$ is reducible to Grecian Computer in polynomial time. For a vector of naturals $V$ of size $n$ with a target sum $x$:
- Create a Grecian Computer $GC$ with $n+1$ radii and $n+1$ rings with target sum $x$.
- The base ring $R_n+1$ has all values equal $0$, except $R_{n,n,i} = V_i$, and $R_{n,i,n} = x$ for $i \neq n$
- Every other ring $R_i$ is all holes excluding $R_{i,0,i}$ which is $0$

This transformation takes $O(n)$ time for each radii on a given ring, we have $O(n)$ radii for each ring, and we have $O(n)$ rings. Therefore in total, our transformation is $O(n^3)$, which is clearly polytime.

Now, if we get a solution to the $GC$, our solution to $L$ is simply read off of radius $n$. Or formally, $V_i$ is in our solution to $L$ if $R_{i,n,i} \neq 0$ (is a hole, so the value on the base ring is visible).

Therefore $GC$ satisfiable $\iff$ $L$ satisfiable. Since we reduce in polynomial time, and Subset-Sum is NP-Complete, if $GC\in{P}$ then $P=NP$. Thus finding a poly-time algorithm for a Grecian Computer proves $P=NP$, so I will not bother finding one for now.

# you2be
The motivation for this project is a bit dubious. In 11th grade my highschool administration began limiting student internet access. One of the limitations they made restricted Youtube access to only videos which the administration had placed on a whitelist. My friends and I were beginning to be interested in poker, and wanted to watch professional tournaments during study hall. Of course, none of these videos were whitelisted, and so I developed this tool so that we could watch them anyway.

The script works by navigating Youtube through its source code. It scrapes results from a user-entered query. The user selects a video from these results, and the script now scrapes the source url for the video content. 

I rewrote some of the webscraping to make the script functional again (as of 12/30/2022) since Youtube source code updates had completely broken it. The organization and style of the script remain untouched which provides a snapshot of my highschool coding brain.

 **Potential TODOs:**
- streamline user interaction system
- allow for selection of video quality
- support sourcing viral videos
  - source links for immensely popular videos (like [Waka Waka](https://www.youtube.com/watch?v=pRpeEdMmmQ0)) receive a 403 error 
