package com.homecat.sweethome.vo.survey;


import lombok.Data;

@Data
public class SurveyResultVO {
	private String svrSeq;		// 설문 응답 일련번호
	private String svdCode;		// 설문상세 일련번호
	private String replyer;		// 응답자(회원아이디-공통코드)
	private String reply;		// 응답내용
	private String regDt;		// 응답일
	private String svCode;		// 설문 일련번호
}
