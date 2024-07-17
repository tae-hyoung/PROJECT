package com.homecat.sweethome.controller.member;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.member.MemberService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FindIDPWController extends BaseController{
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/idFind")
	public String idFind() {
		log.info("아이디찾기!");
		return "member/idFindForm";
	}
	
	@GetMapping("/pwFind")
	public String pwFind() {
		log.info("비밀번호 찾기!");
		return "member/pwFindForm";
	}
	
	@GetMapping("/pwChange")
	public String pwChange() {
		log.info("비밀번호 변경!");
		return "member/pwChangeForm";
	}
	
	@ResponseBody
	@PostMapping("/idFind.do")
	public MemberVO idFind(@RequestBody Map<String, String> map) {
		log.info("아이디찾기 컨트롤러!");
		
		String memNm = map.get("memNm");
		String memTelno = map.get("memTelno");
		
		Map<Object, Object> memberMap = new HashMap<>();
		
		memberMap.put("memNm", memNm);
		memberMap.put("memTelno", memTelno);
		
		MemberVO memberVO = memberService.idFind(memberMap);
		
		if(memberVO == null) {
			return new MemberVO();
		}
		
		return memberVO;
	}
	
	@ResponseBody
	@PostMapping("/pwChange.do")
	public int pwChange(@RequestBody MemberVO memberVO) {
		log.info("비밀번호 변경 컨트롤러!");
		log.info("아이디 값 -> {}", memberVO.getMemId());
		
		String encodedPw = bcryptPasswordEncoder.encode(memberVO.getMemPw());
		
		MemberVO memVO = new MemberVO();
		
		memVO.setMemId(memberVO.getMemId());
		memVO.setMemPw(encodedPw);
		
		int pwChange = memberService.enabledAccount(memVO);
		log.info("변경 성공하면 1 뜰거임 -> ", pwChange);
		return pwChange;
	}
	
	
	// 마이페이지에서 비밀번호 변경
	@ResponseBody
	@PostMapping("/passwordChange")
	public int passwordChange(Principal principal, @RequestBody String newPw) {
		
		String encodedPw = bcryptPasswordEncoder.encode(newPw);
		String memId = principal.getName();
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setMemId(memId);
		memberVO.setMemPw(encodedPw);
		
		int passwordChange = memberService.enabledAccount(memberVO);
		
		return passwordChange;
	}
	
	
}
