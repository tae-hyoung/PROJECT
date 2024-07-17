package com.homecat.sweethome.vo.message;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MessageVO {
	
	private int msgSeq;
	private String sender; // 발신
	private String receiver; // 수신
	private String title;
	private String content;
	@DateTimeFormat(pattern="yyyy.MM.dd HH:mm:ss")
	private Date sendDt;
	private String readYn;
	private String sendDel; // 보낸 사람이 삭제
	private String receiveDel; // 받는 사람이 삭제
}
