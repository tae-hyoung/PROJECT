package com.homecat.sweethome.vo.publicFacilities;

import java.util.List;

import lombok.Data;

@Data
public class FacilityVO {
	
	private String facCode;
	private String danjiCode;
	private String facNm;
	private String facLoc;
	private String facTelno;
	private String facCom;
	public List<ReserveVO> reserveVOList;

}
