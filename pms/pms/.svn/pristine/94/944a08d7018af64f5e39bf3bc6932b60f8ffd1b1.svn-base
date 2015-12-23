package com.mobilecnc.excelView;

import java.awt.Color;
import java.io.IOException;
import java.net.MalformedURLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.lowagie.text.BadElementException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Image;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfWriter;

public class PdfStyleHelper {
	
	static public void setHeader(HttpServletRequest request,Document document,PdfWriter writer) throws BadElementException, MalformedURLException, IOException{
		String url = request.getRequestURL().toString();
		String baseURL = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
		 Image logo = Image.getInstance(baseURL + "images/mobilecnc.png");
		 logo.setAlignment(Image.MIDDLE);
		 logo.setAbsolutePosition(0, 0);
		 logo.scalePercent(40);
		 Chunk chunk = new Chunk(logo, 0, 0);
		 HeaderFooter header = new HeaderFooter(new Phrase(chunk), false);
		 header.setBorder(Rectangle.BOTTOM);
		 document.setHeader(header);
	}
	
	static public void setFooter(Document document,PdfWriter writer){
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd");
		HeaderFooter footer = new HeaderFooter(new Phrase("Date: " + df.format(new Date())),false);
		 footer.setBorder(Rectangle.TOP);
		 document.setFooter(footer);
	}
	
	public static List<PdfPCell> setRowHeader(String[] header,Font font){
		List<PdfPCell> cellList = new ArrayList<PdfPCell>();
		for(String tem : header){
			PdfPCell each = new PdfPCell(new Phrase(tem,font));
			each.setBackgroundColor(new Color(237,236,236));
			cellList.add(each);
		}
		return cellList;
	}
}
