package com.homecat.sweethome.controller.complain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.complain.ComplainService;
import com.homecat.sweethome.unit.ArticlePage;
import com.homecat.sweethome.vo.complain.ComplainVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/complain")
@Controller
public class ComplainController extends BaseController {

	@Autowired
	ComplainService complainService;
	
	@GetMapping("/create")
	public String create() {
		log.info("create에 왔다");
		return "resident/complain/create";
	}

	@PostMapping("/create")
	public String createPost(ComplainVO complainVO) {
		log.info("createPost->complainVO: " + complainVO);
		
		// 민원 등록
		int cnt = this.complainService.create(complainVO);
		log.info("cnt: " + cnt);
		
		return "redirect:/complain/list";
	}
	
	@GetMapping("/list")
	public String list(Model model, HttpSession session, 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		log.info("list에 왔다");
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getNickname();

		int size = 5;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword );
		map.put("currentPage", currentPage);
		map.put("memId", memId);
		map.put("size", size);
		log.info("boardList->map: " + map);
		
		List<ComplainVO> complainVOList = this.complainService.getList(map);
		log.info("complainVOList: " + complainVOList);

		int total = this.complainService.getTotal(map);
		log.info("boardVOList->total: " + total);

		model.addAttribute("articlePage", new ArticlePage<ComplainVO>(total, currentPage, size, complainVOList, keyword));
		
		return "resident/complain/list";
	}
	
	//////////////////// 관리자 ////////////////////
	@GetMapping("/admin/list")
	public String adminList(Model model, 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		log.info("adminList에 왔다");

		int size = 10;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword );
		map.put("currentPage", currentPage);
		map.put("size", size);
		log.info("boardList->map: " + map);
		
		List<ComplainVO> complainVOList = this.complainService.getAllList(map);
		log.info("complainVOList: " + complainVOList);

		int total = this.complainService.getAllTotal(map);
		log.info("boardVOList->total: " + total);

		model.addAttribute("articlePage", new ArticlePage<ComplainVO>(total, currentPage, size, complainVOList, keyword));
		
		return "admin/complain/list";
	}
	
	@ResponseBody
	@PostMapping("/admin/reply")
	public int replyAjax(@RequestBody Map<String, Object> data) {
		log.info("replyAjax->data: " + data);
		
		int cnt = this.complainService.replyAjax(data);
		
		return cnt;
	}
	
	
	@ResponseBody
	@PostMapping("/delete")
	public int delete(@RequestBody Map<String, Object> data) {
		log.info("delete->data: " + data);
		
		int cnt = complainService.delete(data);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/admin/homeCnt")
	public List<ComplainVO> homeCnt() {
		log.info("homeCnt 이다.");
		
		List<ComplainVO> complainList = complainService.homeCnt();
		log.info("homeCnt complainList :  {}" , complainList);
		
		return complainList;
	}
	
}
