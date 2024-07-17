package com.homecat.sweethome.service.calendar;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.calendar.CalendarVO;


/**
 * 캘린더 관리
 * 입주민과 관리자 캘린더를 관리한다.
 * @author 김미선
 *
 */
public interface CalendarService {

	/**
	 * 입주민 - 캘린더 리스트 가져오기(ajax)
	 * @param map 
	 * @return List<CalendarVO>
	 */
	public List<CalendarVO> list(Map<String, Object> map);

	
	/**
	 * 입주민 - 캘린더 등록하기(ajax)
	 * @param calendarVO
	 * @return int : 캘린더 등록 작업이 성공하면 1, 실패하면 0이 반환됨.
	 */
	public int addEvent(CalendarVO calendarVO);

	/**
	 * 입주민 - 캘린더 상세 조회(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	public CalendarVO detail(CalendarVO calendarVO);

	/**
	 * 입주민 - 캘린더 일정 수정(ajax)
	 * @param calendarVO
	 * @return int : 캘린더 수정 작업이 성공하면 1, 실패하면 0이 반환됨.
	 */
	public int updateEvent(CalendarVO calendarVO);

	/**
	 * 입주민 - 캘린더 삭제(ajax)
	 * @param calendarVO
	 * @return int : 캘린더 삭제 작업이 성공하면 1, 실패하면 0이 반환됨.
	 */
	public int deleteEvent(CalendarVO calendarVO);

	/**
	 * 관리자 - 캘린더 리스트 가져오기(ajax)
	 * @param map
	 * @return List<CalendarVO>
	 */
	public List<CalendarVO> adminCalList(Map<String, Object> map);

	/**
	 * 관리자 - 캘린더 등록하기(ajax)
	 * @param calendarVO
	 * @return int : 캘린더 등록 작업이 성공하면 1, 실패하면 0이 반환됨.
	 */
	public int adminAddEvent(CalendarVO calendarVO);

	/**
	 * 관리자 - 캘린더 상세 조회(ajax)
	 * @param calendarVO
	 * @return CalendarVO
	 */
	public CalendarVO adminDetailEvent(CalendarVO calendarVO);

	/**
	 * 관리자 - 캘린더 일정 수정(ajax)
	 * @param calendarVO
	 * @return int : 캘린더 수정 작업이 성공하면 1, 실패하면 0이 반환됨.
	 */
	public int adminUpdateEvent(CalendarVO calendarVO);

	/**
	 * 관리자 - 캘린더 삭제(ajax)
	 * @param calendarVO
	 * @return int : 캘린더 삭제 작업이 성공하면 1, 실패하면 0이 반환됨.
	 */
	public int adminDeleteEvent(CalendarVO calendarVO);


	/**
	 * 공통 - 캘린더 드래그앤드롭으로 수정
	 * @param calendarVO
	 * @return int : 캘린더 수정 작업이 성공하면 1, 실패하면 0이 반환됨.
	 */
	public int dragUp(CalendarVO calendarVO);



}
