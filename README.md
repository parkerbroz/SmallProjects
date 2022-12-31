
# SmallProjects
These are some of the projects I've worked on over the years. Below is a brief description of each.

## you2be
The motivation for this project is a bit dubious. In 11th grade my highschool administration began limiting student internet access. One of the limitations they made restricted Youtube access to only videos which the administration had placed on a whitelist. My friends and I were beginning to be interested in poker, and wanted to watch professional tournaments during study hall. Of course, none of these videos were whitelisted, and so I developed this tool so that we could watch them anyway.

The script works by navigating Youtube through it's source code. It scrapes results from a user-entered query. The user selects a video from these results, and the script now scrapes the source url for the video content. 

I rewrote some of the webscraping to make the script functional again (as of 12/30/2022) since Youtube source code updates had completely broken it. The organization and style of the script remain untouched which provides a snapshot of my highschool coding brain.

 **Potential TODOs:**
- streamline user interaction system
- allow for selection of video quality
- support sourcing viral videos
  - source links for immensely popular videos (like [Waka Waka](https://www.youtube.com/watch?v=pRpeEdMmmQ0)) receive a 403 error 


## grecian
A brute-force algorithm for [this](https://projectgeniusinc.com/grecian-computer/) puzzle I got for Christmas.

I have no qualms about using brute-force, since this problem is not easily solvable in poly-time. A sketch of a proof follows.

Any Subset-Sum problem $L$ is reducible to Grecian Computer in polynomial time. For a set $S$ of size $n$ with a target sum $x$:
- Create a Grecian Computer $GC$ with $n+1$ radii and rings and target sum also $x$
- The base ring $R_n$ has radii $r_i$ with values all equal $0$, except $r_{i, n+1}=x-S_i$ and $r_{i,i}=S_i$ $\forall{i}\in[0,n]$, as well as one additional radius $r_{n+1}$ with all values equal $0$
- Every other ring $R_i$ has all empty spaces except $r_{0,i}=S_i$

Now, if $L$ has a solution $(x_0, x_1, ... x_i)$, $GC$ will have a solution attained by rotating rings $R_{x_i}$ clockwise $i+1$ times. If $GC$ has a solution then the top values along $r_{n+1}$ will provide a solution to $L$.

Therefore $GC$ satisfiable $\iff$ $L$ satisfiable. Since we reduce in polynomial time, and Subset-Sum is NP-Complete, if $GC\in{P}$ then $P=NP$. Thus finding a poly-time algorithm for a Grecian Computer proves $P=NP$, so I will not bother finding one for now.