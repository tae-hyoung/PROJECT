package com.homecat.sweethome.controller.board;

import java.util.ArrayList;
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
import com.homecat.sweethome.service.board.BoardService;
import com.homecat.sweethome.unit.ArticlePage;
import com.homecat.sweethome.vo.board.BoardVO;
import com.homecat.sweethome.vo.board.JJIMVO;
import com.homecat.sweethome.vo.board.ReplyVO;
import com.homecat.sweethome.vo.board.ReportVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board")
@Controller
public class BoardController extends BaseController {

	@Autowired
	BoardService boardService;
	
	@GetMapping("/list")
	public String boardList(Model model,
			@RequestParam(value = "boardCat", required = false, defaultValue = "") String boardCat, 
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		log.info("boardList에 왔다");
		
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
		
		return "resident/board/list";
	}
	
	@ResponseBody
	@PostMapping("/list")
	public ArticlePage<BoardVO> boardListAjax(@RequestBody Map<String, Object> map) {
		log.info("boardListAjax->data: " + map);
		
		int size = 10;
		
		int total = this.boardService.getTotal(map);
		log.info("boardListAjax->total: " + total);
		
		List<BoardVO> boardVOList = this.boardService.getList(map);
		log.info("boardListAjax->boardVOList: " + boardVOList);
		
		return new ArticlePage<BoardVO>(total, Integer.parseInt(map.get("currentPage").toString()), size, boardVOList, map.get("keyword").toString(), map.get("boardCat").toString());
	}
	
	@GetMapping("/detail")
	public String boardDetail(Model model, String brdNo) {
		log.info("boardList에 왔다");
		
		BoardVO boardVO = this.boardService.getDetail(brdNo);
		log.info("boardVO: " + boardVO);
		
		model.addAttribute("boardVO", boardVO);
		
		return "resident/board/detail";
	}
	
	@ResponseBody
	@PostMapping("/countLike")
	public int countLike(@RequestBody HashMap<String, String> data) {
		log.info("countLikeAjax->data: " + data);

		int likeCnt = this.boardService.countLike(data);
		log.info("countLikeAjax->cnt: " + likeCnt);
		
		return likeCnt;
	}
	
	@ResponseBody
	@PostMapping("reply")
	public List<ReplyVO> replyAjax(@RequestBody ReplyVO replyVO) {
		log.info("replyPost->replyVO: " + replyVO);
		
		List<ReplyVO> replyList = this.boardService.insertReply(replyVO);
		log.info("replyPost->replyList: " + replyList);
		
		return replyList;
	}
	
	@ResponseBody
	@PostMapping("replyList")
	public List<ReplyVO> replyListAjax(@RequestBody Map<String, Object> map) {
		log.info("replyListAjax->map: " + map);
		
		List<ReplyVO> replyList = null;
		if(map.get("admin") != null) {
			replyList = this.boardService.replyAllList(map);
		}else {
			replyList = this.boardService.replyList(map);
		}
		
		log.info("replyPost->replyList: " + replyList);
		
		return replyList;
	}
	
	@ResponseBody
	@PostMapping("/repDel")
	public List<ReplyVO> repDel(@RequestBody HashMap<String , String> data) {
		log.info("repDelAjax->data: " + data);
		
		List<ReplyVO> replyList = this.boardService.repDel(data);
		
		return replyList;
	}
	
	@GetMapping("/insert")
	public String brdInsert(@RequestParam String boardCat, Model model) {
		log.info("brdInsert에 왔다");
		
		model.addAttribute("boardCat", boardCat);
		
		return "resident/board/insert";
	}
	
	@PostMapping("/insert")
	public String brdInsertPost(BoardVO boardVO) {
		log.info("brdInsertPost->boardVO: " + boardVO);
		
		boardVO.setDanjiCode("D001");	// 단지코드 하드코딩
		
		int result = this.boardService.insertBoard(boardVO);
		log.info("brdInsertPost->result: " + result);
		
		if(boardVO.getBrdCat().equals("board_trade")) {
			log.info("중고거래 목록");
			return "redirect:/board/tradeList";
		}else {
			log.info("그외 목록");
			return "redirect:/board/list?boardCat="+boardVO.getBrdCat();
		}
	}
	
	@GetMapping("/update")
	public String brdUpdate(Model model, @RequestParam String brdSeq) {
		log.info("brdUpdate->brdSeq: " + brdSeq);
		
		BoardVO boardVO = this.boardService.getDetail(brdSeq);
		log.info("boardVO: " + boardVO);
		
		model.addAttribute("boardVO", boardVO);
		return "resident/board/update";
	}
	
	@PostMapping("/update")
	public String brdUpdatePost(BoardVO boardVO) {
		log.info("brdUpdatePost->boardVO: " + boardVO);
		
		int cnt = this.boardService.update(boardVO);
		log.info("brdUpdatePost->cnt: " + cnt);
		
		return "redirect:/board/detail?brdNo="+boardVO.getBrdSeq();
	}
	
	@GetMapping("/delete")
	public String brdDelete(@RequestParam String brdSeq, @RequestParam String brdCat) {
		log.info("brdDelete에 왔다");
		
		int cnt = this.boardService.delete(brdSeq);
		log.info("brdDelete->cnt: " + cnt);
		
		return "redirect:/board/list?boardCat="+brdCat;
	}
	
	@ResponseBody
	@PostMapping("/report")
	public int report(@RequestBody Map<String, Object> data) {
		log.info("report->data: " + data);
		
		int cnt = this.boardService.report(data);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/JJIM")
	public int JJIM(@RequestBody Map<String, Object> data) {
		log.info("JJIM->data: " + data);
		
		int cnt = this.boardService.JJIM(data);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/getJJIMList")
	public List<JJIMVO> getJJIMList(@RequestBody Map<String, Object> data) {
		log.info("JJIM->data: " + data);
		
		List<JJIMVO> JJIMVOList = this.boardService.getJJIMList(data);
		log.info("JJIMVOList: " + JJIMVOList);
		
		return JJIMVOList;
	}
	
	@ResponseBody
	@PostMapping("/getJJIMListById")
	public List<JJIMVO> getJJIMListById(@RequestBody String memId) {
		log.info("JJIM->memId: " + memId);
		
		memId = memId.replace("\"", "");
		
		List<JJIMVO> JJIMVOList = this.boardService.getJJIMListById(memId);
		log.info("JJIMVOList: " + JJIMVOList);
		
		return JJIMVOList;
	}
	
	@GetMapping("/tradeList")
	public String tradeList(Model model) {
		log.info("중고거래 게시판에 왔다.");
		
		List<BoardVO> boardVOList = this.boardService.getTradeList();
		log.info("boardVOList", boardVOList);
		
		model.addAttribute("boardVOList", boardVOList);
		
		return "resident/board/tradeList";
	}
	
	
	////////////////////////////// 관리자 //////////////////////////////
	@GetMapping("/admin/list")
	public String adminBoardList(Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		log.info("boardList에 왔다");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword",keyword );
		map.put("currentPage", currentPage);
		log.info("boardList->map: " + map);
		
		int size = 10;
		
		List<BoardVO> boardVOList = this.boardService.getAllList(map);
		log.info("boardVOList: " + boardVOList);
		
		int total = this.boardService.getAllTotal(map);
		log.info("boardVOList->total: " + total);
		
		model.addAttribute("articlePage", new ArticlePage<BoardVO>(total, currentPage, size, boardVOList, keyword));
		
		
		return "admin/board/list";
	}
	
	@ResponseBody
	@PostMapping("/admin/chartData")
	public List<Object> getChartData() {
		// 통계 자료 구하기
		List<Map<String, Integer>> dateChartData = this.boardService.getDateChart();
		List<Map<String, Integer>> cateChartData = this.boardService.getCateChart();
		
		log.info("dateChartData: " + dateChartData);
		log.info("cateChartData: " + cateChartData);
		
		List<Object> data = new ArrayList<Object>();
		
		data.add(dateChartData);
		data.add(cateChartData);
		
		return data;
	}

	@ResponseBody
	@PostMapping("/admin/list")
	public ArticlePage<BoardVO> adminBoardListAjax(@RequestBody Map<String, Object> map) {
		log.info("boardListAjax->data: " + map);
		
		int size = 10;
		
		int total = this.boardService.getAllTotal(map);
		log.info("boardListAjax->total: " + total);
		
		List<BoardVO> boardVOList = this.boardService.getAllList(map);
		log.info("boardListAjax->boardVOList: " + boardVOList);
		
		return new ArticlePage<BoardVO>(total, Integer.parseInt(map.get("currentPage").toString()), size, boardVOList, map.get("keyword").toString());
	}
	
	@ResponseBody
	@PostMapping("/ListByCat")
	public ArticlePage<BoardVO> adminSelCat(@RequestBody Map<String, Object> map) {
		log.info("ListByCat->data: " + map);
		
		int size = 10;
		
		int total = this.boardService.getTotalByCat(map);
		log.info("ListByCat->total: " + total);
		
		List<BoardVO> boardVOList = this.boardService.getListByCat(map);
		log.info("ListByCat->boardVOList: " + boardVOList);
		
		return new ArticlePage<BoardVO>(total, Integer.parseInt(map.get("currentPage").toString()), size, boardVOList, map.get("keyword").toString());
	}
	
	@GetMapping("/admin/insert")
	public String adminBrdInsert() {
		log.info("brdInsert에 왔다");
		return "admin/board/insert";
	}
	
	@PostMapping("/admin/insert")
	public String adminBrdInsertPost(BoardVO boardVO) {
		log.info("brdInsertPost->boardVO: " + boardVO);
		
		boardVO.setDanjiCode("D001");	// 단지코드 하드코딩
		
		int result = this.boardService.insertBoard(boardVO);
		log.info("brdInsertPost->result: " + result);
		
		return "redirect:/board/admin/list";
	}

	@GetMapping("/admin/detail")
	public String boardAdminDetail(Model model, String brdNo) {
		log.info("boardAdminDetail에 왔다");
		
		BoardVO boardVO = this.boardService.getDetail(brdNo);
		log.info("boardVO: " + boardVO);
		
		model.addAttribute("boardVO", boardVO);
		
		return "admin/board/detail";
	}
	
	@GetMapping("/admin/update")
	public String brdAdminUpdate(Model model, @RequestParam String brdSeq) {
		log.info("brdAdminUpdate->brdSeq: " + brdSeq);
		
		BoardVO boardVO = this.boardService.getDetail(brdSeq);
		log.info("boardVO: " + boardVO);
		
		model.addAttribute("boardVO", boardVO);
		return "admin/board/update";
	}
	
	@PostMapping("/admin/update")
	public String brdAdminUpdatePost(BoardVO boardVO) {
		log.info("brdAdminUpdatePost->boardVO: " + boardVO);
		
		int cnt = this.boardService.update(boardVO);
		log.info("brdUpdatePost->cnt: " + cnt);
		
		return "redirect:/board/admin/detail?brdNo="+boardVO.getBrdSeq();
	}
	
	@ResponseBody
	@PostMapping("/admin/delete")
	public int brdAdminDelete(@RequestBody Map<String, Object> map) {
		log.info("brdAdminDelete->map: " + map);
		
		int cnt = this.boardService.adminDelete(map);
		log.info("brdAdminDelete->cnt: " + cnt);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/blind")
	public int blind(@RequestBody Map<String, Object> data) {
		log.info("blind->data: " + data);
		
		// 블라인드 처리
		int cnt = this.boardService.toggleBlind(data);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/admin/reportList")
	public List<ReportVO> reportList(@RequestBody Map<String, Object> data) {
		log.info("reportList->data: " + data);
		
		List<ReportVO> reportVOList = this.boardService.getReportList(data);
		
		return reportVOList;
	}

	
}
