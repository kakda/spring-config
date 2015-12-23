package com.mobilecnc.helper;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

import com.mobilecnc.helper.service.PropertiesService;

public class CustomDateTimeSerializer extends JsonSerializer<Date> {
	
	@Override
    public void serialize(Date value, JsonGenerator gen, SerializerProvider arg2) throws 
    IOException,JsonProcessingException{      

        SimpleDateFormat formatter = new SimpleDateFormat(PropertiesService.getProperty("datetime.format"));
        String formattedDate = formatter.format(value);
        gen.writeString(formattedDate);
    }
	

}
