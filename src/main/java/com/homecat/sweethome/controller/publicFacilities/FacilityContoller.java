package com.homecat.sweethome.controller.publicFacilities;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.publicFacilities.FacilityService;
import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.publicFacilities.FacilityVO;
import com.homecat.sweethome.vo.publicFacilities.ReserveVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 공용시설물(테니스, 스크린골프 , 독서실) 관리
 * 
 * @author 이혜민
 *
 */
@Slf4j
@Controller
public class FacilityContoller extends BaseController{

	
	@Autowired
	private FacilityService facilityService;
	
	
	
	/** 
	 * 시설 정보, 예약 리스트 불러오기
	 * @param model :  jsp 파일에 값을 넘겨 주기 위한
	 * @param facCode : 공용시설물 코드로 구분 지어 정보를 불러 오기 위한
	 * @param session : 로그인한 회원 정보 불러오기
	 * @return  "resident/publicFacilities/reTennis" jsp파일로 보내주기
	 */
	@GetMapping("/public/tennis/reservation")
	public String tennisMain(Model model ,  @RequestParam String facCode ,   HttpSession session) {
		log.info("tennisMain 옴");
		log.info("tennisMain -> facCode : {}" , facCode);

		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("tennisMain -> memId : {}" , memId);
		
		// 테니스 코트 시설 정보 
		List<FacilityVO> facilityVOList = this.facilityService.tennisMain(facCode);
		log.info("tennisMain facilityVOList-> " + facilityVOList);
		
		ReserveVO reserveVO = new ReserveVO();
		reserveVO.setFacCode(facCode);
		reserveVO.setMemId(memId);
		
		// 예약 리스트
		List<ReserveVO> reserveVOList = this.facilityService.reserveList(reserveVO);
		
		log.info("tennisMain reserveVOList-> " + reserveVOList);
		
		model.addAttribute("facilityVOList", facilityVOList);
		model.addAttribute("reserveVOList", reserveVOList);
		
		return "resident/publicFacilities/reTennis";
	}
	
	
	/** 
	 * 예약 리스트 달마다 불러오기 위한 리스트 아작스
	 * @param map
	 * @param session : 로그인한 회원 정보 불러오기
	 * @return List<ReserveVO> : 시설코드별, 로그인한 회원 아이디 별 예약 내역을 반환
	 */
	@ResponseBody
	@PostMapping("/public/tennis/reserveListAjax")
	public List<ReserveVO> reserveListAjax(@RequestBody Map<String, String> map , HttpSession session ) {
		log.info("reserveListAjax 옴");
		
	    String facCode = map.get("facCode");
	    log.info("reserveListAjax -> facCode : {}", facCode);
	    
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("reserveListAjax -> memId : {}", memId);
		
		ReserveVO reserveVO = new ReserveVO();
		reserveVO.setFacCode(facCode);
		reserveVO.setMemId(memId);

	    List<ReserveVO> reserveVOList = this.facilityService.reserveList(reserveVO);
	    log.info("reserveListAjax reserveVOList-> {}", reserveVOList);

	    return reserveVOList;
	}

	
	
	/** 
	 * 예약 아작스
	 * @param reserveVO
	 * @param session : 로그인한 회원 정보 불러오기
	 * @return reserveVO : 예약 내역 반환
	 */
	@ResponseBody
	@PostMapping("/public/tennis/reservationAjax")
	public ReserveVO reservation(@RequestBody ReserveVO reserveVO , HttpSession session) {
		log.info("reservation 왔다");
		log.info("reservation -> reserveVO : {}", reserveVO);
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		
		reserveVO.setMemId(memId);
		
		int result = this.facilityService.reservation(reserveVO);
		log.info("reservation -> result : " + result);
		
		return reserveVO;
	}
	
	
	/** 
	 * 예약 취소 아작스
	 * @param reserveVO
	 * @return result : 취소가 정상적으로 되면 1 반환 
	 */
	@ResponseBody
	@PostMapping("/public/tennis/cancleReAjax")
	public int cancleRe(@RequestBody ReserveVO reserveVO) {
		log.info("cancleRe 왔다");
		
		log.info("취소 reserveVO : {}" , reserveVO );
		
		int result = this.facilityService.cancleRe(reserveVO);
		log.info("cancleRe -> result : " + result);
		
		return result;
	}
	
	
	/** 
	 * 예약시간테이블에 이미 있는 예약 시간대 블락 처리하기
	 * @param reserveVO
	 * @return List<ReserveVO> blockRe : 이미 있는 예약 내역 불러오기 
	 */
	@ResponseBody
	@PostMapping("/public/tennis/blockReAjax")
	public List<ReserveVO> blockRe(@RequestBody ReserveVO reserveVO) {
		log.info("blockRe 왔다");
		
		List<ReserveVO> blockRe = this.facilityService.blockRe(reserveVO);
		log.info("blockRe -> blockRe : " + blockRe);
		
		return blockRe;
	}
	
	
	/** 
	 * 실시간으로 사용 중인 코트 회색 처리하기
	 * @param reserveVO
	 * @return List<ReserveVO> liveRe : 현재 시간과 같은 시점의 예약 내역 불러오기 
	 */
	@ResponseBody
	@PostMapping("/public/tennis/liveReAjax")
	public List<ReserveVO> liveRe(@RequestBody ReserveVO reserveVO) {
		
		log.info("liveRe 왔다");
		log.info("liveRe facCode : {}",reserveVO);
		
		List<ReserveVO> liveRe = this.facilityService.liveRe(reserveVO);
		log.info("liveRe -> liveRe : " + liveRe);
		
		return liveRe;
	}
	
//	===================golf=============================
	
	/** 
	 * 골프 메인
	 * @param model
	 * @param facCode :  공용시설물 구분 코드
	 * @param session : 로그인 한 회원 정보 불러오기
	 * @return
	 */
	@GetMapping("/public/golf/reservation")
	public String golfMain(Model model , @RequestParam String facCode ,   HttpSession session) {
		log.info("golfMain 옴");
		
		log.info("golfMain -> facCode : {}" , facCode);
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("tennisMain -> memId : {}" , memId);
		
		ReserveVO reserveVO = new ReserveVO();
		reserveVO.setFacCode(facCode);
		reserveVO.setMemId(memId);
		
		// 시설 정보 불러오기
		List<FacilityVO> facilityVOList = this.facilityService.tennisMain(facCode);
		log.info("golfMain facilityVOList-> " + facilityVOList);
		
		// 예약 리스트
		List<ReserveVO> reserveVOList = this.facilityService.reserveList(reserveVO);
		log.info("golfMain reserveVOList-> " + reserveVOList);
		
		model.addAttribute("facilityVOList", facilityVOList);
		model.addAttribute("reserveVOList", reserveVOList);
		
		return "resident/publicFacilities/reGolf";
	}
	
	
//	===================studyRoom=============================
	
	/** 
	 * 독서실 메인
	 * @param model
	 * @param facCode :  공용시설물 구분 코드
	 * @param session : 로그인 한 회원 정보 불러오기
	 * @return
	 */
	@GetMapping("/public/studyRoom/reservation")
	public String studyRoomMain(Model model, @RequestParam String facCode,   HttpSession session) {
		log.info("studyRoomMain 옴");
		
		log.info("studyRoomMain -> facCode : {}" , facCode);
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		
		String memId = loginMemeber.getMemId();
		log.info("tennisMain -> memId : {}" , memId);
		
		ReserveVO reserveVO = new ReserveVO();
		reserveVO.setFacCode(facCode);
		reserveVO.setMemId(memId);
	
		
		List<FacilityVO> facilityVOList = this.facilityService.tennisMain(facCode);
		log.info("studyRoomMain facilityVOList-> " + facilityVOList);
		
		//파라미터로 facCode넣어줄것
		List<ReserveVO> reserveVOList = this.facilityService.reserveList(reserveVO);
		log.info("studyRoomMain reserveVOList-> " + reserveVOList);
		
		model.addAttribute("facilityVOList", facilityVOList);
		model.addAttribute("reserveVOList", reserveVOList);
		
		return "resident/publicFacilities/reStudyRoom";
	}
	
	
	
//	===================admin=============================
	
	/** 
	 * 공용시설물 메인화면  ( 실시간 사용 현황과 오늘의 예약 내역을 볼 수 있음)
	 * @param model
	 * @param facCode
	 * @return
	 */
	@GetMapping("/public/admin/liveStatus")
	public String adminTap(Model model, @RequestParam(value="facCode", required = false, defaultValue = "facility01") String facCode) {
		log.info("facCode: " + facCode);
		
		List<FacilityVO> facilityVOList = this.facilityService.tennisMain(facCode);
		log.info("tennisMain facilityVOList-> " + facilityVOList);
		

		model.addAttribute("facilityVOList", facilityVOList);
		
		return "admin/publicFacilities/adFacilities";
	}
	
	/** 
	 * 시설정보와 각 오늘의 예약 내역게시판
	 * @param requestData
	 * @return facilityVO
	 */
	@ResponseBody
    @PostMapping("/public/admin/getInfo")
    public FacilityVO getInfo(@RequestBody Map<String, String> map) {
        String facCode = map.get("facCode");
        log.info("facCode: " + facCode);

        // 시설 정보 가져오기
        List<FacilityVO> facilityVOList = facilityService.tennisMain(facCode);
        log.info("getInfo facilityVOList-> " + facilityVOList);

        // 예약 정보 가져오기
        List<ReserveVO> reserveVOList = facilityService.adReserveList(facCode);
        log.info("tennisMain adReserveList-> " + reserveVOList);

        if (facilityVOList.isEmpty()) {
            return null;
        }

        FacilityVO facilityVO = facilityVOList.get(0);
        facilityVO.setReserveVOList(reserveVOList); // FacilityVO 객체에 예약 정보 포함

        return facilityVO;
    }
	 
	 
	 /** 
	  * 전체 예약 내역 게시판
	 * @param model
	 * @return
	 */
	@GetMapping("public/admin/allReList")
	 public String allReList(Model model) {
		
		 List<ReserveVO> reserveVOList = this.facilityService.allReList();
		 log.info("reserveVOList : " + reserveVOList);
		 
		 // 월별 시설물 예약 통계
		 List<ReserveVO> totalRe = facilityService.totalRe();
		 log.info("totalRe : " + totalRe);
		 
		 // 요일별 예약 통계
		 List<ReserveVO> dayCntList = facilityService.dayCntList();
		 log.info("dayCntList : " + dayCntList);
		 
		 model.addAttribute("reserveVOList" , reserveVOList);
		 model.addAttribute("totalRe" , totalRe);
		 model.addAttribute("dayCntList" , dayCntList);
		 
		 return "admin/publicFacilities/allReList";
	}
	 
    /** 
     * 전체 예약 내역 게시판 시설물명으로  카테고리 검색
     * @param requestData
     * @return List<ReserveVO> reserveVOList :  전체 예약 내역을 담고 있는 리스트 반환
     */
    @ResponseBody
    @PostMapping("/selectCa")
    public List<ReserveVO> selectCa(@RequestBody Map<String, String> requestData) {
        String facCode = requestData.get("facCode");
        log.info("selectCa facCode : " + facCode);

        List<ReserveVO> reserveVOList = this.facilityService.selectCa(facCode);
        log.info("selectCa => reserveVOList : " + reserveVOList);

        return reserveVOList;
    }

    /** 
     * 예약 상세 
     * @param reserveVO
     * @return reserveVO : 예약 상세 내역
     */
    @ResponseBody
    @PostMapping("/reDetail")
    public ReserveVO reDetail(@RequestBody ReserveVO reserveVO) {
		log.info("reDetail 이달");
		
		reserveVO = facilityService.reDetail(reserveVO);
		log.info("reDetail ->  reserveVO : " + reserveVO);
    	
		return reserveVO;
	}
    
    
}
