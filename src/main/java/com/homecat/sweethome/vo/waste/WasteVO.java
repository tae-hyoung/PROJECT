package com.homecat.sweethome.vo.waste;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.Data;

@Data
public class WasteVO {
	private int rnum;			//순번
	private String wasteSeq;
	private String memId;
	private String regDt;
	private String wasteItem;
	private int qty;
	private int fee;
	private String etc;
	private String recycleYn;
	private String estDt;
	private String wasteStatus;
	private String cancelYn;
	private Date cancelTm;
	private String attach;
	private String statusComment;
	
	private MultipartFile[] uploadFiles;	// 업로드할 파일의 정보를 담아둘 변수
	private String filePath;		// 업로드한 파일의 경로를 담아둘 변수
	private List<AttachVO> attachList;
	
	//공통상세코드
	private CommDetailVO commDetailVO;
	private MemberVO memberVO;
	
	private String commDetCodeNm;
	private String commDetCodeDscr;
	
	private AttachVO attachVO;
}
