package com.homecat.sweethome.controller.vote;

import java.security.Principal;
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
import com.homecat.sweethome.service.vote.VoteService;
import com.homecat.sweethome.unit.ArticlePage;
import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.vote.VoteDetailVO;
import com.homecat.sweethome.vo.vote.VoteResultVO;
import com.homecat.sweethome.vo.vote.VoteVO;
import com.homecat.sweethome.vo.waste.WasteVO;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/vote")
@Slf4j
@Controller
public class VoteController extends BaseController {
	
	@Autowired
	VoteService voteService;
	
	//투표 입력 페이지
	@GetMapping("/create")
	public String createVote(Model model) {
		log.info("투표 제작 페이지이다");
		model.addAttribute("voteVO", new VoteVO());
		
		return "admin/vote/create";
	}
	
	//투표 입력 실행(관리자)
	@PostMapping("/createPost")
	public String createPost(@ModelAttribute VoteVO voteVO) {
		log.info("투표 정보 : " + voteVO);

		//DB에 보내주자
		int result = voteService.createPost(voteVO);
		log.info("createPost->result : " + result);
		
		return "redirect:/vote/admin/list";
	}
	
	//목록 가져오기
	@GetMapping("/admin/list")
	public String voteAdminList(Model model,
			@RequestParam(value= "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			HttpSession session) {
		log.info("설문 목록이 나오는 곳");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		
		//설문 목록 가져오기 로직
		List<VoteVO> voteVOList = this.voteService.getList(map);
		log.info("투표 목록 : " + voteVOList);
		
		int total = this.voteService.getTotal(map);
		log.info("설문 총 갯수 : " + total);
		
		//현재 로그인한 사용자 정보
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		List<String> submitVote = this.voteService.getSubmitVoteUser(member.getMemId());
		log.info("submitVote" + submitVote);
		
		model.addAttribute("articlePage", new ArticlePage<VoteVO>(total, currentPage, 10, voteVOList, keyword));
		model.addAttribute("voteVOList", voteVOList);
		model.addAttribute("submitVote", submitVote);
		
		return "admin/vote/list";
	}
	
	//목록 가져오기
	@GetMapping("/list")
	public String voteList(Model model,
			@RequestParam(value= "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			HttpSession session) {
		log.info("설문 목록이 나오는 곳");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		
		//설문 목록 가져오기 로직
		List<VoteVO> voteVOList = this.voteService.getList(map);
		log.info("투표 목록 : " + voteVOList);
		
		int total = this.voteService.getTotal(map);
		log.info("설문 총 갯수 : " + total);
		
		//현재 로그인한 사용자 정보
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		List<String> submitVote = this.voteService.getSubmitVoteUser(member.getMemId());
		log.info("submitVote" + submitVote);
		
		model.addAttribute("articlePage", new ArticlePage<VoteVO>(total, currentPage, 10, voteVOList, keyword));
		model.addAttribute("voteVOList", voteVOList);
		model.addAttribute("submitVote", submitVote);
		
		return "resident/vote/list";
	}
	
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<VoteVO> listAjax(@RequestBody Map<String, Object> map){
	    
        int total = this.voteService.getTotal(map);

        List<VoteVO> voteVOList = this.voteService.getList(map);

        return new ArticlePage<VoteVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, voteVOList, map.get("keyword").toString());
	} 
	
	
	//투표 마감처리(관리자)
	@PostMapping("/closeVote")
	@ResponseBody
	public String closeVote(@RequestBody String[] voteCodes) {
		log.info("설문 마감처리");
		
		int result = 0;
		for(String voteCode : voteCodes) {
			// 투표 마감 상태로 업데이트
			result = voteService.closeVote(voteCode);
		}
		
		if (result > 0) {
		    return "Success";
		} else {
		    return "fail";
		}		
	}
	
	//투표 상세보기
	@GetMapping("/admin/detail")
	public String adminDetail(@RequestParam("voteCode") String voteCode, Model model) {
		log.info("투표 상세 페이지이다");
		log.info("선택 투표번호 : " + voteCode);
		
		//투표 정보 가져오기
		VoteVO voteVO = voteService.getVoteByCode(voteCode);
		log.info("투표 정보 : " + voteVO);
		
		//후보자 리스트 가져오기
		List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
		log.info("투표 상세 : " + voteDetailVOList);
		
		//투표 정보 리스트 설정
		voteVO.setVoteDetails(voteDetailVOList);
		log.info("디테일 셋해준 voteVO : " + voteVO);
		
		//detail.jsp 로전달
		model.addAttribute("voteVO", voteVO);
		
		for(VoteDetailVO detail : voteDetailVOList) {
			log.info("후보자 -> " + detail.getVdItem());
		}
		
		return "admin/vote/detail";
	}
	
	//투표 상세보기
	@GetMapping("/detail")
	public String detail(@RequestParam("voteCode") String voteCode, Model model, Principal principal) {
		log.info("투표 상세 페이지이다");
		
		//로그인 안되어있으면 이동
		if(principal == null) {
			return "redirect:/login";
		}
		
		log.info("선택 투표번호 : " + voteCode);
		
		//투표 정보 가져오기
		VoteVO voteVO = voteService.getVoteByCode(voteCode);
		log.info("투표 정보 : " + voteVO);
		
		//후보자 리스트 가져오기
		List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
		log.info("투표 상세 : " + voteDetailVOList);
		
		//투표 정보 리스트 설정
		voteVO.setVoteDetails(voteDetailVOList);
		log.info("디테일 셋해준 voteVO : " + voteVO);
		
		//detail.jsp 로전달
		model.addAttribute("voteVO", voteVO);
		
		for(VoteDetailVO detail : voteDetailVOList) {
			log.info("후보자 -> " + detail.getVdItem());
		}
		
		return "resident/vote/detail";
	}
	
	//투표 수정 페이지
	@GetMapping("/update")
	public String update(@RequestParam("voteCode") String voteCode, Model model, Principal principal) {
		log.info("설문 수정 페이지");
		
		//로그인 안되어있으면 이동
		if(principal == null) {
			return "redirect:/login";
		}
		
		//투표 정보 가져오기
		VoteVO voteVO = voteService.getVoteByCode(voteCode);
		log.info("투표 정보 : " + voteVO);
		
		//설문 리스트 가져오기
		List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
		
		//voteVO에 투표 리스트 설정
		voteVO.setVoteDetails(voteDetailVOList);
		
		model.addAttribute("voteVO", voteVO);
		model.addAttribute("voteCode", voteCode);
		
		return "admin/vote/update"; 
	}
	
	//투표 수정 
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute VoteVO voteVO,
							@RequestParam("voteCode") String voteCode, Model model) {
		log.info("수정 및 추가된 투표 정보 : " + voteVO);
		
		int result = 0;
		
		//VOTE_DETAIL 테이블의 데이터 삭제(기존내용을 지우고 새로운 데이터로 수정)
//		int result = this.voteService.voteDetailDelete(voteVO);
//		log.info("투표 항목(삭제될 갯수) : " + result);
		
		// DB로 저장(merge into)
		
		//마지막 기본키 데이터
		String lastVdCode = "";
		String lastVoteCode = "";
		
		for(VoteDetailVO voteDetailVO : voteVO.getVoteDetails()) {
			// VOTE_DETAIL 테이블에 INSERT
			result += this.voteService.insertDetail(voteDetailVO);
			
			lastVdCode = voteDetailVO.getVdCode();
			lastVoteCode = voteDetailVO.getVoteCode();
		}
		
		//찌꺼기 제거(마지막 복합키 데이터를 파라미터로 던짐)
		VoteDetailVO lastVoteDetailVO = new VoteDetailVO();
		lastVoteDetailVO.setVdCode(lastVdCode);
		lastVoteDetailVO.setVoteCode(lastVoteCode);
		
		result += this.voteService.voteDetailArrange(lastVoteDetailVO);
		log.info("찌꺼기 제거 result : " + result);
		
		int newVote = this.voteService.updatePost(voteVO);
		log.info("업데이트 내용 : " + newVote);
		
		return "redirect:/vote/admin/list";
	}
	
	//투표 삭제
	@ResponseBody
	@PostMapping("/delete")
	public String delete(@RequestBody List<String> voteCodes) {
		for(String voteCode : voteCodes) {
			VoteVO voteVO = new VoteVO();
			voteVO.setVoteCode(voteCode);
			int result = this.voteService.voteDelete(voteVO);
			log.info("투표 삭제 결과 : " + result);
		}
		
		return "success";
	}
	
	@PostMapping("/result")
	public String insertResult(@RequestParam("selectedCandidate") String selectedCandidate,
							   @RequestParam("selectedCandidateName") String selectedCandidateName,
	                           @RequestParam("voteCode") String voteCode,
	                           @RequestParam("replyer") String replyer) {
	    
		
	    log.info("selectedCandidate: " + selectedCandidate);
	    log.info("selectedCandidateName: " + selectedCandidateName);
	    log.info("voteCode: " + voteCode);
	    log.info("replyer: " + replyer);
		
		//참가자 수 구하기
		int cnt = this.voteService.participantCnt(voteCode);
		
	    VoteResultVO voteResultVO = new VoteResultVO();

	    // 선택된 후보자의 정보 설정
	    voteResultVO.setVdCode(selectedCandidate);
	    voteResultVO.setReply(selectedCandidateName); // 선택된 후보자의 이름 설정
	    voteResultVO.setVoteCode(voteCode);
	    voteResultVO.setReplyer(replyer);

	    log.info("투표 결과 등록이다");
	    log.info("voteResultVO : " + voteResultVO);

	    int result = this.voteService.insertResult(voteResultVO);
	    log.info("result : " + result);

	    return "redirect:/vote/list";
	}
	
//	//AJAX에 voteVO 값 
//	//결과 조회(관리자)
//	@ResponseBody
//	@PostMapping("/admin/showResult1")
//	public VoteVO adminShowResult(@RequestBody String voteCode, Model model) {
//		log.info("adminShowResult 메서드 호출됨. voteCode: " + voteCode);
//		log.info("투표 결과 조회이다");
//		
//		//투표 정보 가져오기
//		VoteVO voteVO = voteService.getVoteByCode(voteCode);
//		
//		//후보자 리스트 가져오기
//		List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
//		log.info("투표 상세(후보자) : " + voteDetailVOList);
//		
//		
//		//투표 정보 리스트 설정
//		voteVO.setVoteDetails(voteDetailVOList);
//		
//		model.addAttribute("voteVO", voteVO);
//		
//
//		return voteVO;
//	}
//		
//	//AJAX 에 CNT값
//	@ResponseBody
//	@PostMapping("/admin/showResult2")
//	public int[] getCnt(@RequestBody String voteCode) {
//		
//		//후보자 리스트 가져오기
//		List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
//		log.info("투표 상세(후보자) : " + voteDetailVOList);
//		
//		int[] cnt = new int[voteDetailVOList.size()];
//		//투표자 목록 가져오기
//		for(int i=0; i<voteDetailVOList.size(); i++) {
//			List<VoteResultVO> replyers = voteService.searchResult(voteCode);
//			
//			for (VoteResultVO replyer : replyers) {
//				if(replyer.getVdCode().equals(voteDetailVOList.get(i).getVdCode())){
//					cnt[i]++;
//				}
//				
//			}
//			
//			log.info("cnt가 뭐가져옴?" + cnt);
//		}
//		return cnt;
//	}
	
	//AJAX에 voteVO 값 
	//결과 조회(관리자)
	@ResponseBody
	@PostMapping("/showResult1")
	public VoteVO adminShowResult(@RequestBody Map<String, String> requestBody, Model model) {
	    String voteCode = requestBody.get("voteCode");
	    log.info("adminShowResult 메서드 호출됨. voteCode: " + voteCode);
	    log.info("투표 결과 조회이다");
	    
	    // 투표 정보 가져오기
	    VoteVO voteVO = voteService.getVoteByCode(voteCode);
	    
	    // 후보자 리스트 가져오기
	    List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
	    log.info("투표 상세(후보자) : " + voteDetailVOList);
	    
	    // 투표 정보 리스트 설정
	    voteVO.setVoteDetails(voteDetailVOList);
	    
	    model.addAttribute("voteVO", voteVO);
	    
	    return voteVO;
	}
	
	//AJAX 에 CNT값
	@ResponseBody
	@PostMapping("/showResult2")
	public int[] getCnt(@RequestBody Map<String, String> requestBody) {
	    String voteCode = requestBody.get("voteCode");
	    log.info("getCnt 메서드 호출됨. voteCode: " + voteCode);
	    
	    // 후보자 리스트 가져오기
	    List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
	    log.info("투표 상세(후보자) : " + voteDetailVOList);
	    
	    int[] cnt = new int[voteDetailVOList.size()];
	    
	    // 투표자 목록 가져오기
	    for(int i=0; i<voteDetailVOList.size(); i++) {
	        List<VoteResultVO> replyers = voteService.searchResult(voteCode);
	        
	        for (VoteResultVO replyer : replyers) {
	            if(replyer.getVdCode().equals(voteDetailVOList.get(i).getVdCode())){
	                cnt[i]++;
	            }
	        }
	        
	        log.info("cnt가 뭐가져옴?" + cnt);
	    }
	    
	    return cnt;
	}
	
//	@GetMapping("/admin/showResult")
//	public String adminShowResult(@RequestParam("voteCode") String voteCode, Model model) {
//		log.info("투표 결과 조회이다");
//		
//		//투표 정보 가져오기
//		VoteVO voteVO = voteService.getVoteByCode(voteCode);
//		
//		//후보자 리스트 가져오기
//		List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
//		log.info("투표 상세(후보자) : " + voteDetailVOList);
//		
//		
//		int[] cnt = new int[voteDetailVOList.size()];
//		//투표자 목록 가져오기
//		for(int i=0; i<voteDetailVOList.size(); i++) {
//			List<VoteResultVO> replyers = voteService.searchResult(voteCode);
//			
//			for (VoteResultVO replyer : replyers) {
//				if(replyer.getVdCode().equals(voteDetailVOList.get(i).getVdCode())){
//					cnt[i]++;
//				}
//				
//			}
//			
//			log.info("cnt가 뭐가져옴?" + cnt);
//		}
//		
//		//투표 정보 리스트 설정
//		voteVO.setVoteDetails(voteDetailVOList);
//		
//		//투표 결과 조회
//		List<VoteResultVO> voteResultVOList = voteService.searchResult(voteCode);
//		log.info("voteResultVOList : " + voteResultVOList);
//		
//		
//		model.addAttribute("cnt", cnt);
//		model.addAttribute("voteResultVOList", voteResultVOList);
//		model.addAttribute("voteVO", voteVO);
//		
//		return "admin/vote/result";
//	}
	
	//결과 조회
	@GetMapping("/showResult")
	public String showResult(@RequestParam("voteCode") String voteCode, Model model) {
		log.info("투표 결과 조회이다");
		
		//투표 정보 가져오기
		VoteVO voteVO = voteService.getVoteByCode(voteCode);
		
		//후보자 리스트 가져오기
		List<VoteDetailVO> voteDetailVOList = voteService.getDetailsByCode(voteCode);
		log.info("투표 상세(후보자) : " + voteDetailVOList);
		
		
		int[] cnt = new int[voteDetailVOList.size()];
		//투표자 목록 가져오기
		for(int i=0; i<voteDetailVOList.size(); i++) {
			List<VoteResultVO> replyers = voteService.searchResult(voteCode);
			
			for (VoteResultVO replyer : replyers) {
				if(replyer.getVdCode().equals(voteDetailVOList.get(i).getVdCode())){
					cnt[i]++;
				}
				
			}
			
			log.info("cnt가 뭐가져옴?" + cnt);
		}
		
		//투표 정보 리스트 설정
		voteVO.setVoteDetails(voteDetailVOList);
		
		//투표 결과 조회
		List<VoteResultVO> voteResultVOList = voteService.searchResult(voteCode);
		log.info("voteResultVOList : " + voteResultVOList);
		
		
		model.addAttribute("cnt", cnt);
		model.addAttribute("voteResultVOList", voteResultVOList);
		model.addAttribute("voteVO", voteVO);
		
		return "resident/vote/result";
	}
	
	
	@ResponseBody
	@PostMapping("/admin/homeCnt")
	public List<VoteVO> homeCnt() {
		log.info("homeCnt 이다.");
		
		List<VoteVO> voteList = voteService.homeCnt();
		log.info("homeCnt voteList :  {}" , voteList);
		
		return voteList;
	}
	
}
