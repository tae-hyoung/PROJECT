package com.homecat.sweethome.vo.ccpy;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CcpyVO {
	private int rnum;		 //순번
	private String ccpyCode; // 협력업체 코드
	private String ccpyCat; // 업체 구분
	private String ccpyName; // 업체 명
	private String ccpyTelno; // 업체 연락처
	private String ccpyPost; // 업체 우편번호
	private String ccpyAddr; // 업체 주소
	private String ccpyAddrDetail; // 업체 상세주소
	private String bizRegNo; // 사업자 등록번호
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private String cntrDt; // 계약일
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private String expDt; // 만료일
}
