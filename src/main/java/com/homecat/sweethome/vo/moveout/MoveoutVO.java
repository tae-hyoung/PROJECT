package com.homecat.sweethome.vo.moveout;

import lombok.Data;

@Data
public class MoveoutVO {
	private String mvoSeq;
	private String memId;
	private String regDt;
	private String estDt;
	private String mvoDt;
	private String payYn;
	private String cancelYn;
	private String cancelTm;
	private String roomCode;
	private String applicant;
	private String applicantTelno;
	private int charge;
	private String status;
	private String method;
}
