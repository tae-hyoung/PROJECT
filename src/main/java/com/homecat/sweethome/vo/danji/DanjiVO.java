package com.homecat.sweethome.vo.danji;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DanjiVO {
	private String lastUpdId;
	private String danjiLayout;
	private String danjiPicture;
	private String danjiCode;
	private String danjiName;
	private String danjiCat;
	private String post;
	private String addr;
	private String addrDetail;
	private String saleType;
	private String heatingType;
	private String hallType;
	private String cntDong;
	private String cntTotalRoom;
	private String totalArea;
	private String residentialArea;
	private String approvalDt;
	private String constructor;
	private String developer;
	private String moreType84;
	private String type84;
	private String type74;
	private String type69;
	private String underType69;
	private String firstRegDt;
	private String firdtRegId;
	private String lastUpdDt;
	
	private MultipartFile danjiLayoutFile;
	private MultipartFile danjiPictureFile;
}


