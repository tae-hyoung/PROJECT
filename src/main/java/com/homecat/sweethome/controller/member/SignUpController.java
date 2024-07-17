package com.homecat.sweethome.controller.member;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.service.member.SignUpService;
import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SignUpController {

	@Inject
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	SignUpService signUpSerivce;
	
	@Autowired
	String uploadProfile;
	

	@GetMapping("/select")
	public String SelectMem() {
		log.info("회원가입 선택하기!");

		return "/member/select";
	}

	/**
	 * 입주민 회원가입
	 * @return
	 */
	@GetMapping("/signup")
	public String SignUp(Model model) {
		log.info("입주민 회원가입 페이지");
		List<DanjiVO> danjiList = signUpSerivce.selDanji();
		model.addAttribute("danjiList", danjiList);
		return "/member/signup";
	}
	
	/**
	 * 관리자 회원가입 페이지
	 */
	@GetMapping("/adminSignUp")
	public String SignUpAdmin(Model model) {
		log.info("관리자/협력업체 회원가입 페이지");
		List<DanjiVO> danjiList = signUpSerivce.selDanji();
		model.addAttribute("danjiList", danjiList);
		return "member/adminSignUp";
	}	
	
	/**
	 * 회원가입 폼에서 작성한 내용을 AJAX를 통해 데이터를 받고 서비스로 보내버림
	 * 파일이 있으면 파일 업로드를 함
	 * @param memberVO
	 * @param file
	 * @return
	 */
	@PostMapping("/signUp.do")
	@ResponseBody
	public String signUpAjax(@RequestPart("memberVO") MemberVO memberVO, 
			@RequestPart(value ="file", required = false) MultipartFile file)
	{

		log.info("회원가입 시도.");		
		// 파일 업로드 했냐고~
		try {
			if(file != null && !file.isEmpty()) {
				
				log.info("업로드 된 파일 -> {}",  file.getOriginalFilename());
				log.info("업로드 된 파일  크기 -> {}",  file.getSize());
				
				String orgFileName = file.getOriginalFilename();
				String ext = orgFileName.substring(orgFileName.indexOf("."));
				String newFileName = memberVO.getMemId() + "Photo" + ext;
					
				File saveFile = new File(uploadProfile, newFileName);
				try {
					file.transferTo(saveFile);
				} catch (IllegalStateException e) {
					log.info(e.getMessage());
				} catch (IOException e) {
					log.info(e.getMessage());
				} catch(NullPointerException e) {
					
				}
			}
			
			// 비밀번호 시큐리티 인코딩
			String encodedPw = bcryptPasswordEncoder.encode(memberVO.getMemPw());
			memberVO.setMemPw(encodedPw);
			
			int rst = signUpSerivce.signUpMember(memberVO);
	
			if (rst == 1) {
				log.info("가입 신청완료.");
				return "가입 됐슈";
			} else {
				log.info("가입 실패.");
				return "오류 났슈";
			}
		}catch(Exception e) {
			log.info(e.getMessage());
			return "error";
		}
	}
	
	@PostMapping("/signUpAdmin.do")
	@ResponseBody
	public String signUpAdmin(@RequestPart("memberVO") MemberVO memberVO, 
			@RequestPart(value ="file", required = false) MultipartFile file) {
		log.info("주택관리자 회원가입 시도.");
		
		try {
			if(file != null && !file.isEmpty()) {
				
				log.info("업로드 된 파일 -> {}",  file.getOriginalFilename());
				log.info("업로드 된 파일  크기 -> {}",  file.getSize());
				
				String orgFileName = file.getOriginalFilename();
				String ext = orgFileName.substring(orgFileName.indexOf("."));
				String newFileName = memberVO.getMemId() + "Photo" + ext;
					
				File saveFile = new File(uploadProfile, newFileName);
				try {
					file.transferTo(saveFile);
				} catch (IllegalStateException e) {
					log.info(e.getMessage());
				} catch (IOException e) {
					log.info(e.getMessage());
				} catch(NullPointerException e) {
					
				}
			}
			
			// 비밀번호 시큐리티 인코딩
			String encodedPw = bcryptPasswordEncoder.encode(memberVO.getMemPw());
			memberVO.setMemPw(encodedPw);
			
			int rst = signUpSerivce.signUpAdmin(memberVO);
	
			if (rst == 1) {
				log.info("가입 신청완료.");
				return "가입 됐슈";
			} else {
				log.info("가입 실패.");
				return "오류 났슈";
			}
		}catch(Exception e) {
			log.info(e.getMessage());
			return "error";
		}
	}
	
	@PostMapping("/signUpPartner.do")
	@ResponseBody
	public String signUpPartner(@RequestPart("memberVO") MemberVO memberVO, 
			@RequestPart(value ="file", required = false) MultipartFile file) {
		log.info("협력업체 회원가입 시도.");
		
		try {
			if(file != null && !file.isEmpty()) {
				
				log.info("업로드 된 파일 -> {}",  file.getOriginalFilename());
				log.info("업로드 된 파일  크기 -> {}",  file.getSize());
				
				String orgFileName = file.getOriginalFilename();
				String ext = orgFileName.substring(orgFileName.indexOf("."));
				String newFileName = memberVO.getMemId() + "Photo" + ext;
					
				File saveFile = new File(uploadProfile, newFileName);
				try {
					file.transferTo(saveFile);
				} catch (IllegalStateException e) {
					log.info(e.getMessage());
				} catch (IOException e) {
					log.info(e.getMessage());
				} catch(NullPointerException e) {
					
				}
			}
			
			// 비밀번호 시큐리티 인코딩
			String encodedPw = bcryptPasswordEncoder.encode(memberVO.getMemPw());
			memberVO.setMemPw(encodedPw);
			
			int rst = signUpSerivce.signUpPartner(memberVO);
	
			if (rst == 1) {
				log.info("가입 신청완료.");
				return "가입 됐슈";
			} else {
				log.info("가입 실패.");
				return "오류 났슈";
			}
		}catch(Exception e) {
			log.info(e.getMessage());
			return "error";
		}
	}
	
	
	
	
	//연/월/일 폴더 생성
	public String getFolder() {
		//2024-05-03 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2024-05-03
		String str = sdf.format(date);
		//2024-05-03 -> 2024\\05\\03
		//File.separator : 윈도우 경로
		return str.replace("-", File.separator);
	}
}
