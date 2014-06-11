---
title: Understanding Convolutions
date: 2014-06-11
author: Oinkina
---

A Motivating Example: Dropping a Ball
----

Imagine we drop a ball from some height onto the ground, where it only has one dimension of motion. *How likely is it that a ball will go a distance $c$ if you drop it and then drop it again from above the point at which it landed?*

Let's break this down. After the first drop, it will land $a$ units away from the starting point with probability $f(a)$, where $f$ is the probability distribution.

Now after this first drop, we pick the ball up and drop it from another height above the point where it first landed. The probability of the ball rolling $b$ units away from the new starting point is $g(b)$, where $g$ may be a different probability distribution if it's dropped from a different height.

<!--FIX THIS PARAGRAPH: fix the result -> probability doesn't sound right; conditioned on it being a ??-->

If we fix the result of the first drop so we know the ball went distance $a$, for the ball to go a total distance $c$, the distance travelled in the second drop is also fixed at $b$, where $a+b=c$. So the probability of this happening is simply $f(a)*g(b)$.[^expl]

[^expl]: 
    We want the probability of the ball rolling $a$ units the first time and also rolling $b$ units the second time. There are two ways of getting to this, the way that is more mathematically intuitive, and the way that more closely adheres to the visuals of the problem. 

    We can consider $f$ and $g$ to be independent, with both distributions centered at 0 and then the distances $a$ and $b$ are added. So $P(a,b) = P(a) * P(b) = f(a) * g(b)$. 

    Alternatively, we can think of the probability distribution $g$ as shifted over and centered at $a$, to better visually match the problem. In this view, $P(a,b) = P(a) * P(a+b \vert a)$, because the shifted version is conditional on $a$ and we now want to find the total distance. This evaluates to $f(a)*g(a+b-a)=f(a)*g(b)$.

    So it doesn't matter whether we think about the indepedent probability distribution $g(x)$ or the conditional distribution $g(x-a)$ because both perspectives end up evaluating to the same thing.

Let's think about this with a specific discrete example. We want the total distance $c$ to be 3. If the first time it rolls, $a=1$, the second time it must roll $b=2$ in order to reach our total distance $a+b=3$. The probability of this is $f(1)*g(2)$. 

However, this isn't the only way we could get to a total distance of 3. The ball could roll 0 units the first time, and 3 the second. Or 2 units the first time and 1 the second. It will land at a total distance of $c$ for any $a+b=c$. 

In order to find the *total likelihood* of the ball reaching a total distance of $c$, we can't consider only one possible way of reaching $c$. Instead, we consider *all the possible ways* of partitioning $c$ into two drops $a$ and $b$ and sum over the *probability of each way*. 

We already know that the probability for each case of $a+b=c$ is simply $f(a)*g(b)$. So, summing over every $a+b=c$, we can denote the total likelihood as:
$$\sum_{a+b=c} f(a)*g(b)$$
Turns out, we're doing a convolution! 



The Definition of Convolutions
----

Our definition of a convolution isn't the standard one. We aren't even using 'valid' summation notation. But it gets at the crux of the idea: to evaluate the convolvolution of $f$ and $g$ at $c$ (which is written $f\star g(c)$), we multiply $f$ and $g$ evaluated at $a$ and $b$ respectively, for all the cases where $a$ and $b$ sum to $c$.

If we rewrite this summation using standard notation, we get the actual definition of convolution. We'll sum over $a$, and because $a+b=c \Rightarrow b=c-a$, $b$ drops out entirely: 
$$f \star g (c) = \sum_a f(a)*g(c-a)$$
We've only discussed discrete convolutions so far, where the possible ways of partitioning are finite. By using an integral instead, we now have the continuous version:
$$f \star g (c) = \int f(a)g(c-a) ~da$$

The convolution operation is very valuable in many applications. But before we go into more examples, let's first understand what's happening geometrically.

Geometric view
-----
### Cross-Correlation

A similar operation to convolution that makes visualization easier is cross-correlation. But while a convolution sums over $a+b=c$, cross-correlation sums over $a-b=c$, so the discrete version is
$$f \star g (c) = \sum_a f(a)*g(a-c)$$
and the continuous version is
$$f \star g (c) = \int f(a)g(a-c) ~da$$
Cross-correlation is closely tied to convolution. Cross-correlation and convolutions are often mixed up, but we can remember which is $c-a$ and which is $a-c$ from the $a+b=c$ and $a-b=c$ understandings. 

We can go between the cross-correlation and convolution operations as such:
$$(f \star_{\text{cross}} g)(c) = (f \star_{\text{conv}} g(x \rightarrow -x))(c)$$

Cross-correlation effectively flips $g$.

* Animations

Finding the derivative visually
---
* Discrete Dirac Delta
* Delta'
* Delta''
* Continuous

Audio Manipulation
---
* Identity is just the sound itself; as it slides across, z can be thought of as time
* Echo
* Different magnitudes, more complicated versions

Image Manipulation 
----
* Transformations commonly used in computer vision

### Multi-dimensional convolution
* Matrices as functions
    * In their linear algebra purpose, matrices are functions on vectors
    * Can also be viewed as different functions (e.g., 5x4 has 4)
* $A: \mathbb{R}^2 \to \mathbb{R}$
    * Same as normal definition but taking vectors as the arguments instead
* $f,g: \mathbb{R} \to \mathbb{R}^2$ 
    * $(f_x \star g_z (z), f_y \star g_y(z))$

### Images
* Visually can imagine it like sliding a kernel across it 
    * Using cross-correlation for simplicity (it's the same but with flipped indices)
* More rigorously, apply the convolution $f \star g$, where 
    * the image is $f: \mathbb{Z}^2 \to \mathbb{Z}$ for black and white, or $f: \mathbb{Z}^2 \to \mathbb{Z}^3$ for color because R,G,B makes it a 3-Tensor, 
    * and the kernel is $g: \mathbb{Z}^2 \to \mathbb{Z}$
    	* It's like a matrix on the entire thing but everywhere is zero around the kernel
* Examples of image manipulations
    * blur 
    * edge detect
    * derivative
        * 1D in x and y separately
        * 2D; $g: \mathbb{Z}^2 \to \mathbb{Z}^2$

Group Convolutions
-----
### Motivating example: shuffling a deck of cards
* defined the same way but where mutliplication is actually the group binary operation

Algebraic Properties of Convolutions
-----
Let's look for some properties:

* Identity
	* It's our Dirac delta function!
* Closure
* Associativity
* No inverse
* It's a monoid that is commutative if the group operation is commutative 

Convolutions are Linear Transforms
------
### Show that it satisfies those properties
### 2-Tensor "shift dot product" on vectors
### 4-Tensor "shift matrix dot product" on images