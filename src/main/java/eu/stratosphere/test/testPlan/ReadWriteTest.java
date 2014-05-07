package eu.stratosphere.test.testPlan;

import eu.stratosphere.api.common.JobExecutionResult;
import eu.stratosphere.api.common.Plan;
import eu.stratosphere.api.common.Program;
import eu.stratosphere.api.common.accumulators.AccumulatorHelper;
import eu.stratosphere.api.common.accumulators.LongCounter;
import eu.stratosphere.api.common.operators.FileDataSink;
import eu.stratosphere.api.common.operators.FileDataSource;
import eu.stratosphere.api.java.record.functions.MapFunction;
import eu.stratosphere.api.java.record.io.CsvOutputFormat;
import eu.stratosphere.api.java.record.io.TextInputFormat;
import eu.stratosphere.api.java.record.operators.MapOperator;
import eu.stratosphere.client.LocalExecutor;
import eu.stratosphere.configuration.Configuration;
import eu.stratosphere.types.Record;
import eu.stratosphere.types.StringValue;
import eu.stratosphere.util.Collector;

/**
 * Reads data from a directory and writes it again (to test reading deflate files)
 *
 */
public class ReadWriteTest implements Program {

	public static class Counting extends MapFunction {

		LongCounter tup;
		@Override
		public void open(Configuration parameters) throws Exception {
			super.open(parameters);
			tup = getRuntimeContext().getLongCounter("tuples");
		}
		@Override
		public void map(Record record, Collector<Record> out) throws Exception {
			tup.add(1L);
			out.collect(record);
		}
		
	}
	public Plan getPlan(String... args) {
		String in = args[0];
		String out = args[1];
		int dop = Integer.parseInt(args[2]);
		
		FileDataSource src = new FileDataSource(new TextInputFormat(), in);
		MapOperator cnt = MapOperator.builder(new Counting()).input(src).build();
		FileDataSink sink = new FileDataSink(new CsvOutputFormat(StringValue.class), out);
		sink.setInput(cnt);
		Plan p = new Plan(sink, "ReadWrite Test");
		p.setDefaultParallelism(dop);
		return p;
	}

	public static void main(String[] args) throws Exception {
		ReadWriteTest sqT = new ReadWriteTest();
		JobExecutionResult res = LocalExecutor.execute(sqT.getPlan(args));
		System.err.println("Result:\n"+AccumulatorHelper.getResultsFormated(res.getAllAccumulatorResults()));
	}

}
