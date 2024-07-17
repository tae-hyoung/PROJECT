package com.homecat.sweethome.service.impl.publicFacilities;

import java.awt.print.Book;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.mapper.publicFacilities.BookMapper;
import com.homecat.sweethome.service.publicFacilities.BookService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.publicFacilities.BookLoanVO;
import com.homecat.sweethome.vo.publicFacilities.BookVO;

import lombok.extern.slf4j.Slf4j;


/**
 * 도서 관리 
 * 
 * @author 이혜민
 *
 */
@Slf4j
@Service
public class BookServiceImpl implements BookService{

	@Autowired
	BookMapper bookMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AttachDao attachDao;
	
	
	// 도서 리스트
	@Override
	public List<BookVO> bookList(Map<String, Object> map) {
		return this.bookMapper.bookList(map);
	}

	// 총 권수 계산
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.bookMapper.getTotal(map);
	}

	// 책 대여하기
	@Override
	public int rentalAjax(BookLoanVO bookLoanVO) {
		int result =  this.bookMapper.rentalAjax(bookLoanVO);
		log.info("retUpdate(1) -> result : " + result);
		
		BookVO bookVO = new BookVO();
		bookVO.setBookCode(bookLoanVO.getBookCode());
		
		// 대여하면 책 상태 대출불가로 업데이트
        result += this.bookMapper.stateAjax(bookVO);
        log.info("rentalAjax -> state result  : " + result);
        
        return result;
	}

	// 회원별 이미 대여 중인 내역 
	@Override
	public int checkmem(String memId) {
		return this.bookMapper.checkmem(memId);
	}

	
	// 도서 삭제
	@Override
	public int bookDelAjax(BookVO bookVO) {
		return this.bookMapper.bookDelAjax(bookVO);
	}

	
	// 도서 정보 수정
	@Override
	public int bookUpAjax(BookVO bookVO) {
		int result	= this.bookMapper.bookUpAjax(bookVO);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
		String time = sdf.format(date);
		
		if (bookVO.getUploadFile() != null) {
		MultipartFile uploadFile = bookVO.getUploadFile();
		
		result +=uploadController.uploadOne(uploadFile , bookVO.getBookCode()+ time);
		
		AttachVO attachVO = this.attachDao.getFileName(bookVO.getBookCode()+time);
		log.info("attachVO : {}", attachVO);
		
		result += this.bookMapper.updateFileName(attachVO);
		}
		return result;
	}


	// 대여 현황 토탈
	@Override
	public int getTotal2(Map<String, Object> map) {
		return this.bookMapper.getTotal2(map);
	}

	
	// 대여내역 리스트  & 연체
	@Override
	public List<BookLoanVO> rentalList(Map<String, Object> map) {
		
		List<BookLoanVO> result =  this.bookMapper.rentalList(map);
		log.info("rentalList :> {}", result);
		
		 int updateCount = this.bookMapper.lateRet(); 
		log.info("lateRet :> {}", updateCount);
		
		return result;
	}

	
	// 반납 시 상태 업데이트
	@Transactional
	@Override
	public int retUpdate(BookLoanVO bookLoanVO) {
		//bookCode
		int result = this.bookMapper.retUpdate(bookLoanVO);
		log.info("retUpdate(1) -> result : " + result);
		
		//bookCode
		BookVO bookVO = new BookVO();
		bookVO.setBookCode(bookLoanVO.getBookCode());
		
		result += this.bookMapper.boUpdate(bookVO);
		log.info("retUpdate + boUpdate -> result : " + result);
		
		return result;
	}
	
	
	// 대여 상세
	@Override
	public BookLoanVO reDetail(BookLoanVO bookLoanVO) {
		return this.bookMapper.reDetail(bookLoanVO);
	}

	
	// 자동 코드 생성
	@Override
	public String getBookCode() {
		return this.bookMapper.getBookCode();
	}

	
	// 도서 등록
	@Override
	public int createAjax(BookVO bookVO) {
		int result =  this.bookMapper.createAjax(bookVO);
		
		MultipartFile uploadFile = bookVO.getUploadFile();
		
		result +=uploadController.uploadOne(uploadFile, bookVO.getBookCode());
		
		AttachVO attachVO = this.attachDao.getFileName(bookVO.getBookCode());
		log.info("attachVO : {}", attachVO);
		
		result += this.bookMapper.updateFileName(attachVO);
		
		return result;
	}

	
	// 인기순위
	@Override
	public List<BookLoanVO> loanCount() {
		return this.bookMapper.loanCount();
	}

	
	// 나의 대여 목록
	@Override
	public List<BookLoanVO> myRentalList(String memId) {
		return this.bookMapper.myRentalList(memId);
	}

	
	// 연체 카운트
	@Override
	public int cntDanger(String memId) {
		return bookMapper.cntDanger(memId);
	}

	// 보유 통계
	@Override
	public List<Book> catCnt() {
		return bookMapper.catCnt();
	}

	// 대여 통계
	@Override
	public List<BookLoanVO> reCatCnt() {
		return bookMapper.reCatCnt();
	}

}
