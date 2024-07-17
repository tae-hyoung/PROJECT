package com.homecat.sweethome.vo.publicFacilities;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BookVO {
	
	private String bookCode;
	private String bookCat;
	private String intro;
	private String title;
	private String writer;
	private String publisher;
	private int totalPage;
	private int rnum;
	private String status;
	private String attach;
	private String delyn;
	
	private int totalbook;
	
	private String[] bookCodes;
	
	private MultipartFile uploadFile;
	
}
