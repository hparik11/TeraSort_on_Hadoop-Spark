import random
import string
import os
import time
from multiprocessing import Process, Lock


# http://codexpi.com/merge-sort-python-iterative-recursive-implementations/  #

def merge_sort(alist):
    for j in range(1, len(alist)):
        j *= 2
        for i in range(0, len(alist), j):
            left = alist[i:(i + (j / 2))]
            right = alist[i + (j / 2):j - i]
            l = m = 0

            while l < len(left) and m < len(right):
                if left[l] < right[m]:
                    m += 1
                elif left[l] > right[m]:
                    left[l], right[m] = right[m], left[l]
                    l += 1
            alist[i:i + (j / 2)], alist[i + (j / 2):j - i] = left, right

        return alist


def Do_Sorting_Thread(f):
    m = 0
    for cnt, i in enumerate(f.readlines()):
        
	dictn[i[:10]] = i[10:]

        if cnt % lines == 0:
            a = []
            c = 0
            a.append(i[:10])
            c += 1
            mutex.acquire()
            fp = open("./Split_Files/File_" + str(m) + ".txt", "wb")
            m += 1
            mutex.release()

        else:

            if c < (lines - 1):
                a.append(i[:10])

            else:
                a.append(i[:10])
                for i in merge_sort(a):
                    fp.write(i + "\n")
                fp.close()

            c += 1

    files = []

    for filess in os.listdir("./Split_Files/"):
        if filess.endswith(".txt"):
            files.append(filess)

    alist = []

    for i in files:
        fl = open("./Split_Files/" + i, "r")
        alist.extend(fl.read().split("\n"))
        fl.close()

    alist = list(set(filter(None, alist)))

    alist = merge_sort(alist)

    out = open('output_100gb.txt', 'w')

    for cnt, i in enumerate(alist):
        out.write(i + dictn[i])

    out.close()
    print alist


if __name__ == '__main__':

    dictn = dict()

    mutex = Lock()

    starttime = time.time()

    file = open('./Data/100gb_data.txt', 'rb')

    buffer = 1000
    filesize = os.stat('./Data/100gb_data.txt').st_size
    threads = [1,2,4,8]
    lines = filesize / (buffer * 10)

    for i in threads:
        t = Process(target=Do_Sorting_Thread, args=(filesize/i,))
        t.start()
	t.join()

    file.close()

    endtime = time.time()

    #print 'Start Time:', starttime
    #print 'End Time:', endtime

    for i in threads:
   	print "#"*30
    	print " Time Elapsed by "+ str(i) + "Thread(s) = "+ str(endtime - starttime) + " seconds"
        print "#"*30

    folder = './Split_Files'

    files = [ f for f in os.listdir("./Split_Files") if f.endswith(".txt") ]

    for f in files:
        file_path = os.path.join(folder, f)
        os.unlink(file_path)


