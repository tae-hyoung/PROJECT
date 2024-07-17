package com.homecat.sweethome.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.admin.AdminService;
import com.homecat.sweethome.service.board.BoardService;
import com.homecat.sweethome.vo.board.BoardVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminController extends BaseController{

	@Autowired
	String uploadProfile;

	@Autowired
	AdminService adminService;

	@Autowired
	BoardService boardService;

	/**
	 * 관리자 메인 페이지
	 */
	@GetMapping("/main")
	public String main(Model model, HttpSession session) {
		log.info("adminHome에 왔다");

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date(session.getLastAccessedTime()));
		calendar.add(Calendar.MINUTE, (session.getMaxInactiveInterval() / 60));
		
		model.addAttribute("endTime", calendar.getTime().getTime());
		
		List<BoardVO> boardVOList = this.boardService.getList2(5);
		log.info("adminHome -> boardVOList : " + boardVOList);

		model.addAttribute("boardVOList", boardVOList);

		return "admin/adminHome";
	}

	/**
	 * 관리자 마이페이지
	 */
	@GetMapping("/profile")
	public String profile() {
		log.info("관리자 마이 페이지다!");

		return "admin/myPage";
	}

	@ResponseBody
	@GetMapping("/getProfile")
	public List<MemberVO> getProfile(@RequestParam String memId) {

		return adminService.adminProfile(memId);
	}

	@ResponseBody
	@PostMapping("/update.do")
	public int updateProfile(@RequestPart("memberVO") MemberVO memberVO,
			@RequestPart(value = "file", required = false) MultipartFile file, HttpSession session) {

		log.debug("거짓말  그것은 거짓말 {}", file);
		log.info("끍어온 데이터들 {}.", memberVO);
		try {
			/* 입주민 닉네임 세션에 저장 */
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
			
			int prf = adminService.updateAdminProfile(memberVO);

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
