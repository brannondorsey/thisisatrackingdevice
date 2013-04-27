import java.util.Calendar;
import java.text.ParseException;

// your strings in ISO8601 format
// see the wikipedia page on 8601 for more info on the symbols
// http://en.wikipedia.org/wiki/ISO_8601
String dateString0 = "2013-04-23T05:12:56Z";
String dateString1 = "2013-04-23T11:12:55Z";

void setup() {
  // their parse, object form
  //http://docs.oracle.com/javase/6/docs/api/java/util/Calendar.html
  // calendar objects are very useful
  Calendar date0 = null;
  Calendar date1 = null;

  try {
    date0 = ISO8601.toCalendar(dateString0);
    date1 = ISO8601.toCalendar(dateString1);
  } 
  catch(ParseException exc) {
    exc.printStackTrace();
  }

  int diff = date1.compareTo(date0);
  println("the difference is "+diff);

  // some simple math to figure out the difference.
  long time1 = date0.getTimeInMillis();
  long time2 = date1.getTimeInMillis();

  long timeDiffInMilliseconds;
  if (time1 >= time2) {
    timeDiffInMilliseconds = time1 - time2;
  }
  else timeDiffInMilliseconds = time2 - time1;
  printTimes(timeDiffInMilliseconds);
}


void printTimes(long timeDifInMilliSec ) {
  ArrayList<String> displayTime = new ArrayList<String>();
  String display = "";

  long timeDifSeconds = timeDifInMilliSec / 1000;
  long timeDifMinutes = timeDifInMilliSec / (60 * 1000);
  long timeDifHours = timeDifInMilliSec / (60 * 60 * 1000);
  long timeDifDays = timeDifInMilliSec / (24 * 60 * 60 * 1000);
  
  String dayText;
  String hourText;
  String minuteText;
  
  if(timeDifDays >= 1){
    timeDifHours -= 24*timeDifDays;
    dayText = (timeDifDays == 1) ? " day":" days"; 
    displayTime.add(" "+timeDifDays+dayText);
  }
  if(timeDifHours >= 1){
    timeDifMinutes -= 60*timeDifHours;
    hourText = (timeDifHours == 1) ? " hour":" hours"; 
    displayTime.add(" "+timeDifHours+hourText);
  }
  if(timeDifMinutes >= 1){
    timeDifMinutes -= 24*60*timeDifDays;
    minuteText = (timeDifMinutes == 1) ? " minute":" minutes"; 
    displayTime.add(" "+timeDifMinutes+minuteText);
  }
  println("displayTime.size() is "+displayTime.size());
  for (int j = 0; j < displayTime.size(); j++) {
    String field = displayTime.get(j);
    display+=field;
  }
  if(display.length() == 0) display = "less than a second";
  else display = display.substring(1); //removes whitespace character at the beginning 
  println(display);
//  System.out.println("Time differences expressed in various units are given below");
//  System.out.println(timeDifSeconds + " Seconds");
//  System.out.println(timeDifMinutes + " Minutes");
//  System.out.println(timeDifHours + " Hours");
//  System.out.println(timeDifDays + " Days");
}

// There is a LOT more math you can do with calendar objects.
// You can also do a lot of comparisons.  You'll find more
// in the documentation and in tutorials online.

// CB

