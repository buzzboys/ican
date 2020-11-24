import random
import os
import sys



def split_data_set(image_dir):

    f_val = open("valid.txt", 'w')
    f_train = open("train.txt", 'w')
    
    path, dirs, files = next(os.walk(image_dir))
    data_size = len(files)

    ind = 0
    data_valid_size = int(0.1 * data_size)
    valid_array = random.sample(range(data_size), k=data_valid_size)

    for f in os.listdir(image_dir):
        if(f.split(".")[1] == "jpg"):
            ind += 1
            
            if ind in valid_array:
                f_val.write(image_dir+'/'+f+'\n')
            else:
                f_train.write(image_dir+'/'+f+'\n')


try:
    split_data_set(sys.argv[1])
except Exception as e:
    split_data_set(input("Input Image Dir: "))
