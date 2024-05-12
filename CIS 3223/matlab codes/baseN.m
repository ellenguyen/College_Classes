% y = baseN(x, N)
% Input: A positive integer x
% Output: The base-N representation of x

function lst = baseN(x, N)

if not(isa(x, 'numeric'))
    return
elseif x < 0 | ceil(x) > x
    return
end

n = floor(log(x)/log(N))+1;   % number of digits base-N
lst = zeros(1, n);

for idx = n:-1:1
    % x = 2*floor(x/N) + mod(x, N)
    digit = mod(x, N);
    lst(idx) = digit;
    x = floor(x/N);
end

end