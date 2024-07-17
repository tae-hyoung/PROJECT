package com.homecat.sweethome.vo.parking;

import lombok.Data;

@Data
public class ParkingVO {

	private String parkSeq;
	private String dangiCode;
	private String parkNm;
	private int parkAllow;
	
	private int availableCnt;
	private int total;
}
