package com.homecat.sweethome.service.impl.calendar;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.calendar.CalendarMapper;
import com.homecat.sweethome.mapper.publicFacilities.BookMapper;
import com.homecat.sweethome.mapper.publicFacilities.FacilityMapper;
import com.homecat.sweethome.service.calendar.CalendarService;
import com.homecat.sweethome.vo.calendar.CalendarVO;
import com.homecat.sweethome.vo.publicFacilities.BookLoanVO;
import com.homecat.sweethome.vo.publicFacilities.ReserveVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	CalendarMapper calendarMapper;

	@Autowired
	FacilityMapper facilityMapper;
	
	@Autowired
	BookMapper bookMapper;

	@Override
	public List<CalendarVO> list(Map<String, Object> map) {

		// 캘린더 이벤트 리스트 가져오기
		List<CalendarVO> calendarEvents = this.calendarMapper.list(map);

		// ReserveVO 객체 생성 및 설정
		ReserveVO reserveVO = new ReserveVO();
		reserveVO.setMemId((String) map.get("memId"));

		// 시설 예약 리스트 가져오기
		List<ReserveVO> facilityEvents = this.facilityMapper.reserveCalList(reserveVO);

		// 두 리스트를 하나의 리스트로 합치기
		List<CalendarVO> combinedEvents = new ArrayList<>(calendarEvents);
		for (ReserveVO reserveEvent : facilityEvents) {
			// ReserveVO를 CalendarVO로 변환
			CalendarVO calendarEvent = convertReserveToCalendar(reserveEvent);
			// 캘린더 테이블에 이미 존재하는지 체크
	        if (!isEventExists(calendarEvent)) {
	            // 캘린더 테이블에 예약 정보 삽입
	        	
	            this.calendarMapper.addEvent(calendarEvent);
	            combinedEvents.add(calendarEvent);
	        }
		}

		// 도서 대여 리스트 가져오기
		BookLoanVO bookLoanVO = new BookLoanVO();
		bookLoanVO.setMemId((String) map.get("memId"));
		
		List<BookLoanVO> bookRentList = this.bookMapper.rentList(bookLoanVO);
		
		// BookLoanVO를 CalendarVO로 변환하여 combinedEvents에 추가
	    for (BookLoanVO bookLoan : bookRentList) {
	        CalendarVO calendarEvent = convertBookLoanToCalendar(bookLoan);
	        
	       // 캘린더 테이블에 이미 존재하는지 체크
	        if (!isEventExists(calendarEvent)) {
	            // 캘린더 테이블에 예약 정보 삽입
	        	
	            this.calendarMapper.addEvent(calendarEvent);
	            combinedEvents.add(calendarEvent);
	        }
	    }
		
		return combinedEvents;

	}
	
	// 캘린더 테이블에 이미 해당 이벤트가 존재하는지 확인하는 메서드
	private boolean isEventExists(CalendarVO calendarEvent) {
		
	    // 적절한 로직으로 캘린더 테이블에서 해당 이벤트가 있는지 확인하는 코드 작성
	    // 예시: calendarMapper에서 존재 여부를 체크하는 메서드를 호출하여 구현
		int count = calendarMapper.isEventExists(calendarEvent); // 예시: isEventExists 메서드명은 실제 코드에 맞게 사용
	    log.info("공용 count : {}", count);
	    log.info("공용시설 예약 번호 >>>: {}", calendarEvent.getResNum());
	    log.info("대여 번호 >>>: {}", calendarEvent.getRentNum());
	    return count > 0; // 개수가 0보다 크면 true, 그렇지 않으면 false 반환
	}
	

	// ReserveVO를 CalendarVO로 변환하는 메서드(공용시설물)
	private CalendarVO convertReserveToCalendar(ReserveVO reserveVO) {
	
		CalendarVO calendarVO = new CalendarVO();
		calendarVO.setMemId(reserveVO.getMemId());
		
		// facilityVOList에서 facNm 가져오기
        String facilityName = reserveVO.getFacilityVOList().isEmpty() ? "Unknown Facility" : reserveVO.getFacilityVOList().get(0).getFacNm();
        calendarVO.setCalTitle(facilityName + " 예약 ");
        
        // 시작날짜 문자열에서 시간만 추출
  		String endDay = reserveVO.getBeginTm();
  		String endDayDate = endDay.substring(0,10); // 'yyyy-mm-dd hh24:mi'에서 날짜 부분만 추출
        
		calendarVO.setCalStart(reserveVO.getBeginTm());
		calendarVO.setCalEnd(endDayDate + " " + reserveVO.getEndTm());
		
		// 시작날짜 문자열에서 시간만 추출
		String calStart = reserveVO.getBeginTm();
		String calStime = calStart.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		
		calendarVO.setCalStime(calStime);
		calendarVO.setCalEtime(reserveVO.getEndTm());
		 if("facility03".equals(reserveVO.getFacCode())) {
			calendarVO.setCalContent("🔔 "+ facilityName + " 🔔\n📢 예약 좌석  :  " + reserveVO.getSeat() + " 번 자리 ");
		} else {
			calendarVO.setCalContent("🔔 " + facilityName + " 🔔\n📢 예약 코트  :  " + reserveVO.getSeat() + " 번 코트 ");
		}
		calendarVO.setCalSort(1); // 필요에 따라 정렬 기준 설정
		calendarVO.setResNum(reserveVO.getReserveSeq());
		
		log.info("공용시설물CalendarVO : {}", calendarVO);
		return calendarVO;

	}

	// BookLoanVO를 CalendarVO로 변환하는 메서드(도서관)
	private CalendarVO convertBookLoanToCalendar(BookLoanVO bookLoanVO) {
	    CalendarVO calendarVO = new CalendarVO();
	    calendarVO.setMemId(bookLoanVO.getMemId());
	    
	    // 책 대여 정보에서 필요한 데이터를 추출하여 CalendarVO에 설정
	    calendarVO.setCalTitle("도서 반납 기한");
	    
	   // 시작날짜 문자열에서 시간만 추출
  		String rentDay = bookLoanVO.getRentDay();
  		String rentTime = rentDay.substring(0,10); // 'yyyy-mm-dd hh24:mi'에서 날짜 부분만 추출
	    
	    calendarVO.setCalStart(rentTime + " 00:00");
	    calendarVO.setCalEnd(rentTime + " 00:00");
	    
	    // 시작날짜 문자열에서 시간만 추출
 		String calStart = bookLoanVO.getLoanDt();
 		String calStime = calStart.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
	    
	    calendarVO.setCalStime(calStime);
	    calendarVO.setCalEtime(calStime);
	    
	    // bookVO에서 책 이름 가져오기
        String bookName = bookLoanVO.getBookList().isEmpty() ? "Unknown book" : bookLoanVO.getBookList().get(0).getTitle();
	    calendarVO.setCalContent("⭐ 반납 요망(대여 7일 경과) ⭐" + "\n\n📖 대여한 책  : \n" + bookName  + "\n📖 대여일  :  " + bookLoanVO.getLoanDt());
	    
	    calendarVO.setCalSort(1); // 책 대여는 다른 이벤트와 구분하기 위해 다른 정렬 기준 사용
	    calendarVO.setRentNum(bookLoanVO.getLoanSeq());
	    
	    log.info("책 대여 CalendarVO: {}", calendarVO);
	    return calendarVO;
	}
	
	
	
	
	@Override
	public int addEvent(CalendarVO calendarVO) {

		// 시작날짜 문자열에서 시간만 추출
		String calStart = calendarVO.getCalStart();
		String calStime = calStart.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalStime(calStime);

		// 종료날짜 문자열에서 시간만 추출
		String calEnd = calendarVO.getCalEnd();
		String calEtime = calEnd.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalEtime(calEtime);

		calendarVO.setCalSort(2);

		return this.calendarMapper.addEvent(calendarVO);
	}

	@Override
	public CalendarVO detail(CalendarVO calendarVO) {
		return this.calendarMapper.detail(calendarVO);
	}

	@Override
	public int updateEvent(CalendarVO calendarVO) {

		// 시작날짜 문자열에서 시간만 추출
		String calStart = calendarVO.getCalStart();
		String calStime = calStart.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalStime(calStime);

		// 종료날짜 문자열에서 시간만 추출
		String calEnd = calendarVO.getCalEnd();
		String calEtime = calEnd.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalEtime(calEtime);

		calendarVO.setCalSort(2);

		return this.calendarMapper.updateEvent(calendarVO);
	}

	@Override
	public int deleteEvent(CalendarVO calendarVO) {
		return this.calendarMapper.deleteEvent(calendarVO);
	}

	/////////////// 관리자 ////////////////////////////////////////////
	@Override
	public List<CalendarVO> adminCalList(Map<String, Object> map) {
		return this.calendarMapper.adminCalList(map);
	}

	@Override
	public int adminAddEvent(CalendarVO calendarVO) {
		// 시작날짜 문자열에서 시간만 추출
		String calStart = calendarVO.getCalStart();
		String calStime = calStart.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalStime(calStime);

		// 종료날짜 문자열에서 시간만 추출
		String calEnd = calendarVO.getCalEnd();
		String calEtime = calEnd.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalEtime(calEtime);

		calendarVO.setMemId("admin");

		return this.calendarMapper.adminAddEvent(calendarVO);
	}

	@Override
	public CalendarVO adminDetailEvent(CalendarVO calendarVO) {
		return this.calendarMapper.adminDetailEvent(calendarVO);
	}

	@Override
	public int adminUpdateEvent(CalendarVO calendarVO) {
		// 시작날짜 문자열에서 시간만 추출
		String calStart = calendarVO.getCalStart();
		String calStime = calStart.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalStime(calStime);

		// 종료날짜 문자열에서 시간만 추출
		String calEnd = calendarVO.getCalEnd();
		String calEtime = calEnd.substring(11); // 'yyyy-mm-dd hh24:mi'에서 시간 부분 추출
		calendarVO.setCalEtime(calEtime);

		calendarVO.setMemId("admin");

		return this.calendarMapper.adminUpdateEvent(calendarVO);
	}

	@Override
	public int adminDeleteEvent(CalendarVO calendarVO) {
		return this.calendarMapper.adminDeleteEvent(calendarVO);
	}

	@Override
	public int dragUp(CalendarVO calendarVO) {
		return this.calendarMapper.dragUp(calendarVO);
	}

}
