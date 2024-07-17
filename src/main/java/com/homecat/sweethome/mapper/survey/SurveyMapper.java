package com.homecat.sweethome.mapper.survey;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.survey.SurveyDetailVO;
import com.homecat.sweethome.vo.survey.SurveyResultVO;
import com.homecat.sweethome.vo.survey.SurveyVO;

public interface SurveyMapper {
	
	// 전체 목록
	public int getTotal(Map<String, Object> map);

	// 목록 가져오기
	public List<SurveyVO> getList(Map<String, Object> map);

	// 설문 질문 생성 (작성자)
	public int createPost(SurveyVO surveyVO);
	
	// 설문 번호 가져오기
	public String getSvCode(SurveyVO surveyVO);
	
	// 설문 상세 등록
	public int insertDetail(SurveyDetailVO surveyDetailVO);
	
	//설문 가져오기
	public SurveyVO getSurveyByCode(String svCode);
	
	//질문 상세 가져오기
	public List<SurveyDetailVO> getDetailsByCode(String svCode);
	
	//설문 마감 처리
	public int closeSurvey(String svCode);
	
	//설문 수정
	public int updatePost(SurveyVO surveyVO);
	
	//SURVEY_DETAIL 테이블의 데이터 삭제
	public int surveyDetailDelete(String svCode);
	
	//설문 삭제
	public int surveyDelete(SurveyVO surveyVO);
	
	//설문 결과 등록
	public int insertResult(SurveyResultVO surveyResultVO);
	
	//설문 결과 조회
	public List<SurveyResultVO> searchResult(String svCode);
	
	//설문 코드에 해당하는 질문 코드 리스트 조회
	public List<String> getQuestionCodesBySurvey(String svCode);
	
	//참가자 수 구하기
	public int participantCnt(String svCode);
	
	//제출 목록 중복 방지
	public List<String> getSubmitSurveyUser(String memId);
	
	//단지 인원 구하기
	public int getMember(String danjiCode);

	public List<SurveyVO> homeCnt();
	
}
