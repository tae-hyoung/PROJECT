package com.homecat.sweethome.vo.maintenance;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.ccpy.CcpyVO;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.Data;

@Data
public class MaintenanceVO {

	private int rnum;			//순번
	private String mtSeq;		//일련번호
	private String mtDetail;	//상세내용
	private String regDt;		//등록일
	private String prcsDt;		//처리일
	private String mtStatus;	//처리상태
	private String attach;		//첨부파일
	private String memId;		//신청인ID
	private String ccpyCode;	//협력업체코드
	private String cancelYn;	//취소여부
	private String cancelTm;	//취소시간
	private String mtConst;		//하자보수공종
	private String mtLocation;	//상세위치
	private String statusContent;	//처리결과
	private String mtNote;			//비고
	private int cnt;
	
	private String schMtStatus;		//처리상태(검색조건)
	
	//공통상세코드
	private CommDetailVO commDetailVO;
	
	private MemberVO memberVO;
	private DanjiVO danjiVO;
	private CcpyVO ccpyVO;
	
	//파일업로드
	private MultipartFile[] uploadFiles;	// 업로드할 파일의 정보를 담아둘 변수
	private String filePath;
	private List<AttachVO> attachList;
	private List<CcpyVO> ccpyList;
}
