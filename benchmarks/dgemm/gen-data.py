import numpy as np

SIZE = 43

A = np.random.random_integers(0, 1000, [SIZE, SIZE])
B = np.random.random_integers(0, 1000, [SIZE, SIZE])
C = np.dot(A, B)

def print_arr(array_type, array_name, array_sz, pyarr):
  print "{} {}[{}] = ".format(array_type, array_name, array_sz)
  print "{"
  print ", ".join(map(str, pyarr))
  print "};"


print "#define DATA_SIZE {}".format(SIZE)

print_arr("double", "input_data_A", "DATA_SIZE*DATA_SIZE", A.flatten())
print_arr("double", "input_data_B", "DATA_SIZE*DATA_SIZE", B.flatten())
print_arr("double", "output_data_C", "DATA_SIZE*DATA_SIZE", C.flatten())
