import getopt
import sys

recLength = 170
debug = False


def usage():
    print("""
usage: SRAV_to_TXT [options] in.txt out.txt
                options:
                                -d            Turn on debug messages
---
"""
          )
    exit(2)


try:
    opts, args = getopt.getopt(sys.argv[1:], 'd')
    debug = dict(opts).setdefault('d', False)
except getopt.GetoptError as err:
    usage()

if len(args) != 2:
    usage()

try:
    IN = open(args[0], 'rb')
    OUT = open(args[1], 'w')

    while True:
        d = IN.read(recLength)
        if not d: break
        d = d.decode('cp037', 'replace')
        if d[0:2] == '47':
            OUT.write(d[19:140 + 19].rstrip() + '\n')

except FileNotFoundError as e:
    print("File {} does not exist".format(e.filename))
