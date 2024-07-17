package com.homecat.sweethome.vo.member;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.vo.danji.DanjiVO;

import lombok.Data;

@Data
/**
 * 입주민 VO
 * @author PC-09
 *
 */
public class MemberVO {
	private String memId;
	private String roomCode; // 협력업체일 경우 호실코드 0
	private String memPw;
	private String memNm;
	@DateTimeFormat(pattern="yyyy.MM.dd")
	private Date memBirth;
	private String memSex;
	private String memTelno;
	private String memEmail;
	private String nickname;
	@DateTimeFormat(pattern="yyyy.MM.dd HH:mm:ss")
	private String regDt;
	private String signDt;
	private String mviStatus;
	private String profImg;
	private String hshldrId; 
	private String memAuth; // 권한
	private String ccpyCode; // 협력업체코드
	private String enabled; // 사용가능여부
	
	private String dongCode;	
	private String danjiName;
	
	//MEMBER : MEMBER_AUTH = 1 : N
	private List<MemberAuthVO> memberAuthVOList;
	
	private List<DanjiVO> danjiVOList;
	
	private MultipartFile picture;
}

