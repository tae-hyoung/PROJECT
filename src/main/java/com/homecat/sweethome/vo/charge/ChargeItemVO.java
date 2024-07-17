package com.homecat.sweethome.vo.charge;

import lombok.Data;

@Data
public class ChargeItemVO {
	// 호실정보
	private String danjiCode;
	private String dongCode;
	private String roomCode;
	
	// 년월정보
	private String ym;

	// 납부정보
	private String payYn;
	private String payDt;
	private String lateCt;
	
	// 관리항목별 총액
	private int totalCharge;
	private int commons;
	private int cleaning;
	private int disinfec;
	private int secure;
	private int elevator;
	private int ltrr;
	private int facilities;
	private int vat;
	private int consignment;
	private int meeting;
	private int building;
	private int electrocity;
	private int water;
	private int heating;
	
	// 일반 관리비 금액
	private int salary;
	private int allowance;
	private int bonus;
	private int rtrPay;
	private int iacIns;
	private int empIns;
	private int npn;
	private int hlthIns;
	private int benefits;
	private int oprodCt;
	private int printCt;
	private int tsptCt;
	private int commCt;
	private int postCt;
	private int cprodCt;
	private int etcCt;
	private int facCt;
	private int commonsOtherCt;
	
	// 일반 관리비 산출근거
	private String salaryReason;
	private String allowanceReason;
	private String bonusReason;
	private String rtrPayReason;
	private String iacInsReason;
	private String empInsReason;
	private String npnReason;
	private String hlthInsReason;
	private String benefitsReason;
	private String oprodCtReason;
	private String printCtReason;
	private String tsptCtReason;
	private String commCtReason;
	private String postCtReason;
	private String cprodCtReason;
	private String etcCtReason;
	private String facCtReason;
	private String commonsOtherCtReason;
	
	// 청소비 금액
	private int clnSvcCt;
	private int expendableCt;
	private int wasteCt;
	private int cleaningOtherCt;
	
	// 청소비 산출근거
	private String clnSvcCtReason;
	private String expendableCtReason;
	private String wasteCtReason;
	private String cleaningOtherCtReason;
	
	// 소독비 금액
	private int disinfecCt;
	private int disinfecOtherCt;
	
	// 소독비 산출근거
	private String disinfecCtReason;
	private String disinfecOtherCtReason;
	
	// 경비비 금액
	private int secCt;
	private int secOtherCt;
	
	// 경비비 산출근거
	private String secCtReason;
	private String secOtherCtReason;
	
	// 승강기유지비 금액
	private int evtMgmtCt;
	private int evtInspCt;
	private int evtExpendableCt;
	private int evtOtherCt;
	
	// 승강기유지비 산출근거
	private String evtMgmtCtReason;
	private String evtInspCtReason;
	private String evtExpendableCtReason;
	private String evtOtherCtReason;
	
	// 장기수선충당금 금액
	private int ltrrCt;
	private int ltrrOtherCt;
	
	// 장기수선충당금 산출근거
	private String ltrrCtReason;
	private String ltrrOtherCtReason;
	
	// 시설유지비 금액
	private int facilityMgmtCt;
	private int facilityChkCt;
	private int preventCt;
	private int facilitiesOtherCt;
	
	// 시설유지비 산출근거
	private String facilityMgmtCtReason;
	private String facilityChkCtReason;
	private String preventCtReason;
	private String facilitiesOtherCtReason;
	
	// 부가세 금액
	private int msvcCt;
	private int csvcCt;
	private int ssvcCt;
	private int vatOtherCt;
	
	// 부가세 산출근거
	private String msvcCtReason;
	private String csvcCtReason;
	private String ssvcCtReason;
	private String vatOtherCtReason;
	
	// 위탁관리수수료 금액
	private int consignmentCt;
	private int consignmentOtherCt;
	
	// 위탁관리수수료 산출근거
	private String consignmentCtReason;
	private String consignmentOtherCtReason;
	
	// 입주자대표회의운영비 금액
	private int cbCt;
	private int abCt;
	private int attdcCt;
	private int operationCt;
	private int meetingOtherCt;
	
	// 입주자대표회의운영비 산출근거
	private String cbCtReason;
	private String abCtReason;
	private String attdcCtReason;
	private String operationCtReason;
	private String meetingOtherCtReason;
	
	// 건물보험료 금액
	private int buildingInsr;
	// 건물보험료 노트
	private String buildingNote;

	// 전기비 금액
	private int shElecPrice;
	private int shElecUsage;
	private int sharedElec;
	private int idvElecPrice;
	private int idvElecUsage;
	private int individualElec;
	
	// 수도비 금액
	private int shWaterPrice;
	private int shWaterUsage;
	private int sharedWater;
	private int idvWaterPrice;
	private int idvWaterUsage;
	private int individualWater;
	
	// 난방비 금액
	private int shHeatingPrice;
	private int shHeatingUsage;
	private int sharedHeating;
	private int idvHeatingPrice;
	private int idvHeatingUsage;
	private int individualHeating;
}
