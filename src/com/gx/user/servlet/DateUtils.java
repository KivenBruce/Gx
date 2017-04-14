package com.gx.user.servlet;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.TimeZone;

public class DateUtils
{
  public static final long MILLIS_PER_DAY = 86400000L;
  public static final long MILLIS_PER_HOUR = 3600000L;
  public static final long MILLIS_PER_MINUTE = 60000L;
  public static final long MILLIS_PER_SECOND = 1000L;
  public static final int RANGE_MONTH_MONDAY = 6;
  public static final int RANGE_MONTH_SUNDAY = 5;
  public static final int RANGE_WEEK_CENTER = 4;
  public static final int RANGE_WEEK_MONDAY = 2;
  public static final int RANGE_WEEK_RELATIVE = 3;
  public static final int RANGE_WEEK_SUNDAY = 1;
  public static final int SEMI_MONTH = 1001;
  public static final TimeZone UTC_TIME_ZONE = TimeZone.getTimeZone("GMT");
  public static final String PATTERN_COMPACT_DATE = "yyyyMMdd";
  public static final String PATTERN_COMPACT_DATETIME_TOHOUR = "yyyyMMddHH";
  public static final String PATTERN_COMPACT_DATETIME_TOMINUTE = "yyyyMMddHHmm";
  public static final String PATTERN_COMPACT_DATETIME = "yyyyMMddHHmmss";
  public static final String PATTERN_COMPACT_FULL = "yyyyMMddHHmmssSSS";
  public static final String PATTERN_SLASH_DATE = "yyyy/MM/dd";
  public static final String PATTERN_SLASH_DATETIME = "yyyy/MM/dd HH:mm:ss";
  public static final String PATTERN_SLASH_FULL = "yyyy/MM/dd HH:mm:ss.SSS";
  public static final String PATTERN_MINUS_DATE = "yyyy-MM-dd";
  public static final String PATTERN_MINUS_DATETIME = "yyyy-MM-dd HH:mm:ss";
  public static final String PATTERN_MINUS_FULL = "yyyy-MM-dd HH:mm:ss.SSS";
  
  public static Date addDays(Date date, int amount)
  {
    return null;
  }
  
  public static Date addHours(Date date, int amount)
  {
    return null;
  }
  
  public static Date addMilliseconds(Date date, int amount)
  {
    return null;
  }
  
  public static Date addMinutes(Date date, int amount)
  {
    return null;
  }
  
  public static Date addMonths(Date date, int amount)
  {
    return null;
  }
  
  public static Date addSeconds(Date date, int amount)
  {
    return null;
  }
  
  public static Date addWeeks(Date date, int amount)
  {
    return null;
  }
  
  public static Date addYears(Date date, int amount)
  {
    return null;
  }
  
  public static long getFragmentInDays(Calendar calendar, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInDays(Date date, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInHours(Calendar calendar, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInHours(Date date, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInMilliseconds(Calendar calendar, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInMilliseconds(Date date, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInMinutes(Calendar calendar, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInMinutes(Date date, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInSeconds(Calendar calendar, int fragment)
  {
    return -1L;
  }
  
  public static long getFragmentInSeconds(Date date, int fragment)
  {
    return -1L;
  }
  
  public static boolean isSameDay(Calendar cal1, Calendar cal2)
  {
    return false;
  }
  
  public static boolean isSameInstant(Calendar cal1, Calendar cal2)
  {
    return false;
  }
  
  public static boolean isSameInstant(Date date1, Date date2)
  {
    return false;
  }
  
  public static boolean isSameLocalTime(Calendar cal1, Calendar cal2)
  {
    return false;
  }
  
  public static Iterator<Integer> iterator(Calendar focus, int rangeStyle)
  {
    return null;
  }
  
  public static Iterator<Integer> iterator(Date focus, int rangeStyle)
  {
    return null;
  }
  
  public static Iterator<Integer> iterator(Object focus, int rangeStyle)
  {
    return null;
  }
  
  public static Date parseDate(String str, String[] parsePatterns)
  {
    return null;
  }
  
  public static Calendar round(Calendar date, int field)
  {
    return null;
  }
  
  public static Date round(Date date, int field)
  {
    return null;
  }
  
  public static Date round(Object date, int field)
  {
    return null;
  }
  
  public static Date setDays(Date date, int amount)
  {
    return null;
  }
  
  public static Date setHours(Date date, int amount)
  {
    return null;
  }
  
  public static Date setMilliseconds(Date date, int amount)
  {
    return null;
  }
  
  public static Date setMinutes(Date date, int amount)
  {
    return null;
  }
  
  public static Date setMonths(Date date, int amount)
  {
    return null;
  }
  
  public static Date setSeconds(Date date, int amount)
  {
    return null;
  }
  
  public static Date setYears(Date date, int amount)
  {
    return null;
  }
  
  public static Calendar truncate(Calendar date, int field)
  {
    return null;
  }
  
  public static Date truncate(Date date, int field)
  {
    return null;
  }
  
  public static Date truncate(Object date, int field)
  {
    return null;
  }
  
  public static int caluAgeYears(Date birthDate)
  {
    int age = 0;
    if (birthDate != null)
    {
      Calendar birthDay = Calendar.getInstance();
      birthDay.setTime(birthDate);
      Calendar today = Calendar.getInstance();
      if (today.get(1) > birthDay.get(1))
      {
        age = today.get(1) - birthDay.get(1) - 
          1;
        if (today.get(2) + 1 > birthDay.get(2)) {
          age++;
        } else if (today.get(2) + 1 == birthDay.get(2)) {
          if (today.get(5) > birthDay.get(5)) {
            age++;
          }
        }
      }
    }
    return age;
  }
  
  public static String caluAge(Date birthDate, Date visitDate)
  {
    if (birthDate == null) {
      return "";
    }
    if (visitDate == null) {
      visitDate = new Date();
    }
    int years = getYearsBetween(birthDate, visitDate).intValue();
    if (years >= 1) {
      return years + "��";
    }
    int days = getDaysBetween(birthDate, visitDate).intValue();
    int months = days / 30;
    if (months != 0) {
      days %= 30 * months;
    }
    return months + " " + days + "/30��";
  }
  
  public static Integer getDaysBetween(Date startDate, Date endDate)
  {
    Calendar fromCalendar = Calendar.getInstance();
    fromCalendar.setTime(startDate);
    fromCalendar.set(11, 0);
    fromCalendar.set(12, 0);
    fromCalendar.set(13, 0);
    fromCalendar.set(14, 0);
    
    Calendar toCalendar = Calendar.getInstance();
    toCalendar.setTime(endDate);
    toCalendar.set(11, 0);
    toCalendar.set(12, 0);
    toCalendar.set(13, 0);
    toCalendar.set(14, 0);
    
    long days = (toCalendar.getTime().getTime() - fromCalendar.getTime()
      .getTime()) / 86400000L;
    if (days < 0L) {
      return Integer.valueOf(0);
    }
    return Integer.valueOf((int)days);
  }
  
  public static int getDays(int month, int year)
  {
    int days = 0;
    switch (month)
    {
    case 1: 
    case 3: 
    case 5: 
    case 7: 
    case 8: 
    case 10: 
    case 12: 
      days = 31;
      break;
    case 2: 
      if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
        days = 29;
      } else {
        days = 28;
      }
      break;
    case 4: 
    case 6: 
    case 9: 
    case 11: 
      days = 30;
    }
    return days;
  }
  
  public static Integer getYearsBetween(Date startDate, Date endDate)
  {
    Calendar fromCalendar = Calendar.getInstance();
    fromCalendar.setTime(startDate);
    fromCalendar.set(11, 0);
    fromCalendar.set(12, 0);
    fromCalendar.set(13, 0);
    fromCalendar.set(14, 0);
    
    Calendar toCalendar = Calendar.getInstance();
    toCalendar.setTime(endDate);
    toCalendar.set(11, 0);
    toCalendar.set(12, 0);
    toCalendar.set(13, 0);
    toCalendar.set(14, 0);
    
    long years = (toCalendar.getTime().getTime() - fromCalendar.getTime()
      .getTime()) / 86400000L / 365L;
    if (years < 0L) {
      return Integer.valueOf(0);
    }
    return Integer.valueOf((int)years);
  }
  
  public static Date stringToDate(String str, String formatStyle)
  {
    Date date = null;
    SimpleDateFormat sdf = null;
    try
    {
      if (!StringUtils.isEmpty(str))
      {
        sdf = new SimpleDateFormat(formatStyle);
        date = sdf.parse(str);
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return date;
  }
  
  public static String dateToString(Date targetDate, String formatStyle)
  {
    String targetStr = null;
    SimpleDateFormat sdf = null;
    try
    {
      if (targetDate != null)
      {
        if (!StringUtils.isEmpty(formatStyle)) {
          sdf = new SimpleDateFormat(formatStyle);
        } else {
          sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        }
        targetStr = sdf.format(targetDate);
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return targetStr;
  }
  
  public static Date stringToDate(String dateStr)
  {
    if (dateStr == null) {
      return null;
    }
    Date date = null;
    String formatStr = "";
    try
    {
      if (!StringUtils.isEmpty(dateStr.trim()))
      {
        int dateLen = dateStr.trim().length();
        if (dateLen == "yyyyMMdd".length()) {
          formatStr = "yyyyMMdd";
        } else if (dateLen == "yyyyMMddHH".length()) {
          formatStr = "yyyyMMddHH";
        } else if (dateLen == "yyyyMMddHHmm".length()) {
          formatStr = "yyyyMMddHHmm";
        } else if (dateLen == "yyyyMMddHHmmss".length()) {
          formatStr = "yyyyMMddHHmmss";
        } else if (dateLen == "yyyyMMddHHmmssSSS".length()) {
          formatStr = "yyyyMMddHHmmssSSS";
        }
        DateFormat sdf = new SimpleDateFormat(formatStr);
        date = sdf.parse(dateStr);
      }
    }
    catch (ParseException pe)
    {
      throw new RuntimeException("������������������" + formatStr, pe);
    }
    return date;
  }
  
  public static Date dateFormatter()
  {
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date d = new Date();
    String dd = format.format(d);
    Date ddd = null;
    try
    {
      ddd = format.parse(dd);
    }
    catch (ParseException e)
    {
      e.printStackTrace();
    }
    return ddd;
  }
  
  public static Date getSystemTime()
  {
    return new Date();
  }
  
  public static int compareDate(Date date1, Date date2)
  {
    try
    {
      if (date1.getTime() > date2.getTime()) {
        return -1;
      }
      if (date1.getTime() < date2.getTime()) {
        return 1;
      }
      return 0;
    }
    catch (Exception exception)
    {
      exception.printStackTrace();
    }
    return 0;
  }
  
  public static int getDayOfWeek(Date date)
  {
    Calendar cal = Calendar.getInstance();
    
    cal.setTime(date);
    
    int w = cal.get(7) - 1;
    if (w == 0) {
      w = 7;
    }
    return w;
  }
  
  public static String getPrevDay(int day)
  {
    String targetStr = null;
    Calendar calendar = Calendar.getInstance();
    calendar.add(5, -day);
    Date date = calendar.getTime();
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    try
    {
      targetStr = df.format(date);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return targetStr;
  }
  
  public static String getTimeBefore7()
    throws ParseException
  {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar c = Calendar.getInstance();
    c.add(5, -7);
    Date monday = c.getTime();
    String preMonday = sdf.format(monday);
    return preMonday;
  }
}
