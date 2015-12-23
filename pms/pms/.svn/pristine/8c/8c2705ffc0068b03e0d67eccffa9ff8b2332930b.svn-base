package com.mobilecnc.helper.report;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Service;

/**
 * 
 * @author sereysopheak.eap
 *
 */
@Service
public class DownloadService {

	public static final String TEMPLATE = "/report2.jrxml";
	protected static Logger logger = Logger.getLogger("service");

	@Autowired
	private BasicDataSource dataSource;
	
	@Autowired
	private ExporterService exporter;
	
	@Autowired
	private TokenService tokenService;
	
	public void download(String type, String token, HttpServletResponse response,String reportPath,HashMap<String, Object> params) throws SQLException {
		Connection con=dataSource.getConnection();
		try {
			//params.put("p_logo", "D:\\Logo\\mobilec&C.png");
			
			InputStream reportStream = this.getClass().getResourceAsStream(reportPath); 
			 
			JasperDesign jd = JRXmlLoader.load(reportStream);
			/*
			JRProperties.setProperty("net.sf.jasperreports.default.pdf.font.name","Times New Roman");
			JRProperties.setProperty("net.sf.jasperreports.default.pdf.encoding","Identity-H");
			JRProperties.setProperty("net.sf.jasperreports.default.pdf.embedded",true);
			*/ 
			JasperReport jr = JasperCompileManager.compileReport(jd);
			
			
			JasperPrint jp = JasperFillManager.fillReport(jr, params, con);
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();

			exporter.export(type, jp, response, baos);
			 
			write(token, response, baos);
		}catch (RuntimeException e)
		{
			
		}catch (JRException jre) {
			logger.error("Unable to process download");
			throw new RuntimeException(jre);
		}
		finally
		{
			DataSourceUtils.releaseConnection(con, dataSource);
		}
	}
	
	/**
	* Writes the report to the output stream
	*/
	private void write(String token, HttpServletResponse response,
			ByteArrayOutputStream baos) {
		 
		try {
			logger.debug(baos.size());
			

			ServletOutputStream outputStream = response.getOutputStream();

			baos.writeTo(outputStream);

			outputStream.flush();
			
			tokenService.remove(token);
			
		} catch (Exception e) {
			logger.error("Unable to write report to the output stream");
			
			tokenService.remove(token);
			throw new RuntimeException(e);
		}
	}
}
