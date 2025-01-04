import argparse
 
parser = argparse.ArgumentParser()
parser.add_argument('cel',type=float)

args = parser.parse_args()

print(args.cel*(9/10)+32)

