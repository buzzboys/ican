import csv
import subprocess
import os

runMode = "train"
classes = ["Bottle"]

with open('class-descriptions-boxable.csv', mode='r', encoding='UTF-8') as infile:
    reader = csv.reader(infile)
    dict_list = {rows[1]:rows[0] for rows in reader}

for ind in range(0, len(classes)):

    className = classes[ind]
    
    subprocess.run(['rmdir', '/S/Q', className], shell=True)
    subprocess.run(['mkdir', className], shell=True)

    subprocess.run(['rmdir', '/S/Q', className + '_labels'], shell=True)
    subprocess.run(['mkdir', className + '_labels'], shell=True)

    print("Class " + str(ind) + " : " + className)

    commandStr = "findstr " + dict_list[className][3:] + " " + "oidv6-" + runMode + "-annotations-bbox.csv"
    print(commandStr)
    class_annotations = subprocess.run(commandStr.split(), stdout=subprocess.PIPE, shell=True).stdout.decode('utf-8')
    class_annotations = class_annotations.splitlines()

    totalNumOfAnnotations = len(class_annotations)
    print("Total number of annotations : "+str(totalNumOfAnnotations))

    cnt = 0
    for line in class_annotations[0:totalNumOfAnnotations]:
        cnt = cnt + 1
        print("annotation count : " + str(cnt))
        lineParts = line.split(',')
        subprocess.run([ 'aws', 's3', '--no-sign-request', '--only-show-errors', 'cp', 's3://open-images-dataset/'+runMode+'/'+lineParts[0]+".jpg", 'Bottles/'+lineParts[0]+".jpg"], shell=True)
        with open(className + '_labels/%s.txt'%(lineParts[0]),'a') as f:
            f.write(' '.join([str(ind),str((float(lineParts[5]) + float(lineParts[4]))/2), str((float(lineParts[7]) + float(lineParts[6]))/2), str(float(lineParts[5])-float(lineParts[4])),str(float(lineParts[7])-float(lineParts[6]))])+'\n')





