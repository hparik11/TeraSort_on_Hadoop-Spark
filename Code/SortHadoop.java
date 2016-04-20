import java.io.IOException;
import java.util.StringTokenizer;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import java.io.*;


public class SortHadoop{
	public static class SortingMapper extends Mapper<Object, Text, Text, Text>{

		private Text keys = new Text();
		private Text values = new Text();
		
		public void map (Object key, Text value, Context context)throws IOException, InterruptedException{
	        
		String text1 = (value.toString()).substring(1,10);
		String text2  = (value.toString()).substring(10);
		keys.set(text1);
		values.set(text2);
		context.write(keys,values);
		}
	}
	public static class SortingReducer extends Reducer<Text, Text, Text, Text>{
		
		private Text outputkey = new Text();
		private Text outputvalue = new Text();
		public void reduce (Text key, Iterable<Text> values, Context context)throws IOException, InterruptedException{
		
		outputkey = key;
		for (Text val : values){
			outputvalue = val;
		}
		context.write(outputkey,outputvalue);
		}

	}
	
	public static void main(String[] args) throws Exception{
		

		long startTime = System.currentTimeMillis();

		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, "Hadoop sort");
		job.setJarByClass(SortHadoop.class);
		job.setMapperClass(SortingMapper.class);
		job.setCombinerClass(SortingReducer.class);
		job.setReducerClass(SortingReducer.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		long endTime = System.currentTimeMillis();
		
		long totalTime = endTime - startTime;
		
		
		if (job.waitForCompletion(true))
		{
			System.out.println("Total Elapsed Time on Hadoop: " + totalTime);			
			System.exit(0);
		}

		else
		{
			System.out.println("Total Elapsed Time on Hadoop: " + totalTime);
			System.exit(1);	
		}
		

		
	}

}
