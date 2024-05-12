x = 1:20;
for i = x
    y(i) = fib(i);
    l(i) = 2^(0.5*i);
    u(i) = 2^(0.7*i);
end, 

plot(x,y, 'r', x, l, 'b*', x, u, 'go')
legend('fib(i)', '2^{0.5i}', '2^{0.7i}', 'FontSize', 20)