package com.homecat.sweethome.vo.vote;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.Data;

@Data
public class VoteDetailVO {
	private String vdCode; 					//투표상세번호
	private String voteCode;				//투표번호
	private String vdItem;					//투표내용
	private String attach;					//첨부파일
	
	private List<String> replyers; 			// 투표자 목록
	
	private MultipartFile[] uploadFiles;	// 업로드할 파일의 정보를 담아둘 변수
	private String filePath;				// 업로드한 파일의 경로를 담아둘 변수
	private List<AttachVO> attachList;
	
	//공통상세코드
	private CommDetailVO commDetailVO;
	private MemberVO memberVO;
	
	private String commDetCodeNm;
	private String commDetCodeDscr;
	
	private AttachVO attachVO;
}
