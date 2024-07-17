package com.homecat.sweethome.controller.master;

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
import com.homecat.sweethome.service.master.AdminListService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/master")
@Controller
public class WaitAdminListController extends BaseController {
	
	@Autowired
	AdminListService adminListService;
	
	/**
	 * 주택관리자 페이지 화면
	 * @return
	 */
	@GetMapping("/waitAdmin")
	public String waitAdminList() {
		return "master/admin/waitAdminList";
	}
	
	
	@ResponseBody
	@GetMapping("/waitAdminAjax")
	public List<MemberVO> waitAdminAjax(@RequestParam int curPage, @RequestParam(value="keyword", required = false, defaultValue = "") String keyword){
		Map<String, Object> map = new HashMap<>();
		map.put("curPage", curPage);
		map.put("keyword", keyword);
		log.info(curPage + "페이지의 검색 된 관리자  리스트에용~");
		
		return adminListService.waitAdminList(map);
	}
	
	@ResponseBody
	@GetMapping("/waitAdminCount")
	public Map<Object, Object> waitAdminCount(@RequestParam(value="keyword", required = false, defaultValue = "") String keyword){
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		count = adminListService.waitAdminCount(keyword);
		
		map.put("cnt", count);
		
		return map;
	}
	
	/**
	 * 가입 승인
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@PostMapping("/signAdminOk")
	public String signOk(@RequestBody String memId) {
		
		log.info("이 사람 승인함.{}" , memId);
		adminListService.signOk(memId);
		
		return "ok";
	}
	
	
	/**
	 * 가입 반려
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@PostMapping("/signAdminNo")
	public String signNo(@RequestBody String memId) {
		
		log.info("이 사람 빠꾸함.{}", memId);
		adminListService.signNo(memId);
		
		return "reject";
	}
}
