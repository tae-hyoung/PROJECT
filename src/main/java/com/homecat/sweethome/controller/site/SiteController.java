package com.homecat.sweethome.controller.site;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.bidnotice.BidNoticeService;
import com.homecat.sweethome.service.board.BoardService;
import com.homecat.sweethome.service.danji.DanjiService;
import com.homecat.sweethome.unit.ArticlePage;
import com.homecat.sweethome.vo.bidnotice.BidNoticeVO;
import com.homecat.sweethome.vo.board.BoardVO;
import com.homecat.sweethome.vo.danji.DanjiVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/site")
@Controller
public class SiteController extends BaseController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	DanjiService danjiService;
	
	@Autowired
	BidNoticeService bidnoticeService;
	
	
	
	@GetMapping("/residentHome")
	public String residentHome() {
		log.info("residentHome에 왔다");
		
		return "home/residentHome";
	}

	@GetMapping("/introduce")
	public String inroduce() {
		log.info("introduce에 왔다");
		
		return "site/introduce";
	}
	
	@GetMapping("/danji")
	public String danji(Model model) {
		log.info("danji에 왔다");
		
		List<DanjiVO> danjiVOList = this.danjiService.getList();
		log.info("danjiVOList :" + danjiVOList );
		
		model.addAttribute("danjiVOList : ", danjiVOList);
		
		return "site/danji/list";
	}
	
	@ResponseBody
	@PostMapping("/danji/list")
	public List<DanjiVO> list() {
		log.info("danji에 왔다");
		
		List<DanjiVO> danjiVOList = this.danjiService.getList();
		log.info("danjiVOList :" + danjiVOList );
		
		
		return danjiVOList;
	}
	
	
	@GetMapping("/danji/detail")
	public String danjiDetail(Model model, String danjiCode) {
		log.info("danjiDetail에 왔다 ->"+ danjiCode );
		
		DanjiVO danjiVO = this.danjiService.getDetail(danjiCode);
		log.info("danjiVO: " + danjiVO);
		
		model.addAttribute("danjiVO", danjiVO);
		
		return "site/danji/detail";
	}
	
	
	@GetMapping("/danji/create")
	public String danjiCreate() {
		log.info("danji/create 화면을 띄웠다");
		return "site/danji/create";
	}
	
	@PostMapping("/danji/create")
	public String danjiCreatetPost(DanjiVO danjiVO) {
		log.info("danjiCreatetPost->danjiVO: " + danjiVO);
		
		
		int result = this.danjiService.createDanji(danjiVO);
		log.info("danjiCreatetPost->result: " + result);
		
		String danjiCode = this.danjiService.getDanjiCode();
		
		return "redirect:/site/danji/detail?danjiCode="+danjiCode;
	}
	
	//수정
//	@ResponseBody
	@PostMapping("/danji/updateAjax")
	public String updateAjax(Model model, DanjiVO danjiVO) {
		
		log.info("updateAjax-> DanjiVO : " + danjiVO);
		
		int result = this.danjiService.updatePost(danjiVO);
		log.info("updateAjax-> result : " + result);
		
		// 업데이트된 정보를 다시 조회
		danjiVO = this.danjiService.getDetail(danjiVO.getDanjiCode());
		log.info("updateAjax-> danjiVO.getDanjiCode() : " + danjiVO.getDanjiCode());
		

		model.addAttribute("danjiVO", danjiVO);
		
		return "site/danji/detail";
	}
	
	
	@ResponseBody
	@PostMapping("/danji/deleteAjax")
	public DanjiVO deleteAjax(@RequestBody DanjiVO danjiVO) {
		
		log.info("deleteAjax->danjiVO : " + danjiVO);
		
		int result = this.danjiService.deletePost(danjiVO);
		log.info("deleteAjax->result : " + result);
		
		return danjiVO;
	}
	
	
	@GetMapping("/notice")
	public String notice(Model model,
			@RequestParam(value = "boardCat", required = false, defaultValue = "") String boardCat, 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		log.info("notice에 왔다");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword );
		map.put("currentPage", currentPage);
		map.put("boardCat", boardCat);
		log.info("boardList->map: " + map);
		
		int size = 10;
		
		List<BoardVO> boardVOList = this.boardService.getList(map);
		log.info("boardVOList: " + boardVOList);
		
		int total = this.boardService.getTotal(map);
		log.info("boardVOList->total: " + total);
		
		model.addAttribute("boardCat", boardCat);
		model.addAttribute("articlePage", new ArticlePage<BoardVO>(total, currentPage, size, boardVOList, keyword, boardCat));
		
		return "site/notice/list";
	}
	
	@GetMapping("/notice/insert")
	public String noticeInsert() {
		log.info("notice/insert 화면을 띄웠다");
		return "site/notice/insert";
	}
	
	@PostMapping("/notice/insert")
	public String noticeInsertPost(BoardVO boardVO) {
		log.info("noticeInsertPost->boardVO: " + boardVO);
		
		boardVO.setDanjiCode("D001");	// 단지코드 하드코딩
		
		int result = this.boardService.insertBoard(boardVO);
		log.info("brdInsertPost->result: " + result);
		
		return "redirect:/site/notice?boardCat=board_site";
	}
	
	@GetMapping("/notice/detail")
	public String noticeDetail(Model model, String brdNo) {
		log.info("noticeDetail에 왔다");
		
		BoardVO boardVO = this.boardService.getDetail(brdNo);
		log.info("boardVO: " + boardVO);
		
		model.addAttribute("boardVO", boardVO);
		
		return "site/notice/detail";
	}
	
	@GetMapping("/notice/update")
	public String noticeUpdate(Model model, @RequestParam String brdSeq) {
		log.info("brdUpdate->brdSeq: " + brdSeq);
		
		BoardVO boardVO = this.boardService.getDetail(brdSeq);
		log.info("boardVO: " + boardVO);
		
		model.addAttribute("boardVO", boardVO);
		return "site/notice/update";
	}
	
	@PostMapping("/notice/update")
	public String noticeUpdatePost(BoardVO boardVO) {
		log.info("brdUpdatePost->boardVO: " + boardVO);
		
		int cnt = this.boardService.update(boardVO);
		log.info("brdUpdatePost->cnt: " + cnt);
		
		return "redirect:/site/notice/detail?brdNo="+boardVO.getBrdSeq();
	}
	
	@GetMapping("/notice/delete")
	public String noticeDelete(@RequestParam String brdSeq, @RequestParam String brdCat) {
		log.info("brdDelete에 왔다");
		
		int cnt = this.boardService.delete(brdSeq);
		log.info("brdDelete->cnt: " + cnt);
		
		return "redirect:/site/notice?boardCat="+brdCat;
	}
	
	@GetMapping("/bidList")
	public String bidList(Model model) {
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>bidList에 왔다<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
		
		List<BidNoticeVO> bidnoticeVOList = this.bidnoticeService.getList();
		log.info("bidnoticeVOList: " + bidnoticeVOList);	
		model.addAttribute("bidnoticeVOList", bidnoticeVOList);
		return "site/bidnotice/bidList";
	}
	
	@GetMapping("/bidDetail")
	public String bidDetail(@RequestParam("bidSeq") String bidSeq, Model model) {
		
		log.info("bidSeq : " + bidSeq);
		
		BidNoticeVO bidnoticeVO = bidnoticeService.getDetail(bidSeq);
		
		model.addAttribute("bidnoticeVO", bidnoticeVO);
		log.info("getDetail -> bidnoticeVO : " + bidnoticeVO);
		
		return "site/bidnotice/bidDetail";
	}
	
	
	@ResponseBody
	@PostMapping("/updateAjax")
	public BidNoticeVO updateAjax(@RequestBody BidNoticeVO bidnoticeVO) {
		
		log.info("updateAjax-> bidnoticeVO : " + bidnoticeVO);
		
		int result = this.bidnoticeService.updatePost(bidnoticeVO);
		log.info("updateAjax-> result : " + result);
		
		// 업데이트된 정보를 다시 조회
		bidnoticeVO = this.bidnoticeService.getDetail(bidnoticeVO.getBidSeq());
		
		return bidnoticeVO;
	}
	
	// 입력 뷰
	@GetMapping("/bidCreate")
	public String create(Model model) {
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>입찰공고 create에 옴<<<<<<<<<<<<<<<<<<<<");
		
		List<DanjiVO> danjiVOList = danjiService.getDanji();
		
		model.addAttribute("danjiVOList", danjiVOList);
		
		return "site/bidnotice/bidCreate";
	}
	
	@ResponseBody
	@PostMapping("/getDanjiInfo")
	public DanjiVO getDanjiInfo(@RequestBody Map<String, Object> data) {
		log.info("getDanjiInfo->data: " + data);
		
		DanjiVO danjiVO = this.danjiService.getDanji2(data);
		log.info("danjiVO: " + danjiVO);
		
		return danjiVO;
	}
	
	//입찰공고 등록
	@ResponseBody
	@PostMapping("/createAjax")
	public String createAjax(BidNoticeVO bidNoticeVO) {
		log.info(">>>>>>>>>>>>>>>>>>>creatAjax에 옴<<<<<<<<<<<<<<<<<<<<<<<<<<<");
		log.info("createAjax->bidNoticeVO : " + bidNoticeVO);
		
		int result = this.bidnoticeService.createPost(bidNoticeVO);
		log.info("createAjax->result : " + result);
		
		//리스트로 이동
		return "site/bidnotice/bidList";
	}
	
	@ResponseBody
	@PostMapping("/deleteAjax")
	public BidNoticeVO deleteAjax(@RequestBody BidNoticeVO bidnoticeVO) {
		
		log.info("deleteAjax->bidnoticeVO : " + bidnoticeVO);
		
		int result = this.bidnoticeService.deletePost(bidnoticeVO);
		log.info("deleteAjax->result : " + result);
		
		return bidnoticeVO;
	}
	
	@GetMapping("/bidResult")
	public String bidResult() {
		log.info("bidResult에 왔다");
		
		return "site/bidnotice/bidResult";
	}
	
	@ResponseBody
	@PostMapping("/getNext")
	public Map<String, String> getNext(@RequestBody Map<String, Object> data) {
		log.info("getNext->data: " + data);
		
		Map<String, String> next = this.boardService.getNext(data);
		log.info("next: " + next);
		return next;
	}
	
	@ResponseBody
	@PostMapping("/getPrev")
	public Map<String, String> getPrev(@RequestBody Map<String, Object> data) {
		log.info("getPrev->data: " + data);
		
		Map<String, String> prev = this.boardService.getPrev(data);
		log.info("prev: " + prev);
		return prev;
	}
}
