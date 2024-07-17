package com.homecat.sweethome.controller.visitCar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.visitCar.VisitCarService;
import com.homecat.sweethome.vo.visitCar.VisitCarVO;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/visitcar")
@Slf4j
@Controller
public class VisitCarController extends BaseController{
	
	@Autowired
	VisitCarService visitCarService;
	
	//방문차량 리스트	
	@GetMapping("/list")
	public String VisitCarList(Model model) {
		
		log.info("visitcarList에 옴");
		
		
		return "resident/car/visitcarList";
	}
	
	@ResponseBody
	@PostMapping("/list")
	public List<VisitCarVO> VisitCarListAjax(@RequestBody Map<String, Object> data2){
		log.info("visitcarList1에 옴");
		
		String memId = (String) data2.get("memId");
		
		List<VisitCarVO> visitcarVOList = this.visitCarService.getVisitCarList(memId);
		
		log.info("visitcarVOList" + visitcarVOList);
		
		return visitcarVOList;
	}
	
	
	
	
	
	//방문차량 예약 신청
	@ResponseBody
	@PostMapping("/create")
	public String VisitCarCreate(@RequestBody VisitCarVO visitCarVO) {
		log.info("VisitCarCreate에 옴");
		log.info("VisitCarVO : " + visitCarVO);
		int result = this.visitCarService.createPost(visitCarVO);
		log.info("VisitCarCreate -> result : " + result);
		
		return "SUCCESS";
	}
	
	
	//방문차량 신청 삭제
	@ResponseBody
	@PostMapping("/deleteAjax")
	public VisitCarVO deleteAjax(@RequestBody VisitCarVO visitCarVO) {
		
		log.info("deleteAjax->visitcarVO : " + visitCarVO);
		
		int result = this.visitCarService.deletePost(visitCarVO);
		log.info("deleteAjax->result : " + result);
		
		return visitCarVO;
	}
	
	/////////////////////////////////////////////////////관리자 페이지///////////////////////////////////////////////////////////////////
	//입주민 차량등록 신청 내역
	@GetMapping("/admin/adVisitCarList")
	public String adVisitCarList(Model model){
		
		log.info(">>>>>>>>>>>>>>>>adVisitCarList 옴<<<<<<<<<<<<<<<<<<<");

		Map<String, Object> map = new HashMap<String, Object>();
		
		List<VisitCarVO> adVisitCarVOList = this.visitCarService.adVisitCarList(map);
		log.info("adVisitCarList->adVisitCarVOList : " + adVisitCarVOList);
		
		model.addAttribute("adVisitCarVOList", adVisitCarVOList);
		
		
		return "admin/member/adVisitCarList";
	}
	
}
