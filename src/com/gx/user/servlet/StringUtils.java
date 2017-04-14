package com.gx.user.servlet;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtils
{
  private static final Object EMPTY_STRING = "";
  private static final Map<Object, String> conversionMap = new HashMap();
  
  public static String getConversionValue(Object valueOfMessage)
  {
    return (String)conversionMap.get(valueOfMessage);
  }
  
  public static boolean isEmpty(String value)
  {
    if ((value == null) || (EMPTY_STRING.equals(value))) {
      return true;
    }
    return false;
  }
  
  public static String evaluate(String template, Properties prop)
  {
    Pattern pattern = Pattern.compile("\\$\\{(.+?)\\}");
    Matcher matcher = pattern.matcher(template);
    
    StringBuilder builder = new StringBuilder();
    int i = 0;
    while (matcher.find())
    {
      String replacement = (String)prop.get(matcher.group(1));
      builder.append(template.substring(i, matcher.start()));
      if (replacement == null) {
        builder.append(matcher.group(0));
      } else {
        builder.append(replacement);
      }
      i = matcher.end();
    }
    builder.append(template.substring(i, template.length()));
    return builder.toString();
  }
  
  public static BigDecimal strToBigDecimal(String str, String pe)
  {
    BigDecimal bigDecimal = null;
    try
    {
      if (!isEmpty(str)) {
        bigDecimal = new BigDecimal(str);
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
      throw new RuntimeException(pe + "=" + str + "����������������error");
    }
    return bigDecimal;
  }
  
  public static long strToLong(String str)
  {
    long l = 0L;
    if (!isEmpty(str)) {
      l = Long.parseLong(str);
    }
    return l;
  }
  
  public static boolean isNotNullAll(String... strings)
  {
    boolean isNotNullAll = true;
    if (strings == null) {
      return false;
    }
    for (int i = 0; i < strings.length; i++) {
      if (isEmpty(strings[i]))
      {
        isNotNullAll = false;
        break;
      }
    }
    return isNotNullAll;
  }
  
  public static boolean isNullAll(String... strings)
  {
    boolean isNullAll = true;
    if (strings == null) {
      return true;
    }
    for (int i = 0; i < strings.length; i++) {
      if (!isEmpty(strings[i]))
      {
        isNullAll = false;
        break;
      }
    }
    return isNullAll;
  }
  
  public static String BigDecimalToStr(BigDecimal csId)
  {
    String str = null;
    try
    {
      if (csId != null) {
        str = csId.toString();
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return str;
  }
  
  public static String nullToEmpty(String str)
  {
    if ("null".equals(str)) {
      str = "";
    }
    return str;
  }
  
  public static Double strToDouble(String version)
  {
    Double str = null;
    try
    {
      if (version != null) {
        str = new Double(version);
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return str;
  }
  
  public static boolean isNumber(String number)
  {
    if (number.matches("\\d+.?\\d*")) {
      return true;
    }
    return false;
  }
  
  public static String stringTrim(String srcStr)
  {
    String desStr = null;
    if (isEmpty(srcStr)) {
      desStr = srcStr;
    } else {
      desStr = srcStr.trim();
    }
    return desStr;
  }
}
