package com.homecat.sweethome.vo.board;

import lombok.Data;

@Data
public class ReplyVO {
	private String repSeq;
	private String brdSeq;
	private String memId;
	private String content;
	private String regDt;
	private int likeCnt;
	private int reportCnt;
	private String delYn;
	private String nickname;
}
