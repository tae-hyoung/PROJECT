package com.homecat.sweethome.vo.bidnotice;



import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BidNoticeVO {
	
	private int rum;
	private String bidSeq;
	private String danjiCode;
	private String bidHow;
	private String bidTitle;
	private String bidContent;
	private String bidStatus;
	private String bidStartDt;
	private String bidOutDt;
	private String bidFailContent;
	private String bidType;
	private String bidExplan;
	private String bidExplanDt;
	private String bidDocDt;
	private String bidPayment;
	private String bidOpenDt;
	private String bidEmergency;
	private String bidSuccessHow;
	private String bidCirSub;
	private String bidCpcSub;
	private String bidLocation;
	private String bidDeposit;
	private String bidNum;
	private String bidFax;
	private String bidAttach;
	
	private String bidCompany;
	private String bidCrn;
	private String bidCeo;
	private String bidCnum;
	private String bidBidDt;
	private String bidExplanYn;
	private String bidDocYn;
	private String bidBidDeposit;
	
	private String danjiName;
	private String addr;
	private String cntDong;
	private String cntTotalRoom;
	
	private MultipartFile[] myFiles;
}
