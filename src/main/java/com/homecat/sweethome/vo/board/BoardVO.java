package com.homecat.sweethome.vo.board;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	private String brdSeq;
	private String danjiCode;
	private String brdCat;
	private String memId;
	private String title;
	private String content;
	private String regDt;
	private String updDt;
	private int viewCnt;
	private int likeCnt;
	private int reportCnt;
	private String blindYn;
	private String delYn;
	private String nickname;
	private String thumbnail;
	private MultipartFile attach;
	
	private int rnum;
	
	private List<ReplyVO> replyVOList;
}
