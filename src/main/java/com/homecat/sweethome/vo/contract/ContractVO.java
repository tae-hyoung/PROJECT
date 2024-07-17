package com.homecat.sweethome.vo.contract;


import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ContractVO {
	
	private String ctSeq;
	private String ctCt;
	private String ctTitle;
	private String ctRegDt;
	private String ctAttach;
	
	private int rnum;
	
	private MultipartFile[] myFiles;
}
