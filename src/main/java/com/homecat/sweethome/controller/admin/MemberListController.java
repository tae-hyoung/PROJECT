package com.homecat.sweethome.controller.admin;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.member.MemberService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class MemberListController extends BaseController{

	@Autowired
	MemberService memberService;
	
	/**
	 * 입주민 현황 리스트
	 * @return
	 */
	@GetMapping("/memberList")
	public String memberList(Principal principal) {
		log.info("입주민 현황");
		 String memId = principal.getName();
		 log.info(memId,"{} 요거 가져왔다~");
		
		 return "admin/member/memberList";
	}
	
	/**
	 * 입주민 현황 리스트 불러오기
	 */
	@ResponseBody
	@GetMapping("/memberListAjax")
	public List<MemberVO> memberListAjax(@RequestParam int curPage, @RequestParam(value="keyword", required = false, defaultValue = "") String keyword, Principal principal){
		
		String memId = principal.getName();
		log.info("memId : " + memId);
		
		Map<Object, Object> map = new HashMap<>();
		map.put("memId", memId);
		map.put("curPage", curPage);
		map.put("keyword", keyword);
		
		
		return memberService.memberList(map);
	}
	
	
	/**
	 * 가입자 수
	 * @param keyword
	 * @return
	 */
	@ResponseBody
	@GetMapping("/memberCount")
	public Map<Object, Object> memberCount(@RequestParam(value="keyword", required = false, defaultValue = "") String keyword, Principal principal) {
		
		int count = 0;
			
		Map<Object, Object> map = new HashMap<>();
		String memId = principal.getName();
		
		map.put("memId", memId);
		map.put("keyword", keyword);
		
		Map<Object, Object> memberMap = new HashMap<>();
		
		count = memberService.memberCount(map);
			
		memberMap.put("cnt", count);
		
		return memberMap;
	}

	/**
	 * 가입 대기자 페이지 화면 출력
	 * @return
	 */
	@GetMapping("/waitMember")
	public String waitList() {
		return "admin/member/waitMemberList";
	}

	/**
	 * 가입 대기자 목록 조회
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/wait2")
	public List<MemberVO> waitList2(@RequestParam int curPage, @RequestParam(value="keyword", required = false, defaultValue = "") String keyword, Principal principal) {
		
		Map<Object, Object> map = new HashMap<>();
		map.put("memId", principal.getName());
		map.put("curPage", curPage);
		map.put("keyword", keyword);
		log.info(curPage + "페이지의 검색 된 회원 리스트에용~");
		return memberService.waitList(map);	
	}
	
	@ResponseBody
	@GetMapping("/count")
	public Map<Object, Object> waitCount(@RequestParam(value="keyword", required = false, defaultValue = "") String keyword, Principal principal) {
		
		int count = 0;
		
		Map<Object, Object> map = new HashMap<>();
		String memId = principal.getName();
		
		map.put("memId", memId);
		map.put("keyword", keyword);
		
		Map<Object, Object> memberMap = new HashMap<>();

		count = memberService.waitCount(map);
			
		memberMap.put("cnt", count);
		
		return memberMap;
	}
	
	
	/**
	 * 가입 반려자 페이지 화면 출력
	 * @return
	 */
	@GetMapping("/rejectMember")
	public String rejectList() {
		return "admin/member/rejectMemberList";
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "/rejectMemberAjax")
	public List<MemberVO> rejectMember(@RequestParam int curPage, @RequestParam(value="keyword", required = false, defaultValue = "") String keyword, Principal principal) {
		
		Map<Object, Object> map = new HashMap<>();
		map.put("memId", principal.getName());
		map.put("curPage", curPage);
		map.put("keyword", keyword);
		log.info(curPage + "페이지의 반려된 회원 리스트에용~");
		return memberService.rejectList(map);	
	}
	
	
	@ResponseBody
	@GetMapping("/rejectCount")
	public Map<Object, Object> rejectCount(@RequestParam(value="keyword", required = false, defaultValue = "") String keyword, Principal principal) {
		
		int count = 0;
		
		Map<Object, Object> map = new HashMap<>();
		String memId = principal.getName();
		
		map.put("memId", memId);
		map.put("keyword", keyword);
		
		Map<Object, Object> memberMap = new HashMap<>();

		count = memberService.rejectCount(map);
			
		memberMap.put("cnt", count);
		
		return memberMap;
	}
	

	/**
	 * 가입 승인
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@PostMapping("/signOk")
	public String signOk(@RequestBody String memId) {
		
		log.info("이 사람 승인함.{}" , memId);
		memberService.signOk(memId);
		
		return "ok";
	}

	/**
	 * 가입 반려
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@PostMapping("/signNo")
	public String signNo(@RequestBody String memId) {
		
		log.info("이 사람 빠꾸함.{}", memId);
		memberService.signNo(memId);
		
		return "reject";
	}
	
	/**
	 * 제명
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@PostMapping("/deleteMem")
	public String deleteMember(@RequestBody String memId) {
		
		log.info("이 사람 삭제함.{}", memId);
		memberService.deleteMem(memId);
		
		return "delete";
	}
}
