package com.homecat.sweethome.controller.moveout;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.moveout.MoveoutService;
import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.moveout.MoveoutVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/moveout")
@Controller
public class MoveoutController extends BaseController {

	@Autowired
	MoveoutService moveoutService;
	
	String danjiCode = "D001";	
	
	@GetMapping("/insert")
	public String insert() {
		log.info("insert에 왔다");
		
		return "resident/moveout/insertForm";
	}
	
	@ResponseBody
	@PostMapping("/getInfo")
	public MoveoutVO getInfo(HttpSession session) {
		
		MemberVO member = (MemberVO)session.getAttribute("loginMember");
		String memId = member.getMemId();
		
		MoveoutVO mvoVO = this.moveoutService.getInfo(memId);
		
		return mvoVO;
	}
	
	@PostMapping("/insert")
	public String insertPost(MoveoutVO moveoutVO) {
		log.info("insertPost->moveoutVO" + moveoutVO);
		
		if(moveoutVO.getMvoSeq() != null && !moveoutVO.getMvoSeq().equals("")) {
			int cnt = this.moveoutService.update(moveoutVO);
			log.info("insertPost->cnt: " + cnt);
		}else {
			int cnt = this.moveoutService.insert(moveoutVO);
			log.info("insertPost->cnt: " + cnt);
		}
		
		return "redirect:/moveout/insert";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public int delete(@RequestBody Map<String, Object> data) {
		log.info("delete->data: " + data);
		
		int cnt = this.moveoutService.delete(data);
		
		return cnt;
	}
	
	
	/////////////////////// 관리자 ///////////////////////
	
	@GetMapping("/admin/list")
	public String moveoutList(Model model) {
		log.info("moveoutList에 왔다");
		
		List<MoveoutVO> moveoutVOList = this.moveoutService.getList(danjiCode);
		
		model.addAttribute("moveoutVOList", moveoutVOList);
		return "admin/moveout/list";
	}
	
	@ResponseBody
	@PostMapping("/OK")
	public int OK(@RequestBody Map<String, Object> data) {
		log.info("OK->data: " + data);
		
		int cnt = this.moveoutService.moveoutOK(data);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/getPayYN")
	public String getPayYn(@RequestBody Map<String, Object> data) {
		log.info("getPayYn->data: " + data);
		
		String yn = this.moveoutService.getPayYN(data);
		
		return yn;
	}
	
	@ResponseBody
	@PostMapping("/paySuccess")
	public int paySuccess(@RequestBody Map<String, Object> data) {
		log.info("paySuccess->data: " + data);
		
		int cnt = this.moveoutService.paySuccess(data);
		
		return cnt;
	}
}
