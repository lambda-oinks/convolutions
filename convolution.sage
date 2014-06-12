f = lambda x: max(0, cos(2*x))
#g = lambda x: max(0, sin(x))
g = lambda x: 0 if x < -0.2 or x > 0.2 else 2

conv_ = lambda z: numerical_integral(lambda x: f(x)*g(z-x), [-3,3])[0]
conv_vals = [conv_(n/10-3) for n in xrange(61)]

def conv(x):
    n = 10*(x+3)
    n = max(0,min(n,60))
    n1 = int(floor(n))
    n2 = int(ceil(n))
    d = n - n1
    return (1-d)*conv_vals[n1] + d*conv_vals[n2]

def visualize(t):

    g2 = lambda x: g(t-x)
    
    prod = lambda x: f(x) * g2(x)

    vis  = plot(prod, [-3,3], color = "purple", fill = "axis", fillcolor = "yellow", ymin = 0, ymax = 3)
    vis += plot(g2, [-3,3], color = "blue")
    vis += plot(f, [-3,3], color = "red")
    if t > -3:
        vis += plot(conv, [-3,t], color = "gray")

    return vis

anim = animate([visualize(n/10-3) for n in xrange(61)])
anim.show()
