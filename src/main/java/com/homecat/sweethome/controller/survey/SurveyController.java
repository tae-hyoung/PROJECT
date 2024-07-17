package com.homecat.sweethome.controller.survey;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.survey.SurveyService;
import com.homecat.sweethome.unit.ArticlePage;
import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.survey.SurveyDetailVO;
import com.homecat.sweethome.vo.survey.SurveyResultVO;
import com.homecat.sweethome.vo.survey.SurveyVO;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/survey")
@Slf4j
@Controller
public class SurveyController extends BaseController {
	
	@Autowired
	SurveyService surveyService;
	
	// 설문지 입력 페이지
	@GetMapping("/create")
	public String createSurvey(Model model) {
		
		log.info("설문지 제작 페이지 입니다");
		model.addAttribute("surveyVO", new SurveyVO());
		
		return "admin/survey/create";
	}
	
    // 설문지 입력 실행(관리자)
    @PostMapping("/createPost")
    public String createPost(@ModelAttribute SurveyVO surveyVO) {
        log.info("설문정보 : " + surveyVO);

        // 설문 정보와 질문 목록을 Service로 전달하여 DB에 저장
        int result = surveyService.createPost(surveyVO);
        log.info("createPost->result : " + result);

        // 입력 후 리스트로 이동
        return "redirect:/survey/admin/list";
    }

    
    // 목록 가져오기
    @GetMapping("/admin/list")
    public String surveyAdminList(Model model,
    		@RequestParam(value= "currentPage", required = false, defaultValue = "1") int currentPage,
    		@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
    		HttpSession session) {
    	log.info("설문 목록이 나오는 곳");
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("keyword", keyword);
    	map.put("currentPage", currentPage);
    	
    	//설문 목록 가져오기 로직
    	List<SurveyVO> surveyVOList = this.surveyService.getList(map);
    	log.info("설문 리스트 : " + surveyVOList);
    	
    	
    	int total = this.surveyService.getTotal(map);
    	log.info("설문 총 갯수 : " + total);
    	
    	//현재 로그인한 사용자 정보
    	MemberVO member = (MemberVO) session.getAttribute("loginMember");
    	List<String> submitSurvey = this.surveyService.getSubmitSurveyUser(member.getMemId());
    	log.info("submitSurvey" + submitSurvey);
    	
    	model.addAttribute("articlePage", new ArticlePage<SurveyVO>(total, currentPage, 10, surveyVOList, keyword));
    	model.addAttribute("surveyVOList", surveyVOList);
    	model.addAttribute("submitSurvey", submitSurvey);
    	
    	return "admin/survey/list";
    }
	
	// 목록 가져오기
	@GetMapping("/list")
	public String surveyList(Model model,
			@RequestParam(value= "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			HttpSession session) {
		log.info("설문 목록이 나오는 곳");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		
		//설문 목록 가져오기 로직
		List<SurveyVO> surveyVOList = this.surveyService.getList(map);
		log.info("설문 리스트 : " + surveyVOList);
		
		
		int total = this.surveyService.getTotal(map);
		log.info("설문 총 갯수 : " + total);
		
		//현재 로그인한 사용자 정보
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		List<String> submitSurvey = this.surveyService.getSubmitSurveyUser(member.getMemId());
		log.info("submitSurvey" + submitSurvey);

		model.addAttribute("articlePage", new ArticlePage<SurveyVO>(total, currentPage, 10, surveyVOList, keyword));
		model.addAttribute("surveyVOList", surveyVOList);
		model.addAttribute("submitSurvey", submitSurvey);
		
		return "resident/survey/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<SurveyVO> listAjax(@RequestBody Map<String, Object> map){
	    
        int total = this.surveyService.getTotal(map);

        List<SurveyVO> surveyVOList = this.surveyService.getList(map);

        return new ArticlePage<SurveyVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, surveyVOList, map.get("keyword").toString());
	}
	
	// 설문 마감 처리
    @PostMapping("/closeSurveys")
    @ResponseBody
    public String closeSurvey(@RequestBody String[] svCodes) {
        log.info("설문 마감 처리");
        
        int result = 0;
        for (String svCode : svCodes) {
        	// 설문을 마감 상태로 업데이트
        	result = surveyService.closeSurvey(svCode);
        }
        
        if (result > 0) {
            return "Success";
        } else {
            return "fail";
        }
    }
    
    // 설문조사 상세보기
    @GetMapping("/admin/detail")
    public String adminDetail(@RequestParam("svCode") String svCode, Model model) {
    	
    	log.info("설문 상세 페이지입니다.");
    	log.info("일련번호 : " + svCode);
    	
    	// 설문조사  정보 가져오기
    	SurveyVO surveyVO = surveyService.getSurveyByCode(svCode);
    	log.info("설문 정보 : " + surveyVO);
    	
    	// 질문 리스트 가져오기
    	List<SurveyDetailVO> surveyDetailVOList = surveyService.getDetailsByCode(svCode);
    	log.info("설문 상세 내용 : " + surveyDetailVOList );
    	
    	// 설문 정보에 질문 리스트를 설정
    	surveyVO.setSurveyDetails(surveyDetailVOList);
    	
    	// 모델에 설문 정보를 추가하여 detail.jsp로 전달
    	model.addAttribute("surveyVO", surveyVO);
    	
    	for (SurveyDetailVO detail : surveyDetailVOList) {
    		log.info("질문 제목 : " + detail.getSvdItem());
    	}
    	
    	return "admin/survey/detail";
    }
	
	// 설문조사 상세보기
	@GetMapping("/detail")
	public String detail(@RequestParam("svCode") String svCode, Model model) {

		log.info("설문 상세 페이지입니다.");
	    log.info("일련번호 : " + svCode);

	    // 설문조사  정보 가져오기
	    SurveyVO surveyVO = surveyService.getSurveyByCode(svCode);
	    log.info("설문 정보 : " + surveyVO);
	    
	    // 질문 리스트 가져오기
	    List<SurveyDetailVO> surveyDetailVOList = surveyService.getDetailsByCode(svCode);
	    log.info("설문 상세 내용 : " + surveyDetailVOList );
	    
	    // 설문 정보에 질문 리스트를 설정
	    surveyVO.setSurveyDetails(surveyDetailVOList);
	    
	    // 모델에 설문 정보를 추가하여 detail.jsp로 전달
	    model.addAttribute("surveyVO", surveyVO);
	    
	    for (SurveyDetailVO detail : surveyDetailVOList) {
	        log.info("질문 제목 : " + detail.getSvdItem());
	    }
	    
	    return "resident/survey/detail";
	}
	
    
    //설문수정 페이지
    @GetMapping("/update")
    public String update(@RequestParam("svCode") String svCode, Model model) {
    	log.info("설문 수정 페이지");
    	
    	//설문 조사 정보 가져오기
    	SurveyVO surveyVO = surveyService.getSurveyByCode(svCode);
    	log.info("선택한 설문 정보 : " + surveyVO);
    	
	    // 질문 리스트 가져오기
	    List<SurveyDetailVO> surveyDetailVOList = surveyService.getDetailsByCode(svCode);
	    log.info("선택한 설문 상세 : " + surveyDetailVOList );

	    //surveyVO에 질문 리스트 설정
	    surveyVO.setSurveyDetails(surveyDetailVOList);
	    
	    
	    // 모델에 설문 정보를 추가하여 update.jsp로 전달
	    model.addAttribute("surveyVO", surveyVO);
	    model.addAttribute("svCode", svCode);
	    
    	return "admin/survey/update";
    }
    
    //설문 수정 실행(관리자)
 	@PostMapping("/updatePost")
 	public String updatePost(@ModelAttribute SurveyVO surveyVO, 
 							@RequestParam("svCode") String svCode, Model model) {
 		log.info("수정및 추가된 설문 정보 : " + surveyVO);
 	    
 	    //SURVEY_DETAIL 테이블의 데이터 삭제 (기존의 데이터를 삭제하고 수정 시 새로 데이터를 넣음)
 	    int result = this.surveyService.surveyDetailDelete(surveyVO.getSvCode());
		log.info("질문 총 갯수(삭제될 갯수) : " + result);	// 삭제된 질문 갯수
		
 		//질문 목록을 SERVICE로 전달 후 DB에 저장
		for (SurveyDetailVO surveyDetailVO : surveyVO.getSurveyDetails()) {
			//SURVEY_DETAIL 테이블의 데이터 insert
			result += this.surveyService.insertDetail(surveyDetailVO);
		}
		
		//제목, 시작일, 마감일 변경
		int newSurvey = this.surveyService.updatePost(surveyVO);
 		log.info("업데이트 내용 : " + newSurvey);
		
 		//수정 후 리스트로 이동
 		return "redirect:/survey/admin/list";
 	}
 	
 	//설문 삭제
 	@ResponseBody
 	@PostMapping("/delete")
 	public String delete(@RequestBody List<String> surveyCodes) {
 	    for (String svCode : surveyCodes) {
 	        SurveyVO surveyVO = new SurveyVO();
 	        surveyVO.setSvCode(svCode);
 	        int result = this.surveyService.surveyDelete(surveyVO);
 	        log.info("설문 삭제 결과: " + result);
 	    }
 	    return "success"; // 성공적으로 삭제되었을 때 반환할 값
 	}
 	
	//설문 결과 등록
	@PostMapping("/result")
	public String insertResult(@ModelAttribute SurveyVO surveyVO, Model model) {
		
		
		//참가자 수 구하기
		this.surveyService.participantCnt(surveyVO.getSvCode());
		log.info("surveyVO : " + surveyVO);
		
		List<SurveyResultVO> surveyResultVOList = surveyVO.getSurveyResultVOList();
	    Date currentDate = new Date();

//	    for (SurveyResultVO surveyResultVO : surveyResultVOList) {
//	        surveyResultVO.setRegDt(currentDate);
//	    }
	    
	    log.info("설문 결과 등록이다");
	    log.info("surveyResultVOList : " + surveyResultVOList);
	    
	    // 결과를 데이터베이스에 저장하거나 처리하는 로직을 추가
	    int result = this.surveyService.insertResult(surveyResultVOList);
	    log.info("result : " + result);
	    
	    return "redirect:/survey/list";
	    
	}
	
	// 설문결과 조회 (관리자)
	@GetMapping("/showResult")
	public String showResult(@RequestParam("svCode") String svCode, Model model
			,HttpSession session) {
		log.info("설문 결과 조회이다.");
		
		//설문 조사 정보 가져오기
		SurveyVO surveyVO = surveyService.getSurveyByCode(svCode);
		
		// 설문 결과 조회
		List<SurveyResultVO> surveyResultVOList = surveyService.searchResult(svCode);
		log.info("surveyResultVOList : " + surveyResultVOList);
		
		// 설문 코드에 해당하는 질문 코드 리스트 조회
		List<String> questionCodeList = surveyService.getQuestionCodesBySurvey(svCode);
		log.info("questionCodeList : " + questionCodeList);
		
		// 로그인 된 정보의 단지 코드 가져오기
		MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
		String danjiCode = memberVO.getRoomCode().substring(0,4);	// 단지코드 'D001' 가져오겠다
		
		// 단지 인원구하기
		int getMember = this.surveyService.getMember(danjiCode);
		
		model.addAttribute("danjiCode", danjiCode);
		model.addAttribute("getMember", getMember);
		model.addAttribute("surveyResultVOList", surveyResultVOList);
		model.addAttribute("questionCodeList", questionCodeList);
		model.addAttribute("surveyVO", surveyVO);
		
		return "resident/survey/result";
	}

	// 설문결과 조회
	@GetMapping("/admin/showResult")
	public String showAdminResult(@RequestParam("svCode") String svCode, Model model
							,HttpSession session) {
	    log.info("설문 결과 조회이다.");
	    
    	//설문 조사 정보 가져오기
    	SurveyVO surveyVO = surveyService.getSurveyByCode(svCode);

	    // 설문 결과 조회
	    List<SurveyResultVO> surveyResultVOList = surveyService.searchResult(svCode);
	    log.info("surveyResultVOList : " + surveyResultVOList);
	    
	    // 설문 코드에 해당하는 질문 코드 리스트 조회
	    List<String> questionCodeList = surveyService.getQuestionCodesBySurvey(svCode);
	    log.info("questionCodeList : " + questionCodeList);
	    
	    // 로그인 된 정보의 단지 코드 가져오기
	    MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
	    String danjiCode = memberVO.getRoomCode().substring(0,4);	// 단지코드 'D001' 가져오겠다
	    
	    // 단지 인원구하기
	    int getMember = this.surveyService.getMember(danjiCode);
	    
	    model.addAttribute("danjiCode", danjiCode);
	    model.addAttribute("getMember", getMember);
	    model.addAttribute("surveyResultVOList", surveyResultVOList);
	    model.addAttribute("questionCodeList", questionCodeList);
	    model.addAttribute("surveyVO", surveyVO);
	    
	    return "admin/survey/result";
	}
	
	@ResponseBody
	@PostMapping("/admin/homeCnt")
	public List<SurveyVO> homeCnt() {
		log.info("homeCnt 이다.");
		
		List<SurveyVO> surveyList = surveyService.homeCnt();
		log.info("homeCnt surveyList :  {}" , surveyList);
		
		return surveyList;
	}

}
