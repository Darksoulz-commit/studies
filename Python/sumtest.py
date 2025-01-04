import sys

# Get the arguments from the command line
a = sys.argv[1]
b = sys.argv[2]
print(a, b)

# Define the add function with two parameters
def add(a, b):
    c = int(a) + int(b)
    print(c)

# Call the add function with the arguments
add(a, b)
