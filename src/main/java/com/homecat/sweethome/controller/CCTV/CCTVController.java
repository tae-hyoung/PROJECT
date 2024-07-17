package com.homecat.sweethome.controller.CCTV;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin(origins = {"http://192.168.144.11/CCTV"}, maxAge = 3600)
@Controller
public class CCTVController {

	@GetMapping("/CCTV")
	public String CCTV() {
		log.info("CCTV에 왔다");
		return "resident/cctv";
	}
	
	@GetMapping("/CCTV/admin")
	public String CCTV_admin() {
		log.info("CCTV에 왔다");
		return "admin/cctv";
	}
}
