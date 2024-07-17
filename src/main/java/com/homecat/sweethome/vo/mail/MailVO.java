package com.homecat.sweethome.vo.mail;

import lombok.Data;

@Data
public class MailVO {
	//회원아이디
	private String memId;
	//회원명
	private String memNm;
	//회원 연락처
	private String memTelno;
	//메일제목
	private String subject;
	//메일내용
	private String content;
	//발송인
	private String from = "audwls0910@naver.com";
	//수신인(비밀번호 찾는 사람)
	private String to;
}
