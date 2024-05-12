function [q r] = divide(x, y)

% Input: Two positive integers x and y
% Output: The quotient and remainder of x divided by y
% Usage: [q,r] = divide(x, y)

digit = dec2bin(x);
n = length(digit);       % n = floor(log2(x)) + 1 

q = 0; r = 0;

for i = 1:n              % n iterations
    q = 2*q;             % 0(n) operation since q <= x
    r = 2*r;             % 0(n) operation since r <= x
    if digit(i) == '1'
        r = r + 1;
    end
    if r >= y
        q = q+1;         % 0(n) operation
        r=r-y;           % 0(n)) operation
    end
% Loop invariant:  [digit[1] digit(2)...digit(i}] = q*y + r
end

end
        