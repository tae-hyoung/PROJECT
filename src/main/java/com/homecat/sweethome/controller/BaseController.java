package com.homecat.sweethome.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ModelAttribute;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BaseController {
	
	@ModelAttribute("currentURI")
	public String getCurrentURI(HttpServletRequest request) {
		String result = request.getRequestURI();
		if(request.getParameter("boardCat") != null) {
			result += request.getParameter("boardCat");
		}
		return result;
	}
	
	@ModelAttribute
	public void logRequest(HttpServletRequest request) {
		log.info("Request URI: " + request.getRequestURI());
	}
}
