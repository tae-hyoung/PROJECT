package com.homecat.sweethome.controller.car;

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
import com.homecat.sweethome.service.car.CarService;
import com.homecat.sweethome.vo.car.CarVO;
import com.homecat.sweethome.vo.waste.WasteVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/car")
@Controller
public class CarController extends BaseController{
	
	@Autowired
	CarService carService;
	
	//차량등록 리스트 , 차량등록
	@GetMapping("/list")
	public String CarList(Model model) {
		log.debug("carList에 옴");
		
		
		return "resident/car/list";
	}
	
	
	//차량등록 리스트 , 차량등록
	@ResponseBody
	@PostMapping("/list")
	public List<CarVO> CarListAjax(@RequestBody Map<String, Object> data) {
		log.debug("carList1에 옴");
		
		String memId = (String) data.get("memId");
		
		List<CarVO> carVOList = this.carService.getCarList(memId);
		
		
		
		return carVOList;
	}
	
	//차량등록
	@ResponseBody
	@PostMapping("/create")
	public String createPost(@RequestBody CarVO carVO) {
		log.info("createPost에 옴");
		
		log.info("carVO : " + carVO);
		int result = this.carService.createPost(carVO);
		log.info("createPost -> result : " + result);
		
		return "SUCCESS";
	}
	
	//차량삭제
	@ResponseBody
	@PostMapping("/deleteAjax")
	public CarVO deleteAjax(@RequestBody CarVO carVO) {
		
		log.info("deleteAjax->carVO : " + carVO);
		
		int result = this.carService.deletePost(carVO);
		log.info("deleteAjax->result : " + result);
		
		return carVO;
	}
	
	/////////////////////////////////////////////////////관리자 페이지///////////////////////////////////////////////////////////////////
	//입주민 차량등록 신청 내역
	@GetMapping("/admin/adCarList")
	public String adCarList(Model model){
		
		log.info(">>>>>>>>>>>>>>>>adCarList 옴<<<<<<<<<<<<<<<<<<<");

		Map<String, Object> map = new HashMap<String, Object>();
		
		List<WasteVO> adCarVOList = this.carService.adCarList(map);
		log.info("adCarList->adCarVOList : " + adCarVOList);
		
		model.addAttribute("adCarVOList", adCarVOList);
		
		
		return "admin/member/adCarList";
	}
	
	//입주민 차량등록 승인/반려 업데이트
	@ResponseBody
	@PostMapping("/admin/updateAjax")
	public CarVO updateAjax(@RequestBody CarVO carVO) {
		
		log.info("updateAjax-> carVO : " + carVO);
		
		int result = this.carService.updatePost(carVO);
		log.info("updateAjax-> result : " + result);
		
		return carVO;
	}
	
	
	@ResponseBody
	@PostMapping("/admin/homeCnt")
	public List<CarVO> homeCnt() {
		log.info("homeCnt 이다.");
		
		List<CarVO> carList = carService.homeCnt();
		log.info("homeCnt carList :  {}" , carList);
		
		return carList;
	}
	
	@ResponseBody
	@PostMapping("/admin/statistics")
	public List<CarVO> statistics() {
		log.info("차 통계");
		
		List<CarVO> carVOList = carService.statistics();
		log.info("차 통계-> carVOList : {}", carVOList);
		
		return carVOList;
	}

}
