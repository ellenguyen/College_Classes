function res = karat(x, y)




if x < 9 || y < 9
    res = x * y;
    return
end

str_x = num2str(x);
str_y = num2str(y);

n = max(length(str_x), length(str_y));
m = ceil(n/2);

xL = str2num(str_x(1:m));
xR = str2num(str_x(m+1:end));

yL = str2num(str_y(1:m));
yR = str2num(str_y(m+1:end));

A = karat(xL, yL);
B = karat(xR, yR);
C = karat(xL + xR, yL + yR);
D = C - A - B;

res = A * power(10, 2*m) + D * power(10, m) + B; 

end
   