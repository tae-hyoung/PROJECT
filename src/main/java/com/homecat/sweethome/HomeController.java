package com.homecat.sweethome;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.homecat.sweethome.service.bidnotice.BidNoticeService;
import com.homecat.sweethome.service.board.BoardService;
import com.homecat.sweethome.service.site.SiteService;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.bidnotice.BidNoticeVO;
import com.homecat.sweethome.vo.board.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	SiteService siteService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BidNoticeService bidnoticeService;
	
	@Autowired
	UploadController uploadController;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		log.info("home에 왔다");
		
		int visitTotal = this.siteService.getVisitTotal();
		int visitToday = this.siteService.getVisitToday();
		
		log.info("visitCnt: " + visitTotal);
		log.info("visitCnt: " + visitToday);
		
		List<BoardVO> boardVOList = this.boardService.getList(5);
		log.info("boardVOList: " + boardVOList);

		List<BidNoticeVO> bidnoticeVOList = this.bidnoticeService.getList(5);
		log.info("bidnoticeVOList: " + bidnoticeVOList);
		
		model.addAttribute("visitTotal", visitTotal);
		model.addAttribute("visitToday", visitToday);
		model.addAttribute("boardVOList", boardVOList);
		model.addAttribute("bidnoticeVOList", bidnoticeVOList);
		
		return "home";
	}
	
	@RequestMapping(value = "/login22", method = RequestMethod.GET)
	public String loginTest(Model model) {
		log.info("home에 왔다");
		
		List<BoardVO> boardVOList = this.boardService.getList(5);
		log.info("boardVOList: " + boardVOList);
		
		model.addAttribute("boardVOList", boardVOList);
		model.addAttribute("login", "ok");
		
		return "home";
	}
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "test/home";
	}
	

	
}
