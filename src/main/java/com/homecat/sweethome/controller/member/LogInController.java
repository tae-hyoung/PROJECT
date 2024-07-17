package com.homecat.sweethome.controller.member;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.service.member.LogInService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LogInController {
	@Inject
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	LogInService logInService;

	@ResponseBody
	@PostMapping("/logInMember")
	public Map<Object, Object> logInMember(@RequestBody MemberVO memberVO, HttpSession session){
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		MemberVO member = logInService.logInMember(memberVO.getMemId());
		
		// 아이디 불일치
		if(member == null) {
			log.info("존재하는 아아딘데 여기서 로그 찍히면 곤란한데요?");
			map.put("status", "fail");
			map.put("message", "일치하는 회원정보가 없습니다.");	
			return map;
			// 비밀번호 불일치		
		}
		
		// 비밀번호 일치 불일치 여부
		boolean pwMatch = passwordEncoder.matches(memberVO.getMemPw(), member.getMemPw());
		if(!pwMatch) {
			map.put("status", "fail");
			map.put("message", "일치하는 회원정보가 없습니다.");
			return map;
		}else {
			log.info("아이디 상태 출력 -> {}", member.getEnabled());
			log.info("휴면 아이디 -> {}", member.getMemId());
			// 미승인
			// 휴면
			if(member.getEnabled().equals("0")) {
				map.put("memId", memberVO.getMemId());
				map.put("status", "dormant");
				map.put("message", "휴면계정 입니다.");	
				return map;
			}else {
				if(member.getMviStatus().equals("mvi01")) {
					map.put("status", "success");
					map.put("message", "로그인 성공.");
					log.info("회원정보 ->{}", member.toString());
					
					session.setAttribute("loginMember", member);
					return map;
				}else if(member.getMviStatus().equals("mvi02")) {
					map.put("status", "wait");
					map.put("message", "승인 대기중");
					
					session.setAttribute("loginMember", member);
					return map;
				}else if(member.getMviStatus().equals("mvi03")) {
					map.put("status", "reject");
					map.put("message", "반려된 계정");
					
					session.setAttribute("loginMember", member);
					return map; 
				}else {
					map.put("status", "fail");
					map.put("message", "일치하는 회원정보가 없습니다.");
					return map;
				}
			}
		}

	}
	
	//비밀번호 검증 
	@ResponseBody
	@PostMapping("/pwMatch")
	public Map<Object, Object> pwMatch(Principal principal, @RequestBody String password) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		MemberVO member = logInService.logInMember(principal.getName());
		log.debug("저장된 비밀번호 {}",member.getMemPw());
		log.debug("입력 한 비밀번호 {}", password);
		
		boolean pwMatch = passwordEncoder.matches(password, member.getMemPw());
		
		if(pwMatch) {
			map.put("result", "ok");
			return map;
		}else {
			map.put("result", "no");
			return map;
		}	
	}
}
