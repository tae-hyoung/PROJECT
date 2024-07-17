package com.homecat.sweethome.service.survey;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.survey.SurveyDetailVO;
import com.homecat.sweethome.vo.survey.SurveyResultVO;
import com.homecat.sweethome.vo.survey.SurveyVO;

public interface SurveyService {
	
	//전체 목록
	public int getTotal(Map<String, Object> map);
	
	//목록 가져오기
	public List<SurveyVO> getList(Map<String, Object> map);
	
	//설문 질문 생성 (작성자)
	public int createPost(SurveyVO surveyVO);
	
	//질문 가져오기
	public SurveyVO getSurveyByCode(String svCode);
	
	//질문 리스트 가져오기
	public List<SurveyDetailVO> getDetailsByCode(String svCode);
	
	//설문 마감 처리
    public int closeSurvey(String svCode);
    
    //설문 수정
	public int updatePost(SurveyVO surveyVO);

	//SURVEY_DETAIL 테이블의 데이터 삭제(기존의 데이터를 삭제)
	public int surveyDetailDelete(String svCode);
	
	//SURVEY_DETAIL 테이블의 데이터 넣기 (기존의 데이터를 삭제하고 '수정' 시 새로 데이터를 넣음)
	public int insertDetail(SurveyDetailVO surveyDetailVO);
	
	//설문 삭제
	public int surveyDelete(SurveyVO surveyVO);
	
	//설문 결과 등록
	public int insertResult(List<SurveyResultVO> surveyResults);
	
	//설문 결과 조회
	public List<SurveyResultVO> searchResult(String svCode);
	
	//설문 코드에 해당하는 질문 코드 리스트 조회 
	public List<String> getQuestionCodesBySurvey(String svCode);
	
	//참가자 수 구하기
	public int participantCnt(String svCode);
	
	//제출 목록 중복 방지
	public List<String> getSubmitSurveyUser(String memId);
	
	//단지 인원구하기
	public int getMember(String danjiCode);

	public List<SurveyVO> homeCnt();
	


}
