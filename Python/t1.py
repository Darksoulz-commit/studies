import argparse
 
parser = argparse.ArgumentParser()
parser.add_argument('filename',help='enter a file name to open')
parser.add_argument('-c','--copy',type=int,help='make n copies of file')
parser.add_argument('-s','--something',action='store_const',const=5)
parser.add_argument('-t','--true',action='store_true')
args=parser.parse_args()
print(args)
print(args.filename)
print(args.copy)
