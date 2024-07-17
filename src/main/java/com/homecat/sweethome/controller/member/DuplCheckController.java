package com.homecat.sweethome.controller.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.service.member.SignUpService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DuplCheckController {
	@Autowired
	SignUpService signUpService;
	
	/**
	 * 아이디 중복 체크
	 * @param memId
	 * @return
	 */
	@RequestMapping("/idcheck.do")
	@ResponseBody
	public Map<Object, Object> idCheck(@RequestBody String memId){
		log.info("아이디 중복확인");
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = signUpService.chkid(memId);
		
		map.put("cnt", count);
		
		return map;
	}
	
	
	@RequestMapping("/nickcheck.do")
	@ResponseBody
	public Map<Object, Object> nickCheck(@RequestBody String nickname){
		log.info("닉네임 중복확인");
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = signUpService.chkNick(nickname);
		map.put("cnt", count);
		
		return map;
	}
	
}
