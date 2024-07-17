package com.homecat.sweethome.controller.calendar;

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
import com.homecat.sweethome.service.calendar.CalendarService;
import com.homecat.sweethome.vo.calendar.CalendarVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/calendar")
public class CalendarController extends BaseController {

	@Autowired
	private CalendarService calendarService;

	/**
	 * 입주민 - 캘린더 리스트 가져오기(jsp 연결)
	 * @param model
	 * @return
	 */
	@GetMapping("/calendarPage")
	public String calendarPage(Model model) {
		return "resident/calendar/calendarList5"; // JSP 파일의 경로
	}
	
	/**
	 * 입주민 - 캘린더 리스트 가져오기(ajax)
	 * @param map
	 * @param session
	 * @param model
	 * @return List<CalendarVO>
	 */
	@GetMapping("/calendarList5")
    @ResponseBody // JSON 데이터를 직접 반환하도록 설정
    public List<CalendarVO> getCalendarEvents(Map<String,Object> map, HttpSession session, Model model) {
        log.info("캘린더 이벤트를 가져옵니다...map : " + map);
        
        MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
        
        String memId = loginMemeber.getMemId();
        log.info("calendarList5 -> memId:{}",memId);
        map.put("memId", memId);
        
        
        List<CalendarVO> calendarVOList = this.calendarService.list(map);
        log.info("가져온 이벤트 리스트: " +  calendarVOList);
		
        return calendarVOList;
    }
	
	/**
	 * 입주민 - 캘린더 옆에 해당 년월의  리스트 가져오기(ajax)
	 * @param yrmon
	 * @param session
	 * @param model
	 * @return List<CalendarVO>
	 */
	@GetMapping("/calendarList6")
	@ResponseBody // JSON 데이터를 직접 반환하도록 설정
	public List<CalendarVO> calendarList6(String yrmon, HttpSession session, Model model) {
		log.info("캘린더 이벤트를 가져옵니다(6)...yrmon : " + yrmon);
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
	        
	    String memId = loginMemeber.getMemId();
	    log.info("calendarList6 -> memId:{}",memId);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("yrmon", yrmon);
		map.put("memId", memId);
		
		List<CalendarVO> calendarVOList = this.calendarService.list(map);
		log.info("가져온 이벤트 리스트: " +  calendarVOList);
		
		return calendarVOList;
	}
	
	/** 
	 * 입주민 - 캘린더 등록하기(ajax)
	 * @param calendarVO
	 * @param session
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/addEvent")
    public String addEvent(@RequestBody CalendarVO calendarVO, HttpSession session) {
        log.info("addEvent에 도착했어어어");
		log.info("addEvent(전) -> event : {}" ,  calendarVO);
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
        
	    String memId = loginMemeber.getMemId();
	    log.info("addEvent -> memId:{}",memId);
		
	    calendarVO.setMemId(memId);
	    
		int result = this.calendarService.addEvent(calendarVO);
		
		log.info("addEvent -> result : {}", result);
		log.info("addEvent(후) -> event : {}" ,  calendarVO);
		
		return "success";
    }
	
	/**
	 * 입주민 - 캘린더 상세 조회(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	@ResponseBody
	@PostMapping("/detailEvent")
	public CalendarVO detailEvent(@RequestBody CalendarVO calendarVO) {
		
		log.info("detailAjax(전) -> calendarVO : {}",calendarVO);
		
		calendarVO = this.calendarService.detail(calendarVO);
		
		log.info("detailAjax(후) -> calendarVO : {}",calendarVO);
		return calendarVO;
	}
	
	
	/**
	 * 입주민 - 캘린더 일정 수정(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	@ResponseBody
	@PostMapping("/updateEvent")
	public CalendarVO updateEvent(@RequestBody CalendarVO calendarVO) {
		
		log.info("updateEvent에 왔다아다다다다닫");
		log.info("updateEvent(전) -> calendarVO : {}",calendarVO);
		
		int result = this.calendarService.updateEvent(calendarVO);
		log.info("updateEvent -> result : {}",result);
		log.info("updateEvent(후) -> calendarVO : {}",calendarVO);
		
		return calendarVO;
	}
	
	
	/**
	 * 입주민 - 캘린더 일정 수정(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	@ResponseBody
	@PostMapping("/dragUp")
	public CalendarVO dragUp(@RequestBody CalendarVO calendarVO) {
		
		log.info("dragUp에 왔다아다다다다닫");
		log.info("dragUp(전) -> calendarVO : {}",calendarVO);
		
		int result = this.calendarService.dragUp(calendarVO);
		log.info("dragUp -> result : {}",result);
		log.info("dragUp(후) -> calendarVO : {}",calendarVO);
		
		return calendarVO;
	}
	
	
	/**
	 * 입주민 - 캘린더 삭제(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	@ResponseBody
	@PostMapping("/deleteEvent")
	public CalendarVO deleteEvent(@RequestBody CalendarVO calendarVO) {
		log.info("deleteEvent에 왔다아다다다다닫");
		
		log.info("deleteEvent(전) -> calendarVO : {}",calendarVO);
		
		int result = this.calendarService.deleteEvent(calendarVO);
		log.info("deleteEvent -> result : {}", result);
		log.info("deleteEvent(후) -> calendarVO : {}",calendarVO);

		return calendarVO;
	}
	
	////////////////////////////////////////////////////////////////////////////////
	/**
	 *  관리자 - 캘린더 리스트 가져오기(jsp 연결)
	 * @param model
	 * @return String
	 */
	@GetMapping("/admin/adminCalendarPage")
	public String adminCalendarPage(Model model) {
		
		return "admin/calendar/adminCalendarList"; // JSP 파일의 경로
	}
	
	/**
	 * 관리자 - 캘린더 리스트 가져오기(ajax)
	 * @return List<CalendarVO>
	 */
	@GetMapping("/admin/adminCalendarList")
    @ResponseBody // JSON 데이터를 직접 반환하도록 설정
    public List<CalendarVO> getAdminCalendarEvents() {
        log.info("캘린더 이벤트를 가져옵니다...");
        
        List<CalendarVO> calendarVOList = this.calendarService.adminCalList(new HashMap<>());
        log.info("가져온 이벤트 리스트: " +  calendarVOList);
        
        return calendarVOList;
    }
	
	/**
	 * 관리자 - 캘린더 등록하기(ajax)
	 * @param calendarVO
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/admin/adminAddEvent")
    public String adminAddEvent(@RequestBody CalendarVO calendarVO) {
        log.info("adminAddEvent에 도착했어어어");
		log.info("adminAddEvent(전) -> event : {}" ,  calendarVO);
		
		int result = this.calendarService.adminAddEvent(calendarVO);
		
		log.info("adminAddEvent -> result : {}", result);
		log.info("adminAddEvent(후) -> event : {}" ,  calendarVO);
		
		return "success";
    }
	
	/**
	 * 관리자 - 캘린더 상세 조회(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	@ResponseBody
	@PostMapping("/admin/adminDetailEvent")
	public CalendarVO adminDetailEvent(@RequestBody CalendarVO calendarVO) {
		
		log.info("adminDetailEvent(전) -> calendarVO : {}",calendarVO);
		
		calendarVO = this.calendarService.adminDetailEvent(calendarVO);
		
		log.info("adminDetailEvent(후) -> calendarVO : {}",calendarVO);
		return calendarVO;
	}
	
	
	/**
	 * 관리자 - 캘린더 일정 수정(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	@ResponseBody
	@PostMapping("/admin/adminUpdateEvent")
	public CalendarVO adminUpdateEvent(@RequestBody CalendarVO calendarVO) {
		
		log.info("adminUpdateEvent에 왔다아다다다다닫");
		log.info("adminUpdateEvent(전) -> calendarVO : {}",calendarVO);
		
		int result = this.calendarService.adminUpdateEvent(calendarVO);
		log.info("adminUpdateEvent -> result : {}",result);
		log.info("adminUpdateEvent(후) -> calendarVO : {}",calendarVO);
		
		return calendarVO;
	}
	
	
	/**
	 * 관리자 - 캘린더 삭제(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	@ResponseBody
	@PostMapping("/admin/adminDeleteEvent")
	public CalendarVO adminDeleteEvent(@RequestBody CalendarVO calendarVO) {
		log.info("adminDeleteEvent에 왔다아다다다다닫");
		
		log.info("adminDeleteEvent(전) -> calendarVO : {}",calendarVO);
		
		int result = this.calendarService.adminDeleteEvent(calendarVO);
		log.info("adminDeleteEvent -> result : {}", result);
		log.info("adminDeleteEvent(후) -> calendarVO : {}",calendarVO);

		return calendarVO;
	}

	/**
	 * 관리자 - 캘린더 옆에 해당 년월의 리스트 가져오기(ajax)
	 * @param yrmon
	 * @return List<CalendarVO>
	 */
	@GetMapping("/admin/calendarList6")
	@ResponseBody // JSON 데이터를 직접 반환하도록 설정
	public List<CalendarVO> adCalendarList6(String yrmon) {
		log.info("캘린더 이벤트를 가져옵니다(6)...yrmon : " + yrmon);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("yrmon", yrmon);
		
		List<CalendarVO> calendarVOList = this.calendarService.adminCalList(map);
		log.info("가져온 이벤트 리스트: " +  calendarVOList);
		return calendarVOList;
	}
	
}
