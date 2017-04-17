package com.gx.utils;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

public class JsonUtils
{
  private static ObjectMapper objectMapper = new ObjectMapper();
  private static JsonFactory jsonFactory = new JsonFactory();
  
  public static Map<String, Object> jsonToMap(String jsonStr)
  {
    Map<String, Object> map = new HashMap();
    try
    {
      map = (Map)objectMapper.readValue(jsonStr, Map.class);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return map;
  }
  
  public static List<Object> jsonToList(String jsonStr)
    throws IOException
  {
    List<Object> list = (List)objectMapper.readValue(jsonStr, List.class);
    return list;
  }
  
  public static String MapToJson(Map<String, Object> map)
  {
    StringWriter sw = new StringWriter();
    try
    {
      JsonGenerator jg = jsonFactory.createJsonGenerator(sw);
      jg.useDefaultPrettyPrinter();
      objectMapper.writeValue(jg, map);
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
    return sw.toString();
  }
  
  public static String ObjectToJson(Object obj)
    throws JsonMappingException, JsonGenerationException, IOException
  {
    StringWriter sw = new StringWriter();
    JsonGenerator jg = jsonFactory.createJsonGenerator(sw);
    jg.useDefaultPrettyPrinter();
    objectMapper.writeValue(jg, obj);
    return sw.toString();
  }
}
