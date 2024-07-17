package com.homecat.sweethome.vo.car;


import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.parking.ParkingVO;

import lombok.Data;

@Data
public class CarVO {

	private String carNo;
	private String memId;
	private String carModel;
	private String regDt;
	private String status;
	
	private int rnum;
	private String roomCode;
	private String memNm;
	private String memTelno;
	
	
	private MemberVO memberVO; 
	
	private int total;
	
	private ParkingVO parkingVO; 
	
}
