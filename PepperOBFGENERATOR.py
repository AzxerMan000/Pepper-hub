import random

def ascii_to_random_numeric_slash(text):
    result = []
    for char in text:
        ascii_val = ord(char)
        parts = []
        while ascii_val > 0:
            chunk = random.choice([10, 18, 28])  # fixed chunk options
            if ascii_val - chunk >= 0:
                parts.append(str(chunk))
                ascii_val -= chunk
            else:
                parts.append(str(ascii_val))
                ascii_val = 0
        random.shuffle(parts)  # shuffle chunks per char for randomness
        result.append("/".join(parts))
    return "/".join(result)

# Example usage
input_text = 'print("Hello")'
obfuscated = ascii_to_random_numeric_slash(input_text)
print(obfuscated)
