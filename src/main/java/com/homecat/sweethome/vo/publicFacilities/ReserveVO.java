package com.homecat.sweethome.vo.publicFacilities;

import java.util.List;

import com.homecat.sweethome.vo.member.MemberVO;

import lombok.Data;

@Data
public class ReserveVO {

	private String reserveSeq;
	private String memId;
	private String facCode;
	private String regDt; //신청일
	private String beginTm; //시작시간
	private String endTm; //종료시간
	private String useTime; //사용시간
	private String seat;
	private int nop;
	private String cancleYn;
	private String cancleDt;
	
	private String month; //달
	private int totalRe;  //통계
	
	private String weekday; //달
	private int reCnt;  //통계
	
	
	public List<MemberVO> memberVOList;
	
	// 캘린더 연동
	public List<FacilityVO> facilityVOList;
}
