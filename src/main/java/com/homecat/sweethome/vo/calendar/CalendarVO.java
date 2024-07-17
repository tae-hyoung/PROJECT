package com.homecat.sweethome.vo.calendar;


import java.sql.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.homecat.sweethome.vo.publicFacilities.ReserveVO;

import lombok.Data;

@Data
public class CalendarVO {

	private String calSeq;
	private String memId;
	private String calTitle;
	private String calStart;
	private String calEnd;
	private String calStime;
	private String calEtime;
	private String calContent;
	private int calSort;
	
	
	// 공용 시설물 예약 번호
	private String resNum;
	// 도서 대여 번호
	private String rentNum;
	
	
	
}
