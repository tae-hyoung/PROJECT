package com.homecat.sweethome.vo.visitCar;

import com.homecat.sweethome.vo.member.MemberVO;

import lombok.Data;

@Data
public class VisitCarVO {
	
	private String carNo;
	private String memId;
	private String regDt;
	private String inTm;
	private String outTm;
	private String purpose;
	private String visitorName;
	private String visitorTelno;
	private String cancelYn;
	private String cancelTm;
	private String status;
	
	private int rnum;
	private String roomCode;
	private String memNm;
	private String memTelno;
	
	
	private MemberVO memberVO; 
}
