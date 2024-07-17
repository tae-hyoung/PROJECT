package com.homecat.sweethome.controller.homepage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.board.BoardService;
import com.homecat.sweethome.service.charge.ChargeService;
import com.homecat.sweethome.service.contract.ContractService;
import com.homecat.sweethome.vo.board.BoardVO;
import com.homecat.sweethome.vo.charge.ChargeItemVO;
import com.homecat.sweethome.vo.contract.ContractVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/home")
@Controller
public class HomepageController extends BaseController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	ContractService contractService;
	
	@Autowired
	ChargeService chargeService;
	
	@GetMapping("/residentHome")
	public String residentHome(Model model, HttpSession session) {
		log.info("residentHome에 왔다");

		List<BoardVO> boardVOList = this.boardService.getList2(5);
		log.info("residentHome -> boardVOList : " + boardVOList);

		model.addAttribute("boardVOList", boardVOList);
		
		List<ContractVO> contractVOList = this.contractService.getTopList(5);
		model.addAttribute("contractVOList", contractVOList);
		
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		String roomCode = member.getRoomCode();
		
		String ym = this.chargeService.getLastYm(roomCode);

		Map<String, String> data = new HashMap<String, String>();
		data.put("roomCode", roomCode);
		data.put("ym", ym);
		
		ChargeItemVO chargeItemVO = this.chargeService.getInfo(data).get(0);

		double avg = this.chargeService.getAvg(data);
		
		int percent = (int) Math.round(chargeItemVO.getTotalCharge() / avg * 100);
		model.addAttribute("ym", ym);
		model.addAttribute("percent", percent);
		model.addAttribute("chargeItemVO", chargeItemVO);
		
		return "resident/residentHome";
	}
	
	@GetMapping("/adminHome")
	public String adminHome() {
		log.info("adminHome에 왔다");
		return "admin/adminHome";
	}
	
	@GetMapping("/partnersHome")
	public String partnerHome() {
		log.info("partnerHome에 왔다");
		return "partners/partnersHome";
	}
}
