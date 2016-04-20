
from pyspark import SparkContext
import sys



if(len(sys.argv) < 3 ):
    print "Use spark_sort.py inputPath outputPath"
    sys.exit(1);

sc = SparkContext("local","Spark Sort")
        # Read input and output path

inputPath = sys.argv[1]

print ('Path of input file ->' + inputPath)

outputPath = sys.argv[2]

print ('Path of output file ->' + outputPath)

distFile = sc.textFile(inputPath)

def flatMap(line):
    return line.split("\n")

def map(word):
    return (str(word[:10]),str(word[10:]))

def reduce(a,b):
    print "*"*50
    #print type(a)," & " ,type(b)
    print "Value of B is ", (b[0]+b[1])

    return (a,b)


counts = distFile.flatMap(flatMap).map(map).sortByKey().reduce(reduce)
#print counts
counts.saveAsTextFile(outputPath)


