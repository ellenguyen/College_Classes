function [d, x, y] = extendedEuclid_vpi(a, b)
% Input: Two positive integers a and b
% Output: Integers d, x, y such that d = gcd(a, b) 
%   and ax + by = d




q = floor(a/b);
r = vpi(a - b*q);
Q = [0 1; 1 -q];

while r > 0
    a = b;
    b = r;
    q = vpi(a/b);
    r = vpi(a - b*q);
    Q = [0 1; 1 -q]*Q;
    
end

d = b; 
x = Q(1,1); 
y = Q(1,2);
    
end