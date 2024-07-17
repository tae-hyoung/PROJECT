package com.homecat.sweethome.vo.survey;

import lombok.Data;

@Data
public class SurveyDetailVO {
	private String svdCode; // 상세 일련번호 번호에 따라 질문을 구분
	private String svCode;	// 설문 일련번호 EX) SV001
	private String svdItem; // 질문 리스트 EX) SV001 에 있는 질문 리스트들
}
