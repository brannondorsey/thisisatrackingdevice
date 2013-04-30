class TimeHandler {

  TimeHandler() {
  }

  String getTime(String timestamp) {
    String time;
    try {
      Calendar date = ISO8601.toCalendar(timestamp);
      time = ISO8601.fromCalendar(date);
      time = time.replace("T", " ");
      time = time.replace("-05:00", "");
      int monthStart = time.indexOf("-");
      String monthNum = time.substring(monthStart+1, monthStart+3);
      String monthName = getMonth(monthNum);
      String dayTime = time.substring(8);
      int dayNum = int(dayTime.substring(0,2));
      int hourNum = int(dayTime.substring(3,5));
      String minutes = dayTime.substring(6,8);
      println("the hour number is "+hourNum);
      time = time.substring(11, 16);
      String period;
      if(hourNum >= 12){
        hourNum -= 12;
        if(hourNum == 0) hourNum = 1;
        period = "PM";
      }
      else{
        if(hourNum == 0) hourNum = 12;
        period = "AM";
      }
      
      String outputTime = monthName+" "+dayNum+" "+hourNum+":"+minutes+" "+period;
      return outputTime;
    }
    catch(ParseException exc) {
      exc.printStackTrace();
      return "not converting time properly.";
    }
  }

  String getDiffString(String dateString1, String dateString2) {

    Calendar date1 = null;
    Calendar date2 = null;

    try {
      date1 = ISO8601.toCalendar(dateString1);
      date2 = ISO8601.toCalendar(dateString2);
    } 
    catch(ParseException exc) {
      exc.printStackTrace();
    }

    // some simple math to figure out the difference.
    long time1 = date1.getTimeInMillis();
    long time2 = date2.getTimeInMillis();

    long timeDiffInMilliseconds;
    if (time1 >= time2) {
      timeDiffInMilliseconds = time1 - time2;
    }
    else timeDiffInMilliseconds = time2 - time1;
    //printTimes(timeDiffInMilliseconds);
    long timeDifInMilliSec = timeDiffInMilliseconds;
    ArrayList<String> displayTime = new ArrayList<String>();
    String display = "";

    long timeDifSeconds = timeDifInMilliSec / 1000;
    long timeDifMinutes = timeDifInMilliSec / (60 * 1000);
    long timeDifHours = timeDifInMilliSec / (60 * 60 * 1000);
    long timeDifDays = timeDifInMilliSec / (24 * 60 * 60 * 1000);

    String dayText;
    String hourText;
    String minuteText;

    if (timeDifDays >= 1) {
      timeDifHours -= 24*timeDifDays;
      dayText = (timeDifDays == 1) ? " day":" days"; 
      displayTime.add(" "+timeDifDays+dayText);
    }
    if (timeDifHours >= 1) {
      timeDifMinutes -= 60*timeDifHours;
      hourText = (timeDifHours == 1) ? " hour":" hours"; 
      displayTime.add(" "+timeDifHours+hourText);
    }
    if (timeDifMinutes >= 1) {
      timeDifMinutes -= 24*60*timeDifDays;
      minuteText = (timeDifMinutes == 1) ? " minute":" minutes"; 
      displayTime.add(" "+timeDifMinutes+minuteText);
    }
    println("displayTime.size() is "+displayTime.size());
    for (int j = 0; j < displayTime.size(); j++) {
      String field = displayTime.get(j);
      display+=field;
    }
    if (display.length() == 0) display = "less than a second";
    else display = display.substring(1); //removes whitespace character at the beginning 
    return display;
  }
  
  String getMonth(String monthChars) {
    int monthNum = int(monthChars);
    String monthName;
    switch(monthNum) {
    case 1:
      monthName = "January";
      break;
    case 2:
      monthName = "February";
      break;
    case 3:
      monthName = "March";
      break;
    case 4:
      monthName = "April";
      break;
    case 5:
      monthName = "May";
      break;
    case 6:
      monthName = "June";
      break;
    case 7:
      monthName = "July";
      break;
    case 8:
      monthName = "August";
      break;
    case 9:
      monthName = "September";
      break;
    case 10:
      monthName = "October";
      break;
    case 11:
      monthName = "November";
      break;
    case 12:
      monthName = "December";
      break;
    default:
      monthName = "January";
    } 
    return monthName;
  }
}

