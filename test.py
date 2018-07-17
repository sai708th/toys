import random

#-----------------------------------
# arithmetic
#-----------------------------------
def factorial(n):
    if n == 1:
        return 1
    else:
        return n*factorial(n-1)

def gcd(a, b):
    while b:
        a, b = b, a%b
    return a

def lcm(a, b):
    return (a*b) // gcd(a,b)

def extended_euclid(a,b): # x,y,g s.t. ax+by=g=gcd(a,b)
    s, olds = 0, 1
    t, oldt = 1, 0
    r, oldr = b, a
    while r != 0:
        q = oldr // r
        oldr, r = r, oldr - q*r
        olds, s = s, olds - q*s
        oldt, t = t, oldt - q*t
    return (olds, oldt, oldr) 


#-----------------------------------
# perfect power check
#-----------------------------------
def primes(n): # sieve of eratosthenes
    i, p, ps, m = 0, 3, [2], n // 2
    sieve = [True] * m
    while p <= n:
        if sieve[i]:
            ps.append(p)
            for j in range((p*p-3)//2, m, p):
                sieve[j] = False
        i, p = i+1, p+2
    return ps

def is_prime(n): # miller rabin prime test
    if n == 2: return True
    if n == 1 or n & 1 == 0: return False

    d = (n - 1) >> 1
    while d & 1 == 0:
        d >>= 1

    for k in range(100):
        a = random.randint(1, n - 1)
        t = d
        y = pow(a, t, n)

        while t != n - 1 and y != 1 and y != n - 1:
            y = (y * y) % n
            t <<= 1

        if y != n - 1 and t & 1 == 0:
            return False

    return True

def iroot(k, n): # assume n > 0
    u, s, k1 = n, n+1, k-1
    while u < s:
        s = u
        u = (k1 * u + n // u ** k1) // k
    return s

def ilog(b, n): # max e where b**e <= n
    lo, blo, hi, bhi = 0, 1, 1, b
    while bhi < n:
        lo, blo, hi, bhi = hi, bhi, hi+hi, bhi*bhi
    while 1 < (hi - lo):
        mid = (lo + hi) // 2
        bmid = blo * pow(b, (mid - lo))
        if n < bmid: hi, bhi = mid, bmid
        elif bmid < n: lo, blo = mid, bmid
        else: return mid
    if bhi == n: return hi
    return lo

def isPerfectPower(n): # x if n == x ** y, or False
    for p in primes(ilog(2,n)):
        x = iroot(p, n)
        if pow(x, p) == n: return x
    return False

def get_k(n,c):
    k, i = 1, 1
    while k <= n**c:
        k, i = lcm(k,i), i+1 
    return k

#-----------------------------------
# p-1 method
#-----------------------------------
def p_minus_1(n,c):
    k = get_k(n,c)
    tmp, last = 1, 2
    while k > 0:
        k, t = k//2, k%2
        if t == 1:
            tmp = (tmp*last) % n
        last = (last*last) % n

    return gcd(n, tmp-1)

def factorization_smaller_than_10000(n):
    i = 2
    factors = []
    while i<10000:
        while n>1 and n % i == 0:
            n //= i
            factors.append(i)
        i += 1

    return (n, factors)


def factorization_pminus1(n):
    (n, factors) = factorization_smaller_than_10000(n)
    c = 1
    while n > 1 and c < 1000:
        a = p_minus_1(n, 1)
        if 1 < a and a < n:
            n //= a
            (n2, factors2) = factorization_pminus1(a)
            if n2 == -1:
                return (-1, [])
            factors.extend(factors2)
            c = 1
        else:
            c += 1

    factors.append(n)
    return (1, factors)

#-----------------------------------
# elliptic curve method
#-----------------------------------
def double_pt_on_EC(b,x,y,n):
    (inv, _, g) = extended_euclid(2*y,n)
    inv %= n
    if g > 1:
        return False
    lmd = (3*x*x+b) * inv 
    lmd %= n
    x3 = lmd*lmd - 2*x
    x3 %= n
    y3 = lmd*(x-x3)-y
    y3 %= n
    return (x3,y3)

def addition_pts_on_EC(b,x1,y1,x2,y2,n):
    (inv, _, g) = extended_euclid(x2-x1,n)
    inv %= n
    if g > 1:
        return False
    lmd = (y2-y1)*inv 
    lmd %= n
    x3 = lmd*lmd - x1 - x2
    x3 %= n
    y3 = lmd*(x1-x3)-y1
    y3 %= n
    return (x3,y3)


def scalar_bai_pt_on_EC(b,x,y,k,n):
    tmpx, tmpy = False, False
    while k > 0:
        k, t = k//2, k%2
        if t == 1:
            if tmpx == False:
                tmpx, tmpy = x, y
            else:
                res = addition_pts_on_EC(b,x,y,tmpx,tmpy,n)
                if res == False:
                    return gcd(tmpx-x,n)
                (tmpx,tmpy) = res
        
        res = double_pt_on_EC(b,x,y,n)
        if res == False:
            return gcd(y, n)
        (x, y) = res

    return False

def factorization_elliptic_curve(n):
    #Step1
    (n, factors) = factorization_smaller_than_10000(n)
    if is_prime(n) == True:
        factors.append(n)
        return (1, factors)
    root = isPerfectPower(n) 
    if root:
        while n > 1:
            n //= root
            factors.append(root)
        return (1, factors)

    c = 1
    while n > 1 and c < 1000:
        #Step2,3
        b = random.randrange(1,n)    
        x = random.randrange(1,n)    
        y = random.randrange(1,n)    
        c = y*y - x*x*x - b*x

        #Step4
        tmpgcd = gcd(4*b*b*b+27*c*c,n)
        if tmpgcd==n:
            continue
        elif tmpgcd > 1:
            (n2, factors2) = factorization_elliptic_curve(tmpgcd)
            if n2 == -1:
                return (-1, [])
            factors.extend(factors2)

            n //= tmpgcd
            if is_prime(n) == True:
                factors.append(n)
                return (1, factors)

            continue

        k = get_k(n,1)
        res = scalar_bai_pt_on_EC(b,x,y,k,n)
        if res == False:
            continue

        (n2, factors2) = factorization_elliptic_curve(res)
        if n2 == -1:
            return (-1, [])
        else:
            factors.extend(factors2)
            n //= res

        if is_prime(n) == True:
            factors.append(n)
            return (1, factors)

        
    factors.append(n)
    return (1, factors) 

        






#-----------------------------------
# main
#-----------------------------------
if __name__ == '__main__':
    import sys
    n = int(sys.argv[1])
    for i in range(n, n+20):
        res = factorization_elliptic_curve(i)
        print(i, res)




