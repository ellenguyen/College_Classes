function y = fib(n)
% Input: A positive integer n
% Output: The n-th Fibonacci number Fn

if n == 1 || n == 2
    y = 1;
    return
end

data = ones(1,n);


for k = 3:n
    data(k) = data(k-1) + data(k-2);
end

y = data(n);
end