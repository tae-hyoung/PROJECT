package com.homecat.sweethome.service.impl.survey;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.survey.SurveyMapper;
import com.homecat.sweethome.service.survey.SurveyService;
import com.homecat.sweethome.vo.survey.SurveyDetailVO;
import com.homecat.sweethome.vo.survey.SurveyResultVO;
import com.homecat.sweethome.vo.survey.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {
	
	@Autowired
	SurveyMapper surveyMapper;
	
	// 전체 목록
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.surveyMapper.getTotal(map);
	}
	
	// 목록 가져오기
	@Override
	public List<SurveyVO> getList(Map<String, Object> map) {
		return this.surveyMapper.getList(map);
	}
	
	// 설문 질문 생성 (작성자)
    @Override
    public int createPost(SurveyVO surveyVO) {
    	
    	//1) SURVEY 테이블에 insert
    	int result = this.surveyMapper.createPost(surveyVO);
    	
    	String svCode = this.surveyMapper.getSvCode(surveyVO);
    	surveyVO.setSvCode(svCode);
    	
    	//2) SURVEY_DETAIL 테이블에 insert
    	List<SurveyDetailVO> surveyDetVOList = surveyVO.getSurveyDetails();
    	for(SurveyDetailVO surveyDetailVO : surveyDetVOList) {
    		surveyDetailVO.setSvCode(surveyVO.getSvCode()); // 설문 일련번호 설정
    		result += this.surveyMapper.insertDetail(surveyDetailVO);
    		
    	}
    	
		return result;
    }
    
    // 질문 가져오기
    @Override
    public SurveyVO getSurveyByCode(String svCode) {
        return surveyMapper.getSurveyByCode(svCode);
    }
    
    //질문 리스트 가져오기
    @Override
    public List<SurveyDetailVO> getDetailsByCode(String svCode) {
        return surveyMapper.getDetailsByCode(svCode);
    }

	@Override
	public int closeSurvey(String svCode) {
		return surveyMapper.closeSurvey(svCode);
	}

	@Override
	public int updatePost(SurveyVO surveyVO) {
		return surveyMapper.updatePost(surveyVO);
	}
	
	//SURVEY_DETAIL 테이블의 데이터 삭제
	@Override
	public int surveyDetailDelete(String svCode) {
		return surveyMapper.surveyDetailDelete(svCode);
	}

	@Override
	public int insertDetail(SurveyDetailVO surveyDetailVO) {
		return this.surveyMapper.insertDetail(surveyDetailVO);
	}

	@Override
	public int surveyDelete(SurveyVO surveyVO) {
		return this.surveyMapper.surveyDelete(surveyVO);
	}

	@Override
	public int insertResult(List<SurveyResultVO> surveyResults) {
		int result = 0;
		for(SurveyResultVO surveyResultVO : surveyResults) {
			result += surveyMapper.insertResult(surveyResultVO);
		}
		return result;
	}

	@Override
	public List<SurveyResultVO> searchResult(String svCode) {
		return this.surveyMapper.searchResult(svCode);
	}

	@Override
	public List<String> getQuestionCodesBySurvey(String svCode) {
		return this.surveyMapper.getQuestionCodesBySurvey(svCode);
	}

	@Override
	public int participantCnt(String svCode) {
		return this.surveyMapper.participantCnt(svCode);
	}

	@Override
	public List<String> getSubmitSurveyUser(String memId) {
		List<String> submitSurvey = this.surveyMapper.getSubmitSurveyUser(memId);
		
	    // 중복 제거 처리
	    Set<String> uniqueSubmitSurvey = new HashSet<>(submitSurvey);
	    submitSurvey.clear();
	    submitSurvey.addAll(uniqueSubmitSurvey);
	    
	    return submitSurvey;
	}

	@Override
	public int getMember(String danjiCode) {
		return this.surveyMapper.getMember(danjiCode);
	}

	@Override
	public List<SurveyVO> homeCnt() {
		return surveyMapper.homeCnt();
	}

}
