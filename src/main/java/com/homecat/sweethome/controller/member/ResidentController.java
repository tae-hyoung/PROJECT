package com.homecat.sweethome.controller.member;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.member.ResidentService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/resident")
@Controller
public class ResidentController extends BaseController {

	@Autowired
	String uploadProfile;

	@Autowired
	ResidentService residentService;

	@GetMapping("/profile")
	public String main() {
		log.info("입주민 마에페이지!!");

		return "resident/myPage";
	}

	@ResponseBody
	@GetMapping("/getProfile")
	public List<MemberVO> getProfile(@RequestParam String memId) {

		return residentService.residentProfile(memId);
	}
	
	@ResponseBody
	@PostMapping("/changeNick.do")
	public Map<Object, Object> nickCheck(@RequestBody MemberVO memberNick){
		log.info("닉네임 중복확인");
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		log.info("이거 받아왔어요 {}", memberNick);
		count = residentService.changeNick(memberNick);
		map.put("cnt", count);
		
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/update.do")
	public int updateProfile(@RequestPart("memberVO") MemberVO memberVO,
			@RequestPart(value = "file", required = false) MultipartFile file, HttpSession session) {

		log.debug("거짓말  그것은 거짓말 {}", file);
		log.info("끍어온 데이터들 {}.", memberVO);
		try {
			
			session.setAttribute("nickname", memberVO.getNickname());
			
			if (file != null && !file.isEmpty()) {

				log.info("업로드 된 파일 -> {}", file.getOriginalFilename());
				log.info("업로드 된 파일  크기 -> {}", file.getSize());

				String orgFileName = file.getOriginalFilename();
				String ext = orgFileName.substring(orgFileName.indexOf("."));
				String newFileName = memberVO.getMemId() + "Photo" + ext;

				File saveFile = new File(uploadProfile, newFileName);				
				
				try {
					file.transferTo(saveFile);
					session.setAttribute("mjSajin", newFileName); // 없으면 새로 mjSajin을 맹글고, 있으면 수정
					
					log.debug("명진 {}", session.getAttribute("mjSajin"));
				} catch (IllegalStateException e) {
					log.info(e.getMessage());
				} catch (IOException e) {
					log.info(e.getMessage());
				} catch (NullPointerException e) {
					log.info("널 익셉션!");
				}
			}else {
				if(memberVO.getProfImg().equals("basic.png")) {
					session.setAttribute("mjSajin", "basic.png");
				}
			}
			
			int prf = residentService.updateResidentProfile(memberVO);
			
			if (prf == 1) {
				log.info("수정 완료.");
				return prf;
			} else {
				log.info("수정 실패.");
				return 0;
			}
		} catch (Exception e) {
			log.info(e.getMessage());
			return 0;
		}

	}
	
}
