package com.homecat.sweethome.controller.waste;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.comm.CommDetailService;
import com.homecat.sweethome.service.waste.WasteService;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.maintenance.MaintenanceVO;
import com.homecat.sweethome.vo.member.MemberVO;
import com.homecat.sweethome.vo.waste.WasteVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/waste")
public class WasteController extends BaseController{

	@Autowired
	WasteService wasteService;

	@Autowired
	CommDetailService commDetailService;

	@GetMapping("/wasteList")
	public String list(Model model, HttpSession session) {

		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");
		String memId = loginMemeber.getMemId();
		log.info("wasteList -> memId : {} ", memId);

		log.info("list에 왔다!!");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);

		List<WasteVO> wasteVOList = this.wasteService.wasteList(map);
		log.info("list->wasteVOList : " + wasteVOList);

		model.addAttribute("wasteVOList", wasteVOList);

		return "resident/waste/wasteList";
	}

	// 폐기물스티커
	@GetMapping("/sticker")
	public String sticker(@RequestParam("wasteSeq") String wasteSeq, 
							@RequestParam("fee") int fee, Model model) {
		log.info("wasteSeq: " + wasteSeq);
		log.info("fee: " + fee);

		WasteVO wasteVO = wasteService.sticker(wasteSeq);

		model.addAttribute("wasteVO", wasteVO);
		log.info("sticker->wasteVO: " + wasteVO);

		return "/resident/waste/sticker";
	}
	
	// 상세
	@GetMapping("/detail")
	public String wasteDetail(@RequestParam("wasteSeq") String wasteSeq, Model model) {
		// wasteSeq: 20240618002
		log.info("wasteSeq: " + wasteSeq);

		WasteVO wasteVO = wasteService.detail(wasteSeq);

		model.addAttribute("wasteVO", wasteVO);
		/*
		 * attachList=[AttachVO(globalCode=null, attchSeq=0, fileName=null, fileSize=0 ,
		 * contentType=null, regDt=2024/06/17 09:02:51, delYn=null, firstRegDt=null ,
		 * firstRegId=null, useYn=null)],
		 */
		log.info("detail->wasteVO: " + wasteVO);

		return "resident/waste/detail";
	}

	// 입력 뷰
	@GetMapping("/create")
	public String create(Model model) {

		log.info("create!!");

		List<CommDetailVO> commDetail = commDetailService.getCommDetail();
		model.addAttribute("commDetail", commDetail);

		return "resident/waste/create";
	}

	// 폐기물 배출 신청
	@ResponseBody
	@PostMapping("/createAjax")
	public String createAjax(WasteVO wasteVO, HttpSession session) {
		log.info("creatAjax야!!!");
		/*
		 * WasteVO(rnum=0, wasteSeq=null, memId=null, regDt=null, wasteItem=null, qty=2,
		 * fee=0, etc=asdfas, recycleYn=y, estDt=2024-06-21, wasteStatus=null,
		 * cancelYn=null, cancelTm=null, attach=null, statusComment=null,
		 * uploadFiles=[org.springframework.web.multipart.support.
		 * StandardMultipartHttpServletRequest$StandardMultipartFile@17a1c825] ,
		 * filePath=null, attachList=null, commDetailVO=null, memberVO=null ,
		 * commDetCodeNm=waste001, commDetCodeDscr=4000, attachVO=null)
		 */
		log.info("createAjax->wasteVO : " + wasteVO);
		MemberVO loginMemeber = (MemberVO) session.getAttribute("loginMember");

		String memId = loginMemeber.getMemId();
		wasteVO.setMemId(memId);

		int result = this.wasteService.createPost(wasteVO);
		log.info("createAjax->result : " + result);

		// 리스트로 이동
		return "resident/waste/wasteList";
	}

	// 수정
	@ResponseBody
	@PostMapping("/updateAjax")
	public WasteVO updateAjax(WasteVO wasteVO) {
		/*
		 * wasteVO : WasteVO(rnum=0, wasteSeq=20240618002, memId=null, regDt=null,
		 * wasteItem=null, qty=0, fee=0 , etc=ㅇㅇㅇ2, recycleYn=n, estDt=2024-06-21,
		 * wasteStatus=null, cancelYn=null, cancelTm=null, attach=null,
		 * statusComment=null , uploadFiles=[org.springframework.web.multipart.support.
		 * StandardMultipartHttpServletRequest$StandardMultipartFile@24ea45d,
		 * org.springframework.web.multipart.support.
		 * StandardMultipartHttpServletRequest$StandardMultipartFile@197844f8,
		 * org.springframework.web.multipart.support.
		 * StandardMultipartHttpServletRequest$StandardMultipartFile@177e24e9],
		 * filePath=null, attachList=null, commDetailVO=null, memberVO=null,
		 * commDetCodeNm=, commDetCodeDscr=null, attachVO=null)
		 */
		log.info("updateAjax-> wasteVO : " + wasteVO);
//		log.info("updateAjax-> commDetCodeNm : " + wasteVO.getCommDetCodeNm());

		int result = this.wasteService.updatePost(wasteVO);
		log.info("updateAjax-> result : " + result);

		// 업데이트된 정보를 다시 조회
		wasteVO = this.wasteService.detail(wasteVO.getWasteSeq());

		return wasteVO;
	}

	// 삭제
	@ResponseBody
	@PostMapping("/deleteAjax")
	public WasteVO deleteAjax(@RequestBody WasteVO wasteVO) {

		log.info("deleteAjax->wasteVO : " + wasteVO);

		int result = this.wasteService.deletePost(wasteVO);
		log.info("deleteAjax->result : " + result);

		return wasteVO;
	}

	///////////////// 관리자
	///////////////// 페이지///////////////////////////////////////////////////////////////////
	// 입주민 폐기물 신청 내역
	@GetMapping("/admin/adWasteList")
	public String adWasteList(Model model) {

		log.info("adWasteList에 왔다!!");

		Map<String, Object> map = new HashMap<String, Object>();

		List<WasteVO> adWasteVOList = this.wasteService.adWasteList(map);
		log.info("adWasteList->adWasteVOList : " + adWasteVOList);

		model.addAttribute("adWasteVOList", adWasteVOList);

		return "admin/waste/adWasteList";
	}

	// 모달 상세
	@PostMapping("/admin/modalDetail")
	@ResponseBody
	public WasteVO modalDetail(@RequestBody WasteVO wasteVO) {
		wasteVO = wasteService.modalDetail(wasteVO);

//		model.addAttribute("wasteVO", wasteVO);
		log.info("modalDetail->wasteVO: {}", wasteVO);

		return wasteVO;
	}

	// 모달 수정
	@PostMapping("/admin/modalUpdate")
	@ResponseBody
	public String modalUpdate(@RequestBody WasteVO wasteVO) throws Exception {
		log.debug("modalUpdate :  {}", wasteVO);

		int result = wasteService.modalUpdate(wasteVO);
		log.info("modalUpdate->result : " + result);
		if (result > 0) {
			return "success";
		}
		return "fail";
	}

	@ResponseBody
	@PostMapping("/admin/homeCnt")
	public List<WasteVO> homeCnt() {
		log.info("homeCnt 이다.");

		List<WasteVO> wasteList = wasteService.homeCnt();
		log.info("homeCnt wasteList :  {}", wasteList);

		return wasteList;
	}

	// 처리상태 데이터 카운트
	@GetMapping("/admin/statusCount")
	@ResponseBody
	public List<WasteVO> statusCount() {
		log.info("statusCount!!");

		List<WasteVO> CountList = wasteService.statusCount();
		log.info("statusCount CountList :  {}", CountList);

		return CountList;
	}

}
