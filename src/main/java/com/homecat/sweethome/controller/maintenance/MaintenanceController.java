package com.homecat.sweethome.controller.maintenance;

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
import com.homecat.sweethome.service.maintenance.MaintenanceService;
import com.homecat.sweethome.vo.maintenance.MaintenanceVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/maintenance")
public class MaintenanceController extends BaseController{
	
	@Autowired
	MaintenanceService maintenanceService;
	
	//목록 뷰 
	@GetMapping("/list")
	public String list(Model model, MaintenanceVO maintenanceVO, HttpSession session) {
		log.info("list에 왔다!");
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("list -> memId : {} ",memId);
		maintenanceVO.setMemId(memId);
		
		List<MaintenanceVO> mtList = this.maintenanceService.list(maintenanceVO);
		log.info("list->mtList : " + mtList);
		
		model.addAttribute("mtList", mtList);
		
		return "resident/maintenance/list";
	}
	
	//상세 뷰
	@GetMapping("/detail")
	public String detail(Model model, String mtSeq) {
		log.info("detail페이지야");
		
		MaintenanceVO maintenanceVO = this.maintenanceService.detail(mtSeq);
		
		model.addAttribute("maintenanceVO", maintenanceVO);
		log.info("detail->maintenanceVO : " + maintenanceVO);
		
		return "resident/maintenance/detail";
	}
	
	// 입력 뷰
	@GetMapping("/create")
	public String create(Model model) {
		
		log.info("create!!");
		
		return "resident/maintenance/create";
	}
	
	//하자보수 신청
	@ResponseBody
	@PostMapping("/createAjax")
	public String createAjax(MaintenanceVO maintenanceVO, HttpSession session) {
		log.info("creatAjax야!!!");
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("createAjax -> memId : {} ",memId);
		maintenanceVO.setMemId(memId);
		
		log.info("createAjax->maintenanceVO : " + maintenanceVO);
		
		int result = this.maintenanceService.createPost(maintenanceVO);
		log.info("createAjax->result : " + result);
		
		//리스트로 이동
		return "resident/maintenance/list";
	}
	
	//회원정보 가져오기
	@GetMapping("/getMemberInfo")
	@ResponseBody
	public MaintenanceVO getMemberInfo(HttpSession session) {
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("getMemberInfo -> memId : {} ",memId);
		
		MaintenanceVO maintenanceVO = maintenanceService.getMemberInfo(memId);
		
		return maintenanceVO;
	}
	
	//일련번호 가져오기
	@ResponseBody
	@PostMapping("/getMtSeq")
	public String getMtSeq() {
		String result = this.maintenanceService.getMtSeq();
		
		log.info("getMtSeq->result : " + result);
		return result;
	}
	
	
	//수정수정
	@ResponseBody
	@PostMapping("/updateAjax")
	public MaintenanceVO updateAjax(MaintenanceVO maintenanceVO) {
		log.info("updateAjax->>>>>maintenanceVO " + maintenanceVO);
		
		int result = this.maintenanceService.updatePost(maintenanceVO);
		log.info("updateAjax->result : " + result);
		
		maintenanceVO = this.maintenanceService.detail(maintenanceVO.getMtSeq());
		
		return maintenanceVO;
	}
	
	//삭제
	@ResponseBody
	@PostMapping("/deleteAjax")
	public int deleteAjax(@RequestBody Map<String, Object> map) {
		log.info("deleteAjax->>>>>maintenanceVO " + map);
		
//		String mtSeq = this.maintenanceService.getMtSeq();
//		log.info("mtSeq: " + mtSeq);
//		maintenanceVO.setMtSeq(mtSeq);
		
		int result = this.maintenanceService.deletePost(map);
		log.info("deleteAjax->result : " + result);
		
		return result;
	}

	/////////////////관리자 페이지///////////////////////////////////////////////////////////////////
	//입주민 하자보수 신청 내역
	@GetMapping("/admin/adList")
	public String adList(Model model, MaintenanceVO maintenanceVO) {
		log.info("adList에 왔당!!");
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<MaintenanceVO> adMtList = this.maintenanceService.adList(maintenanceVO);
		log.info("adList->adMtList : " + adMtList);
		
		model.addAttribute("adMtList", adMtList);
		
		return "admin/maintenance/adList";
	}
	
	//처리상태 데이터 카운트
	@GetMapping("/admin/statusCount")
	@ResponseBody
	public List<MaintenanceVO> statusCount() {
		log.info("statusCount!!");
		
		List<MaintenanceVO> CountList = maintenanceService.statusCount();
		log.info("statusCount CountList :  {}" , CountList);
		
		return CountList;
	}
		
	//모달 상세
	@ResponseBody
	@PostMapping("/admin/modalDetail")
	public MaintenanceVO modalDetail(@RequestBody MaintenanceVO maintenanceVO) {
		maintenanceVO = maintenanceService.modalDetail(maintenanceVO);
		
		log.info("modalDetail->maintenanceVO: {}", maintenanceVO);
		
		return maintenanceVO; 
	}
	
	//모달 수정1
	@PostMapping("/admin/modalUpdate")
	@ResponseBody
	public String modalUpdate(@RequestBody MaintenanceVO maintenanceVO){
		log.debug("modalUpdate :  {}",maintenanceVO);
		
		int result = maintenanceService.modalUpdate(maintenanceVO);
		log.info("modalUpdate->result : " + result);
		if (result > 0) {
				return "success"; 
		} 	
		return "fail";
	}
	
	
	//모달 수정2
	@PostMapping("/admin/modalUpdate2")
	@ResponseBody
	public String modalUpdate2(@RequestBody MaintenanceVO maintenanceVO){
		log.debug("modalUpdate2 :  {}",maintenanceVO);
		
		int result = maintenanceService.modalUpdate2(maintenanceVO);
		log.info("modalUpdate2->result : " + result);
		if (result > 0) {
			return "success"; 
		} 	
		return "fail";
	}
	
	
	@ResponseBody
	@PostMapping("/admin/homeCnt")
	public List<MaintenanceVO> homeCnt() {
		log.info("homeCnt 이다.");
		
		List<MaintenanceVO> maintenanceList = maintenanceService.homeCnt();
		log.info("homeCnt maintenanceList :  {}" , maintenanceList);
		
		return maintenanceList;
	}

	
	
}






