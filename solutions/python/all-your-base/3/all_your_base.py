def rebase(input_base, digits, output_base):
    if input_base < 2:
        raise ValueError("input base must be >= 2")

    if output_base < 2:
        raise ValueError("output base must be >= 2")

    if any(not isinstance(digit, int) or digit not in range(input_base) for digit in digits):
        raise ValueError("all digits must satisfy 0 <= d < input base")

    if len(digits) == 0:
        return[0]
        
    base10_aux = int("".join([str(digit) for digit in digits]))
    if base10_aux <= 1:
        return  [digits[-1]]
    
    # input base to base 10
    base10 = []
    if input_base == 10:
        base10 = base10_aux
    else:
        base10 = sum([digit * (input_base ** (len(digits) - exponent - 1)) for exponent, digit in enumerate(digits)])

    # base 10 to output base
    if output_base == 10:
        return list(map(int, str(base10)))

    output = []
    divisor = base10
    while divisor > 0:
        remainder = divisor % output_base
        divisor = divisor // output_base
        output.insert(0, remainder)
        
    return output
