package com.homecat.sweethome.controller.publicFacilities;

import java.awt.print.Book;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.publicFacilities.BookService;
import com.homecat.sweethome.unit.ArticlePage;
import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.publicFacilities.BookLoanVO;
import com.homecat.sweethome.vo.publicFacilities.BookVO;

import lombok.extern.slf4j.Slf4j;


/**
 * 도서 관리 
 * 
 * @author 이혜민
 *
 */
@Controller
@Slf4j
public class BookController extends BaseController{

	@Autowired
	BookService bookservice;
	
	
	/**
	 * 도서 리스트
	 * @param model
	 * @param currentPage : 페이징 기능을 위한
	 * @param keyword : 검색 기능용 키워드
	 * @param status : 대출가능 , 대출중으로 카테고리 별 볼 수 있는 상태 분류 
	 * @return
	 */
	@GetMapping("/public/book/list")
	public String bookList(Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "status", required = false, defaultValue = "all") String status
			) {

		log.info("bookList 이다.");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("status", status);

		List<BookVO> bookList = this.bookservice.bookList(map);
		log.info("bookList list>> " + bookList);

		List<BookLoanVO> bookLoanList = this.bookservice.loanCount();
		log.info("bookLoanList  : " + bookLoanList);
		
		model.addAttribute("bookLoanList", bookLoanList);

		int total = this.bookservice.getTotal(map);
		log.info("bookList total>> " + total);

		log.info("bookList->keyword : " + keyword);
		model.addAttribute("articlePage", new ArticlePage<BookVO>(total, currentPage, 10, bookList, keyword));

		model.addAttribute("bookList", bookList);

		return "resident/publicFacilities/reBookList";
	}
	
	
	/**
	 * 도서 리스트 아작스 (검색, 카테고리 선택 할 때 필요함)
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping("/public/book/listAjax")
	public ArticlePage<BookVO> listAjax(@RequestBody Map<String, Object> map) {

		int total = this.bookservice.getTotal(map);
		log.info("listAjax total>> " + total);

		List<BookVO> bookList = this.bookservice.bookList(map);
		log.info("listAjax list>> " + bookList);

		return new ArticlePage<BookVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, bookList,
				map.get("keyword").toString());
	}

	
	/**
	 * 책 대여하기 버튼을 눌렀을 때 책은 대출중, 빌린 상태도 대출중으로 
	 * @param bookLoanVO : 도서 대여 VO
	 * @param session : 로그인 한 회원의 정보를 불러오기 위한
	 * @return bookLoanVO : 도서 대여 정보를 담아서 리턴
	 */
	@ResponseBody
	@PostMapping("/public/book/rentalAjax")
	public BookLoanVO rentalAjax(@RequestBody BookLoanVO bookLoanVO, HttpSession session) {

		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");

		String memId = loginMemeber.getMemId();

		bookLoanVO.setMemId(memId);

		log.info("rentalAjax bookLoanVO  : " + bookLoanVO);

		int resultR = this.bookservice.rentalAjax(bookLoanVO);
		log.info("rentalAjax -> rental result  : " + resultR);

		return bookLoanVO;
	}

	
	/**
	 * 회원별  대여 중인 내역 불러와서 최대 3권만 빌릴 수 있도록 
	 * @param memId : 회원 아이디
	 * @param session :  로그인 한 회원 정보 불러오기
	 * @return result : 3권 이상이면 -1, 2권이면 -2, 1권이면 -3 반환
	 */
	@ResponseBody
	@PostMapping("/public/book/checkmem")
	public int checkmem(String memId, HttpSession session) {
		log.info(memId);

		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");

		memId = loginMemeber.getMemId();

		int result = this.bookservice.checkmem(memId);
		log.info("checkmem-->result : " + result);
		System.out.println(result);

		// 사용자가 대출 중이거나 연체된 책이 3권 이상인 경우 -1 반환
		if (result >= 3) {
			return -1;
		} else if (result == 2) {
			return -2;
		} else if (result == 1) {
			return -3;
		}
		return result;
	}

	
	/**
	 * 나의 대여 목록 리스트 불러오기
	 * @param model
	 * @param memId
	 * @param session
	 * @return
	 */
	@GetMapping("/public/book/myRentalList")
	public String myRentalList(Model model, String memId, HttpSession session) {
		log.info("myRentalList 이다");

		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");

		memId = loginMemeber.getMemId();

		List<BookLoanVO> bookLoanList = bookservice.myRentalList(memId);
		log.info("myRentalList bookLoanList : {}", bookLoanList);

		model.addAttribute("bookLoanList", bookLoanList);

		return "resident/publicFacilities/myRentalList";
	}

	
	/**
	 * 연체 카운트
	 * @param session :  로그인 한 회원 별 연체 내역 체크
	 * @return cnt :  연체된 도서 수 반환
	 */
	@ResponseBody
	@PostMapping("/cntDanger")
	public int cntDanger(HttpSession session) {
		log.info("cntDanger 다");
		
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");

		String memId = loginMemeber.getMemId();

		int cnt = bookservice.cntDanger(memId);
		log.info("cntDanger -> cnt : {}", cnt);

		return cnt;
	}

	////////////////////////////////// admin /////////////////////////////////////
	

	/**
	 * 도서 리스트
	 * @param model
	 * @param currentPage :  페이징
	 * @param keyword :  검색 키워드
	 * @return
	 */
	@GetMapping("/public/admin/bookList")
	public String adBookList(Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {

		log.info("bookList 이다. currentPage : " + currentPage + ", keyword : " + keyword);

		// 도서목록 시작 ////////////////
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);

		List<BookVO> bookList = this.bookservice.bookList(map);
		log.info("bookList list>> " + bookList);

		int total = this.bookservice.getTotal(map);
		//total>> 50
		log.info("bookList total>> " + total);
		
		
		List<Book> catCnt = bookservice.catCnt();
		log.info("bookList catCnt >> " + catCnt);
		
		List<BookLoanVO> reCatCnt = bookservice.reCatCnt();
		log.info("bookList reCatCnt >> " + reCatCnt);

		log.info("bookList->keyword : " + keyword);
		model.addAttribute("articlePage", new ArticlePage<BookVO>(total, currentPage, 10, bookList, keyword));

		model.addAttribute("bookList", bookList);
		model.addAttribute("catCnt", catCnt);
		model.addAttribute("reCatCnt", reCatCnt);

		return "admin/publicFacilities/adBookList";
	}

	
	/**
	 * 도서 리스트
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping("/public/admin/bookList")
	public ArticlePage<BookVO> adBookListAjax(@RequestBody Map<String, Object> map) {

		int total = this.bookservice.getTotal(map);
		log.info("adBookListAjax total>> " + total);

		List<BookVO> bookList = this.bookservice.bookList(map);
		log.info("adBookListAjax list>> " + bookList);

		return new ArticlePage<BookVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, bookList,
				map.get("keyword").toString());
	}
	
	
	/**
	 * 도서 삭제
	 * @param bookVO :  도서 삭제
	 * @return result : 책을 성공적으로 삭제 하면 1을 반환
	 */
	@ResponseBody
	@PostMapping("/public/admin/bookDel")
	public int bookDelAjax(@RequestBody BookVO bookVO) {
		System.out.println("admin bookDelAjax다");

		int result = this.bookservice.bookDelAjax(bookVO);
		System.out.println("admin bookDelAjax result : " + result);

		return result;
	}
	
	
	/**
	 * 도서 정보 수정
	 * @param bookVO
	 * @return result : 책을 성공적으로 수정 하면 1을 반환
	 */
	@ResponseBody
	@PostMapping("/public/admin/bookUp")
	public int bookUpAjax(BookVO bookVO) {
		log.info("bookUpAjax-> bookVO : " + bookVO);

		int result = this.bookservice.bookUpAjax(bookVO);
		log.info("bookUpAjax-> result : " + result);

		return result;
	}

	
	/**
	 * 대여 현황 리스트
	 * @param model
	 * @param currentPage
	 * @param keyword
	 * @return
	 */
	@GetMapping("/public/admin/rentalList")
	public String rentalList(Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		log.info("rentalList에 옴");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);

		List<BookLoanVO> bookLoanList = this.bookservice.rentalList(map);
		log.info("bookLoanList  : " + bookLoanList);

		int total = this.bookservice.getTotal2(map);
		log.info("bookList total>> " + total);

		log.info("bookList->keyword : " + keyword);
		model.addAttribute("articlePage2", new ArticlePage<BookLoanVO>(total, currentPage, 10, bookLoanList, keyword));

		model.addAttribute("bookLoanList", bookLoanList);

		return "admin/publicFacilities/adBookList";
	}

	
	// 대여현황 리스트
	@ResponseBody
	@PostMapping("/public/admin/rentalListAjax")
	public ArticlePage<BookLoanVO> rentalListAjax(@RequestBody Map<String, Object> map) {
		log.info("rentalListAjax에 옴" + map);

		int total = this.bookservice.getTotal2(map);
		log.info("rentalListAjax total>> " + total);

		List<BookLoanVO> bookLoanList = this.bookservice.rentalList(map);
		log.info("bookLoanList>>>  : " + bookLoanList);

		return new ArticlePage<BookLoanVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, bookLoanList,
				map.get("keyword").toString(), "ajax", 0);
	}

	
	/**
	 * 반납처리 했을 때  반납완료로 상태 바꾸고 반납일에 날자 찍기
	 * @param bookLoanVO :  도서 대여 VO
	 * @return result : 책을 성공적으로 반납 하면 1을 반환
	 */
	@ResponseBody
	@PostMapping("/public/admin/retUpdate")
	public int retUpdate(@RequestBody BookLoanVO bookLoanVO) {

		int result = this.bookservice.retUpdate(bookLoanVO);
		log.info("retUpdate -> result : " + result);

		return result;
	}

	
	/**
	 * 대여 정보 상세 모달
	 * @param bookLoanVO
	 * @param model
	 * @return bookLoanVO :  상세정보를 뽑기 위한  VO객체
	 */
	@ResponseBody
	@PostMapping("/public/admin/reDetail")
	public BookLoanVO reDetail(@RequestBody BookLoanVO bookLoanVO, Model model) {
		log.info("reDetail에 왔다");

		bookLoanVO = this.bookservice.reDetail(bookLoanVO);
		log.info("reDetail ->>>> bookLoanVO : " + bookLoanVO);

		model.addAttribute("bookLoanVO", bookLoanVO);

		return bookLoanVO;
	}


	/**
	 * 도서 등록 시 코드 자동 생성
	 * @return result : 도서 코드 자동 생성 해서 리턴
	 */
	@ResponseBody
	@PostMapping("/public/admin/getBookCode")
	public String getBookCode() {
		log.info("/getBookCode옴");

		String result = this.bookservice.getBookCode();
		log.info("getBookCode->result : " + result);

		return result;
	}

	
	/**
	 * 도서 등록
	 * @param bookVO :  도서VO
	 * @return result : 책을 성공적으로 등록 하면 1을 반환
	 */
	@ResponseBody
	@PostMapping("/public/admin/createAjax")
	public int createAjax(BookVO bookVO) {
		log.info("createAjax 이당: ");
		log.info("createAjax :  {} ", bookVO);

		// 도서등록
		int result = this.bookservice.createAjax(bookVO);
		log.info("result : " + result);

		return result;
	}
	

}
