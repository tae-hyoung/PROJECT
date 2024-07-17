package com.homecat.sweethome.mapper.publicFacilities;

import java.awt.print.Book;
import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.publicFacilities.BookLoanVO;
import com.homecat.sweethome.vo.publicFacilities.BookVO;

public interface BookMapper {
	
	public List<BookVO> bookList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public BookVO detail(BookVO bookVO);

	public int rentalAjax(BookLoanVO bookLoanVO);

	public int stateAjax(BookVO bookVO);

	public int checkmem(String memId);

	
	
	public int bookDelAjax(BookVO bookVO);

	public int bookUpAjax(BookVO bookVO);

	public List<BookLoanVO> rentalList(Map<String, Object> map);

	public int getTotal2(Map<String, Object> map);

	public int retUpdate(BookLoanVO bookLoanVO);

	public int boUpdate(BookVO bookVO);

	public BookLoanVO reDetail(BookLoanVO bookLoanVO);

	public String getBookCode();

	public int createAjax(BookVO bookVO);

	public int lateRet();

	public List<BookLoanVO> loanCount();

	public List<BookLoanVO> myRentalList(String memId);

	public int cntDanger(String memId);

	public int updateFileName(AttachVO attachVO);

	public List<Book> catCnt();

	public List<BookLoanVO> reCatCnt();

	///////////////////캘린더/////////////////////
	public List<BookLoanVO> rentList(BookLoanVO bookLoanVO);

}
