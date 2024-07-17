package com.homecat.sweethome.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mj")
public class PassCheck {

	@Autowired
	private PasswordEncoder bcrypt;
	
	@ResponseBody
	@GetMapping("/test/{pw}")
	public String mjPW(@PathVariable String pw) {
		
	  String encPas = bcrypt.encode("mjManse");
	  log.debug("암호화된 암호{}",encPas);
	   
	  if(bcrypt.matches(pw, encPas)) {
			return "OK";		  
	  }
	  return "NG";
		
	}
}
