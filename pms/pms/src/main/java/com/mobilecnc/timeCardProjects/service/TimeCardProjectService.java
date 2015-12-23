package com.mobilecnc.timeCardProjects.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mobilecnc.timeCards.TimeCardVO;
import com.mobilecnc.timeCards.Userdata;

@Service
public class TimeCardProjectService {
	@Autowired
	TimeCardProjectDAO timeCardProjectDAO;

}
