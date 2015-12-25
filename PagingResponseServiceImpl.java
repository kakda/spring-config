package com.mcnc.yuga.service.impl;

import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.ObjectNode;

import com.mcnc.yuga.helper.grid.Request;
import com.mcnc.yuga.helper.grid.Response;
import com.mcnc.yuga.service.PagingResponseService;

public class PagingResponseServiceImpl implements PagingResponseService {

	public Response makePaginationResponse(Request req, int totalRowsCount,
			ArrayNode rows) {
		// TODO Auto-generated method stub
		
		Response res = new Response();
		
		res.setPage(req.getPage());
		res.setRecords(totalRowsCount);
		res.setTotal(this.calculateTotal(totalRowsCount, req.getRows()));
		res.setRows(rows);
		
		
		return res;
	}

	public int calculateTotal(int totalRowsCount, int rows) {
		// TODO Auto-generated method stub

		int totalPage = (totalRowsCount / rows ) == 0 ? 1 : (totalRowsCount / rows);
		totalPage += totalRowsCount < rows ? 0 : (totalRowsCount % rows) <= 0 ? 0 : 1;
		return totalPage;
	}
	
	@Override
	public Response makePaginationResponse(Request req, int totalRowsCount, ArrayNode rows, ObjectNode userdata) {
		
		Response response = makePaginationResponse(req, totalRowsCount, rows);
		response.setUserdata(userdata);
		return response;
	}

	@Override
	public Response makePaginationResponse(Request req, int totalRowsCount,
			ArrayNode rows, ArrayNode rowshide, ObjectNode userdata) {
		
		Response response = makePaginationResponse(req, totalRowsCount, rows);
		response.setUserdata(userdata);
		response.setRowshide(rowshide);
		return response;
	}

}
