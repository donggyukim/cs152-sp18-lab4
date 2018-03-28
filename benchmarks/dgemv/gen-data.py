import numpy as np

ROW_SIZE = 100
COL_SIZE = 50

A = np.random.random_integers(0, 1000, [ROW_SIZE, COL_SIZE])
x = np.random.random_integers(0, 1000, [COL_SIZE,])
y = np.dot(A, x)

def print_arr(array_type, array_name, array_sz, pyarr):
  print "{} {}[{}] = ".format(array_type, array_name, array_sz)
  print "{"
  print ", ".join(map(str, pyarr))
  print "};"


print "#define ROW_SIZE {}".format(ROW_SIZE)
print "#define COL_SIZE {}".format(COL_SIZE)
print "#define DATA_SIZE {}".format(ROW_SIZE * COL_SIZE)

print_arr("double", "input_data_A", "DATA_SIZE", A.flatten())
print_arr("double", "input_data_x", "COL_SIZE", x.flatten())
print_arr("double", "output_data_y", "ROW_SIZE", y.flatten())
