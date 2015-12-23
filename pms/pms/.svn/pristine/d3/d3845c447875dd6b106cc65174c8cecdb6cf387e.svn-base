package com.mobilecnc.excelView;

import java.awt.Color;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.mobilecnc.timeCards.EntryParameter;
import com.mobilecnc.timeCards.ReportOfProject;
import com.mobilecnc.timeCards.ReportOfProjectGrid;

public class ReportTimeCardOfTeamPDFView extends AbstractPdfView{

	private String teamName;
	
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	
	Font titleFont = FontFactory.getFont("Arial", 18, Font.BOLD);
	Font headerFont = FontFactory.getFont("Arial",12,Font.BOLD);
	
	@Override
	protected void buildPdfDocument(Map<String, Object> model,
			Document document, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		ReportOfProjectGrid reportOfTeamList = (ReportOfProjectGrid) model.get("reportTimeCardOfTeamList");
		
		EntryParameter entryParameter = (EntryParameter) model.get("entryParameter");

		Paragraph title = new Paragraph("Time Card Report of Team",titleFont); 
		title.setAlignment(Element.ALIGN_CENTER); 
		
		Paragraph Date= new Paragraph("Start Date: " + df.format(entryParameter.getStartDate()) + "            End Date: " + df.format(entryParameter.getEndDate()),headerFont); 
		
		PdfPTable table = generateTable(reportOfTeamList);

		Paragraph team = new Paragraph("TEAM: " + teamName,headerFont); 
		
		PdfStyleHelper.setHeader(request, document, writer);
		PdfStyleHelper.setFooter(document, writer);
		document.open();
		document.add(title);
		document.add(team);
		document.add(Date);
		document.add(Chunk.NEWLINE);
		document.add(table);
		document.close();
		
	}

	private PdfPTable generateTable(ReportOfProjectGrid reportOfTeamList) throws DocumentException {
		// TODO Auto-generated method stub
		List<ReportOfProject> rowList = reportOfTeamList.getRows();
		if (rowList.size() == 0){
			PdfPTable pt = new PdfPTable(6);
			pt.setWidthPercentage(100);
			PdfPCell cell = new PdfPCell(new Phrase("NO DATA FOUND"));
			cell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
			cell.setColspan(6);
			pt.addCell(cell);
			return pt;
		}else{
		LinkedHashMap<String, List<ReportOfProject>> map = new LinkedHashMap<String, List<ReportOfProject>>();
		for (ReportOfProject linkMap : rowList) {
			String key = linkMap.getProjectName();
			if(map.get(key) == null){
				map.put(key, new ArrayList<ReportOfProject>());
			}
			map.get(key).add(linkMap);
		}
		
		PdfPTable pt = new PdfPTable(6);
		pt.setWidths(new int[]{40, 56, 50, 45,70,70});
		pt.setWidthPercentage(100);
		for(Map.Entry<String, List<ReportOfProject>> entry : map.entrySet()){
			PdfPCell hearderCell = new PdfPCell(new Phrase("Project"));
			hearderCell.setBackgroundColor(new Color(222,215,213));
			pt.addCell(hearderCell);
			PdfPCell cell = new PdfPCell(new Phrase(entry.getKey()));
			cell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
			cell.setColspan(5);
			pt.addCell(cell);
			pt.addCell(new PdfPCell(new Phrase("TeamID",headerFont)));
			pt.addCell(new PdfPCell(new Phrase("Time Card ID",headerFont)));
			pt.addCell(new PdfPCell(new Phrase("Employee",headerFont)));
			pt.addCell(new PdfPCell(new Phrase("By",headerFont)));
			pt.addCell(new PdfPCell(new Phrase("Time Card Date",headerFont)));
			pt.addCell(new PdfPCell(new Phrase("Working Hour",headerFont)));
			float total = 0;
			for (int j = 0; j < entry.getValue().size(); j++) {
				pt.addCell(new PdfPCell(new Phrase(entry.getValue().get(j).getTeamID())));
				pt.addCell(new PdfPCell(new Phrase(entry.getValue().get(j).getTimeCardID())));
				pt.addCell(new PdfPCell(new Phrase(entry.getValue().get(j).getEmployeeID())));
				pt.addCell(new PdfPCell(new Phrase(entry.getValue().get(j).getDw())));
				pt.addCell(new PdfPCell(new Phrase(df.format(entry.getValue().get(j).gettDate()))));
				pt.addCell(new PdfPCell(new Phrase(Float.toString( entry.getValue().get(j).getWorkingHour()))));
				total = (int) (total + entry.getValue().get(j).getWorkingHour());
				teamName = entry.getValue().get(j).getTeamName();
			}
			PdfPCell totalCell = new PdfPCell(new Phrase("Total Hours"));
			totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			totalCell.setPaddingRight(10);
			totalCell.setColspan(5);
			pt.addCell(totalCell);
			pt.addCell(new PdfPCell(new Phrase(Float.toString(total))));
		}
		
		
		return pt;
	}
	}
	
}
