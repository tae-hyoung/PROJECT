package com.homecat.sweethome.vo.attach;


import lombok.Data;

@Data
public class AttachVO {
	private String globalCode;
	private int attchSeq;
	private String fileName;
	private long fileSize;
	private String contentType;
	private String regDt;
	private String delYn;
	private String firstRegDt;
	private String firstRegId;
	private String useYn;
}
