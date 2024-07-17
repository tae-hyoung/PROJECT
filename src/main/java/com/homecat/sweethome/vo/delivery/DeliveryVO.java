package com.homecat.sweethome.vo.delivery;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.vo.ccpy.CcpyVO;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.Data;

@Data
public class DeliveryVO {
	private int rnum;//순번
	private String pckSeq;  //택배신청 일련번호
	private String regDt; //신청일
	private String pickUpDt; // 수거일
	private String pckItem; // 운송품목
	private int weigh; // 무게
	private int price; // 금액
	private int pckQty; // 수량
	private int pckTotal; //  총액
	private String pckStatus; // 처리여부
	private String memId;  // 회원아이디
	private String ccpyCode; //협력업체 코드
	private String cancelYn; // 신청 철회 여부
	private String cancelTm; // 신청 철회 일시
	private String attach; // 첨부파일
	private String sendName;  // 보내는 사람 - 이름
	private String sendTel; // 보내는 사람  - 전화번호
	private String sendAddress; // 보내는 사람 - 주소
	private String reName; // 받는 사람 - 이름
	private String reTel; // 받는 사람 - 전화번호
	private int rePost; // 받는 사람 - 우편번호
	private String reAddress; // 받는 사람 - 주소
	private String reDeAddress;	// 받는 사람 - 상세주소
	private String hopeDt; // 희망일
	private String backComment; // 반려 사유
	private String backYn; // 반려 여부
	private String backTm; // 반려 일시
	private String ccpyName; // 택배사명
	
	
	private List<CommDetailVO> commDetailVOList;
	
	private List<CcpyVO> ccpyVOList;
	
	private MultipartFile uploadFile;
	
	private List<MemberVO> memberVOList;
	
	private List<DanjiVO> danjiVOList;
	
	// 월별 통계
	private String yearMonth;
	private int count;
	// 요일별 통계
	private String dayOfWeek;
	
}
