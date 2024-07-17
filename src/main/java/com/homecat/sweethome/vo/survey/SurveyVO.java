package com.homecat.sweethome.vo.survey;

import java.util.List;


import lombok.Data;

@Data
public class SurveyVO {
	private String svCode;		// 설문조사 일련번호 EX) SV001 (아파트조경만족도)
	private String svTitle;		// 설문제목 SV001 - 아파트조경만족도
	private int count;			// 참여자 수
	private String beginTm;		// 시작일
	private String endTm;		// 마감일
	private String endYn;		// 마감여부
	
	private int totalPage; 		// 총 페이지 수	
	private int rnum;			// 행 번호
	
	
	private List<SurveyDetailVO> surveyDetails; // 설문 질문 목록
	
	private List<SurveyResultVO> surveyResultVOList; // 설문 결과
}
