package com.homecat.sweethome.vo.complain;

import lombok.Data;

@Data
public class ComplainVO {
	private String compSeq;
	private String memId;
	private String compContent;
	private String regDt;
	private String reply;
	private String replyDt;
	private String delYn;
}
