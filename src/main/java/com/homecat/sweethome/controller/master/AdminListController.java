package com.homecat.sweethome.controller.master;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
public class AdminListController extends BaseController {
	@Autowired
	AdminListService adminListService;
	
	
	@GetMapping("/adminList")
	public String waitAdminList() {
		log.info("관리자 현황이다!");
		return "master/admin/adminList";
	}
	
	@ResponseBody
	@GetMapping("/adminAjax")
	public List<MemberVO> adminAjax (@RequestParam int curPage, @RequestParam(value="keyword", required = false, defaultValue = "") String keyword){
		Map<String, Object> map = new HashMap<>();
		map.put("curPage", curPage);
		map.put("keyword", keyword);
		
		return adminListService.adminList(map);
	}
	
	@ResponseBody
	@GetMapping("/adminCount")
	public Map<Object, Object> adminCount(@RequestParam(value="keyword", required = false, defaultValue = "") String keyword){
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		count = adminListService.adminCount(keyword);
		
		map.put("cnt", count);
		
		return map;
	}
}
