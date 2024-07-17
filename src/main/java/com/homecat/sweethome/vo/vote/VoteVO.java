package com.homecat.sweethome.vo.vote;


import java.util.List;

import lombok.Data;

@Data
public class VoteVO {
	private String voteCode;	//투표 번호
	private String voteTitle;	//투표 제목
	private int count;			//참여자 수
	private String beginTm;		//투표 시작일
	private String endTm;		//투표 마감일
	private String endYn;		//마감여부
	
	
	private int totalPage; 		// 총 페이지 수	
	private int rnum;			// 행 번호
	
	
	private List<VoteDetailVO> voteDetails;	// 투표 상세


	private List<VoteResultVO> voteResultVOList;	//설문 결과
}
