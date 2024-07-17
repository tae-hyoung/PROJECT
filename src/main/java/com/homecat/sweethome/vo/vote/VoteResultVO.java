package com.homecat.sweethome.vo.vote;


import lombok.Data;

@Data
public class VoteResultVO {
	private String vrSeq;		//투표 응답 번호
	private String replyer;		//응답자(회원아이디-공통코드)
	private String vdCode;		//투표상세 번호
	private String reply;		//응답내용 (후보자)
	private String regDt;		//응답일
	private String voteCode;	//투표 번호
}
