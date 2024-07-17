package com.homecat.sweethome.mail;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.mapper.member.MemberMapper;
import com.homecat.sweethome.vo.mail.MailVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 메일전송
 */
@Slf4j
@Controller
public class MailUtils {
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	//기본 모드 : apache
	@ResponseBody
	@GetMapping("/sendEmail")
	public String sendEmail() throws Exception {
		Email email = new SimpleEmail();
		email.setHostName("smtp.naver.com");
		email.setSmtpPort(465);
		email.setCharset("euc-kr");// 인코딩 설정(utf-8, euc-kr)
		email.setAuthenticator(new DefaultAuthenticator("audwls0910", "q1w2e3r4t5y6"));
//		email.setSSL(true);
		email.setFrom("audwls0910@naver.com", "SWEET HOME");
		email.setSubject("메일전송 제목 테스트");
		email.setMsg("메일전송 내용 테스트");
		email.addTo("audwls0910@naver.com", "테스터");
		email.send();
		
		return "success";
	}
	
	// bean 설정을 했을 경우
	//오버로딩(mode : javax)
	@ResponseBody
	@PostMapping("/sendEmailx")
	public String sendEmail(@RequestBody MailVO mailVO) throws Exception {
		
		log.info("sendEmail->mailVO : " + mailVO);
				
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId(mailVO.getMemId());
		memberVO.setMemNm(mailVO.getMemNm());
		memberVO.setMemTelno(mailVO.getMemTelno());
		log.info("sendEmail->memberVO : " + memberVO);
		
		//////// 회원 검증 ///////
		MemberVO validatedMemberVO = this.memberMapper.pwFind(memberVO);
		log.info("sendEmail->validatedMemberVO : " + validatedMemberVO);
		
		if(validatedMemberVO!=null) {
			// 메일 내용
			String subject = "SweetHome 임시 비밀번호 입니다.";
			
			//1) 짧은 랜덤값 생성
			String tmpPw = tempPw();
			
			String content = "임시 비밀번호가 발급 되었습니다.\n\n";
			content += "임시 비밀번호 : ";
			content += tmpPw;
			content += "\n\n 임시비밀번호를 통해 로그인 후 비밀번호를 변경해주세요.";
			
			//2) member테이블의 비밀번호를 encodedtmpPw로 변경
			String encodedtmpPw = bcryptPasswordEncoder.encode(tmpPw);
	
			// 보내는 사람
			String from = "audwls0910@naver.com";
	
			// 받는 사람
			String to = validatedMemberVO.getMemEmail();
			
			validatedMemberVO.setMemPw(encodedtmpPw);
	
			try {
				// 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
	
				// 메일 내용을 채워줌
				mailHelper.setFrom(from);	// 보내는 사람 셋팅
				mailHelper.setTo(to);		// 받는 사람 셋팅
				mailHelper.setSubject(subject);	// 제목 셋팅
				mailHelper.setText(content);	// 내용 셋팅
	
				// 메일 전송
				mailSender.send(mail);
				
				validatedMemberVO = this.memberMapper.pwChange(validatedMemberVO);
				
				
			} catch(Exception e) {
				log.info(e.getMessage());
			}
			
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 인증키 발급
	 * @return
	 */
	public String tempPw() {
	
		List<Integer> tmp = new ArrayList<>();
		for(int i = 0; i < 10; i++) {
			tmp.add(i);
		}
		 
		Collections.shuffle(tmp);
		 
		StringBuilder tempPw = new StringBuilder();
		
		for(int i = 0; i < 6; i++) {
			tempPw.append(tmp.get(i));
		}
		
		return tempPw.toString();
	}
}
