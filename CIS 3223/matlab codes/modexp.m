function [res] = modexp(x, y, N)
% Input: Two positive integers x and N,a non-negative integer exponent y
% Output: x^y (mod N)

if y == 1
    res = 1;
end

power = x;
z = 1;

while y > 0
    
    digit = mod(y, 2);
    if digit == 1
        z = mod(power * z, N);
    end
    
    y = floor(y/2);
    power = mod(power^2, N);
        
    if power == 1
        break % z is fixed 
    end
      
end;

res = z;

end
