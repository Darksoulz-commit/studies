import argparse
 
p = argparse.ArgumentParser()
p.add_argument('num', type = int)

args=p.parse_args()

for i in range(1,11):
    print(f'{i} * {args.num} = {args.num * i}')