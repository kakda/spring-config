package com.mcnc.yuga.service;

import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.ObjectNode;

import com.mcnc.yuga.helper.grid.Request;
import com.mcnc.yuga.helper.grid.Response;

public interface PagingResponseService {

	public Response makePaginationResponse(Request req, int totalRowsCount, ArrayNode rows);
	public Response makePaginationResponse(Request req, int totalRowsCount, ArrayNode rows, ObjectNode userdata);
	public Response makePaginationResponse(Request req, int totalRowsCount, ArrayNode rows,  ArrayNode rowshide, ObjectNode userdata);
	public int calculateTotal(int totalRowsCount, int rows);
}
