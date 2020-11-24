import os
import sys


def get_label_ids(label_dir):
    IDs = set()
    files = os.listdir(label_dir)
    for f in files:
        if(f.split(".")[1] == "txt"):
            # print(file)
            with open(label_dir + "/" + f, 'rt') as txt:
                for line in txt:
                    IDs.add(line[0])
    return IDs

def change_label_id(label_dir):
    print(f"Your original IDs values are: {get_label_ids(label_dir)}")
    files = os.listdir(label_dir)
    while True:
        orginal_id = input("Input ID You Want Changed: ")
        target_id = input("Input ID You Want Change To: ")
        print()

        for f in files:
            if(f.split(".")[1] == "txt"):
                f = label_dir + "/" + f
            with open(f, 'rt') as txt:
                buffer = ""
                for line in txt:
                    if line[0] == orginal_id:
                        buffer += target_id + line[1:]
                    else:
                        buffer += line
                    # print(buffer)
                with open(f, 'wt') as new_txt:
                    new_txt.write(buffer)
        print(f"Your changed IDs values are: {get_label_ids(label_dir)}")


try:
    change_label_id(sys.argv[1])
except Exception as e:
    change_label_id(input("Input Label Dir: "))