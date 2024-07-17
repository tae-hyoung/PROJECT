package com.homecat.sweethome.controller.delivery;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.ccpy.CcpyService;
import com.homecat.sweethome.service.comm.CommDetailService;
import com.homecat.sweethome.service.delivery.DeliveryService;
import com.homecat.sweethome.vo.ccpy.CcpyVO;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.delivery.DeliveryVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/delivery")
public class DeliveryController extends BaseController{

	@Autowired
	DeliveryService deliveryService;
	
	@Autowired
	CommDetailService commDetailService;
	
	@Autowired
	CcpyService ccpyService;
	
	
	@GetMapping("/resDeliveryList")
	public String list(Model model, Map<String, Object> map, HttpSession session) {
		log.info("resDeliveryList 다아아아아");
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
        
        String memId = loginMemeber.getMemId();
        log.info("resDeliveryList -> memId : {} ",memId);
        map.put("memId", memId);
		
		List<DeliveryVO> deliveryVOList = this.deliveryService.list(map);
		log.info("deliveryVOList: {}",deliveryVOList);
		
		model.addAttribute("deliveryVOList", deliveryVOList);
		
		return "resident/delivery/resDelivery";
	}
	
	@ResponseBody
	@PostMapping("/resDeliveryDetail")
	public DeliveryVO detail(@RequestBody DeliveryVO deliveryVO) {
		log.info("resDeliveryDetail에 왔어요오오오");
		log.info("detail(전)-> deliveryVO : {}", deliveryVO);
		
		deliveryVO = this.deliveryService.detail(deliveryVO);
		log.info("detail(후)-> deliveryVO : {}", deliveryVO);
		
		return deliveryVO;
	}
	
	@ResponseBody
	@PostMapping("/resDelUpdate")
	public DeliveryVO delUpdate(@RequestBody DeliveryVO deliveryVO) {
		log.info("resDelUpdate에 왔ㄷㄷㄷㄷㄷㄷ다");
		log.info("delUpdate(전) -> deliveryVO : {}",deliveryVO);
		
		int result = this.deliveryService.delUpdate(deliveryVO);
		
		log.info("delUpdate(후) -> result : {}",result);
		log.info("delUpdate(후) -> deliveryVO : {}",deliveryVO);
		
		return deliveryVO;
	}
 
	
	@ResponseBody
	@PostMapping("/resUpdate")
	public DeliveryVO update(@RequestBody DeliveryVO deliveryVO) {
		log.info("resUpdate에 왔ㄷㄷㄷㄷㄷㄷ다");
		log.info("resUpdate(전) -> deliveryVO : {}",deliveryVO);
		
		int result = this.deliveryService.update(deliveryVO);
		
		log.info("resUpdate(후) -> result : {}",result);
		log.info("resUpdate(후) -> deliveryVO : {}",deliveryVO);
		
		return deliveryVO;
	}
	
	@ResponseBody
	@GetMapping("/getCommDetailVOAndCcpyVO")
	public Map<String, Object> getCommDelivery() {
	    log.info("getCommDelivery에 와따아");
	    
	    List<CommDetailVO> commDetailVOList = this.commDetailService.getCommDelivery();
	    log.info("getCommDelivery-> commDetailVOList :{}", commDetailVOList);
	    
	    List<CcpyVO> ccpyVOList = this.ccpyService.getCcpy();
	    log.info("getCommDelivery-> ccpyVOList :{}", ccpyVOList);

	    Map<String, Object> response = new HashMap<String, Object>();
	    response.put("commDetailVOList", commDetailVOList);
	    response.put("ccpyVOList", ccpyVOList);
	    
	    return response;
	}
	
	@ResponseBody
	@PostMapping("/create")
	public DeliveryVO create(@RequestBody DeliveryVO deliveryVO, HttpSession session) {
		log.info("create에 와더ㅏ");
		log.info("create(전)->deliveryVO : {}", deliveryVO);
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("create -> memId : {}" , memId);
		deliveryVO.setMemId(memId);
		
		int result = this.deliveryService.create(deliveryVO);
		log.info("create - result :{}",result);
		log.info("create(후)->deliveryVO : {}", deliveryVO);
		
		return deliveryVO;
	}
	
	@ResponseBody
	@PostMapping("/create2")
	public String create2( DeliveryVO deliveryVO, HttpSession session) {
		log.info("create2222222에 와더ㅏ");
		log.info("create(전)->deliveryVO : {}", deliveryVO);
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("create2222 -> memId : {}" , memId);
		deliveryVO.setMemId(memId);
		
		int result = this.deliveryService.create(deliveryVO);
		log.info("create - result :{}",result);
		log.info("create(후)->deliveryVO : {}", deliveryVO);
		
		return deliveryVO.getPckSeq();
	}
	
  ////////////////////////////관리자/////////////////////////////////////////////////////////
	
	
	@GetMapping("/admin/delivery")
	public String partList(Model model, Map<String, Object> map) {
		log.info("협력업체- partList 다아아아아");
		
		List<DeliveryVO> deliveryVOList = this.deliveryService.partList(map);
		log.info("deliveryVOList: {}",deliveryVOList);
		
		 // 택배사 목록 가져오기
	    List<CcpyVO> ccpyVOList = this.ccpyService.getCcpy();
	    log.info("ccpyList: {}", ccpyVOList);
	    
	    // 월별 통계
	    List<DeliveryVO> monthList = this.deliveryService.monthList();
	    log.info("monthList: {}", monthList);
	    
	    // 요일별 통계
	    List<DeliveryVO> dayList = this.deliveryService.dayList();
	    log.info("dayList: {}", dayList);
	    
		
		model.addAttribute("deliveryVOList", deliveryVOList);
		model.addAttribute("ccpyVOList", ccpyVOList);
		model.addAttribute("monthList", monthList);
		model.addAttribute("dayList", dayList);
		
		
		return "admin/delivery/delivery";
	}
	
	@ResponseBody
	@PostMapping("/admin/ccpyFilter")
	public List<DeliveryVO> ccpyFilter(@RequestBody Map<String, Object> map) {
		log.info("ccpyFilter에 왔어요오오오");
		
		String ccpyCode = (String) map.get("ccpyCode");
		log.info("ccpyCode :", ccpyCode);
		
		List<DeliveryVO> deliveryFilter = this.deliveryService.ccpyFilter(ccpyCode);
		log.info("deliveryFilter: {}", deliveryFilter);
		
		
		
		return deliveryFilter;
	}
		
	
	@ResponseBody
	@PostMapping("/admin/deliveryDetail")
	public DeliveryVO deliveryDetail(@RequestBody DeliveryVO deliveryVO) {
		log.info("협력업체- deliveryDetail에 왔어요오오오");
		log.info("협 detail(전)-> deliveryVO : {}", deliveryVO);
		
		deliveryVO = this.deliveryService.deliveryDetail(deliveryVO);
		log.info("협 detail(후)-> deliveryVO : {}", deliveryVO);
		
		return deliveryVO;
	}
	

	@ResponseBody
	@PostMapping("/admin/back")
	public DeliveryVO back(@RequestBody DeliveryVO deliveryVO) {
		log.info("back에 왔ㄷㄷㄷㄷㄷㄷ다");
		log.info("back(전) -> deliveryVO : {}",deliveryVO);
		
		int result = this.deliveryService.back(deliveryVO);
		
		log.info("back(후) -> result : {}",result);
		log.info("back(후) -> deliveryVO : {}",deliveryVO);
		
		return deliveryVO;
	}
	
	@ResponseBody
	@PostMapping("/admin/pickUp")
	public DeliveryVO pickUp(@RequestBody DeliveryVO deliveryVO) {
		log.info("pickUp에 왔ㄷㄷㄷㄷㄷㄷ다");
		log.info("pickUp(전) -> deliveryVO : {}",deliveryVO);
		
		int result = this.deliveryService.pickUp(deliveryVO);
		
		log.info("pickUp(후) -> result : {}",result);
		log.info("pickUp(후) -> deliveryVO : {}",deliveryVO);
		
		return deliveryVO;
	}
	
	
	@ResponseBody
	@PostMapping("/admin/homeCnt")
	public List<DeliveryVO> homeCnt() {
		log.info("homeCnt 이다.");
		
		List<DeliveryVO> deliveryList = deliveryService.homeCnt();
		log.info("homeCnt deliveryList :  {}" , deliveryList);
		
		return deliveryList;
	}
	
	
	
	
}
