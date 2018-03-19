import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.alibaba.druid.support.json.JSONUtils;
import com.hanthink.report.util.JsonUtil;

public class Main {

	public static void main(String[] args) throws Exception{
		  Date date = new SimpleDateFormat("yyyy-MM-dd").parse("2005-06-09"); 
		  String now = new SimpleDateFormat("yyyy-MM-dd").format(date);
		  System.out.println(now);
		 }

}
