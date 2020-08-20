n_bits_max = 20;
multiplicity = zeros(1,n_bits_max/2);
for j = 1:n_bits_max/2
    % Increase with two bits at a time
    nbits = 2*j;
    % All possible combinations for a given number of bits
    all_combinations = dec2bin(0:2^nbits-1);
    % Floating point calculation
    % No sign bit
    % Same size of exponent and significand
    % see e.g. https://en.wikipedia.org/wiki/Single-precision_floating-point_format
    % Take first half as the exponent
    exponent = all_combinations(:,1:nbits/2);
    % Take second half as as the significand    
    significand = all_combinations(:,nbits/2+1:end);
    % Do the calculations
    offset = 2^(nbits/2-1)-1;
    factor = 2^(-nbits/2);
    numbers = 2.^(bin2dec(exponent)-offset).*bin2dec(significand)*factor;
    % Find the number of numbers within a certain interval
    multiplicity(j) = sum(numbers > 1/137/1.1 & numbers < 1/137*1.1);
end

fractionality = 2.^(-2*(1:n_bits_max/2));
probability = multiplicity .* fractionality;
bits = 2:2:n_bits_max;

subplot(3,1,1)
plot(bits,fractionality)
title('fractionality')

subplot(3,1,2)
plot(bits,multiplicity)
title('multiplicity')

subplot(3,1,3)
plot(bits,probability)
title('probability = frationality * multiplicity')
xlabel('bits')




