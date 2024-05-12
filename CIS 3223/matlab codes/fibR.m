function y = fibR(n)
% Input: A positive integer n
% Output: The n-th Fibonacci number Fn

if n == 1 || n ==2
    y = 1;
    return
end

y = fibR(n-1) + fibR(n-2);
end