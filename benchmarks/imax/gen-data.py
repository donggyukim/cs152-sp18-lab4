import random

SIZE = 10000

l = [random.getrandbits(32) for i in range(SIZE)]
m = max(l)
i = [i for i, e in enumerate(l) if e == m]
assert len(i) == 1

def print_arr(array_type, array_name, array_sz, pyarr):
  print "{} {}[{}] = ".format(array_type, array_name, array_sz)
  print "{"
  print ", ".join(map(str, pyarr))
  print "};"


print "#define SIZE {}".format(SIZE)
print "double max = {};".format(m)
print "int idx = {};".format(i[0])
print_arr("double", "input_data", "SIZE", l)
