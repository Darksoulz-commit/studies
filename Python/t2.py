import argparse
 
parser = argparse.ArgumentParser()
parser.add_argument('num1',type=float,help='first number')
parser.add_argument('num2',type=float,help='second number')
parser.add_argument('operation',type=str,choices=['add','multiply','sub','div'])
'''
parser.add_argument('num2','--copy',type=int,help='make n copies of file')
parser.add_argument('-s','--something',action='store_const',const=5)
parser.add_argument('-t','--true',action='store_true')'''
 
 
args=parser.parse_args()
 
if args.operation == 'add':
    print(f'result :{args.num1 + args.num2}')
elif args.operation == 'sub':
    print(f'result :{args.num1 - args.num2}')
elif args.operation == 'multiply':
    print(f'result :{args.num1 * args.num2}')
elif args.operation == "div":
    try:
        print(f'result :{args.num1/args.num2}')
    except ZeroDivisionError as e:
        print("zero should not be given to num2")
   
'''
print(args)
print(args.filename)
print(args.copy)'''