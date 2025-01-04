import argparse
 
parser = argparse.ArgumentParser()
parser.add_argument('cel',type=float)
parser.add_argument('operation', type=str,choices=['c','f'])

args = parser.parse_args()

if args.operation == 'c':
    print(args.cel*(9/5)+32)
elif args.operation == 'f':
    print((args.cel-32)*(5/9))
