% RSA example using VPI

clc
clear

prompt = 'Enter message ==> ';

message = input(prompt, 's')

fprintf('\n'); 


p = 41

q = 43

fprintf('\n');

N = p*q

fprintf('\n');

pN = (p-1)*(q-1)

e = 13          % encode key

% message = 'ET phone home'

M = message + 0
n = length(M);

E(1:n) = 0;

tic;
for k = 1:n
    E(k) = modexp(M(k), e, N);
end


encoding = [M; E]'    % encoded message
fprintf('\n'); toc

fprintf('\n\n')

[x, s, t] = extendedEuclid(e, pN);

d = mod(s, pN)	% decode key

fprintf('\n')

U(1:n) = 0; 

tic;
for k = 1:n
    U(k) = modexp(E(k), d, N);
end

U

toc

fprintf('\n')

decoded = char(U)        % decoded message

