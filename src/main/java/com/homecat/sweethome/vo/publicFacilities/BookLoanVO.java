package com.homecat.sweethome.vo.publicFacilities;

import java.util.List;


import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.room.RoomVO;

import lombok.Data;

@Data
public class BookLoanVO {

	private int rnum;
	private int loanCount;
	private String loanSeq;
	private String bookCode;
	private String memId;
	private String loanDt;  // sysdate
	private String returnDt;
	private String returnStatus;
	
	private String[] bookCodes;
	
	private int totalReBook;
	
	private List<MemberVO> memList;
	private List<RoomVO> roomList;
	private List<BookVO> bookList;
	
	////////캘린더 연동
	private String rentDay;

}
