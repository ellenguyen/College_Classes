% y = base2(x)
%  Returns the binary representation of the positive integer x

function lst = base2(x)

lst = []; 

if not(isa(x, 'numeric'))
    return
elseif x < 0 | ceil(x) > x
    return
end

lst = [];
while x > 0
    % x = 2*floor(x/2) + mod(x, 2)
    digit = mod(x, 2);
    lst = [digit lst];
    x = floor(x/2);
end

end
   