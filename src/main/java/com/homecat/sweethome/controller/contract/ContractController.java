package com.homecat.sweethome.controller.contract;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.contract.ContractService;
import com.homecat.sweethome.vo.contract.ContractVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/contract")
@Controller
public class ContractController extends BaseController{
	
	@Autowired
	ContractService contracrtService;

	@GetMapping("/list")
	public String list(Model model) {
		log.info("의무공개계약서 list에 왔다");
		
		List<ContractVO> contractVOList = this.contracrtService.contractList();
		log.info("list->contractVOList : " + contractVOList);
		
		model.addAttribute("contractVOList", contractVOList);
		
		return "resident/contract/list";
	}
	
	@ResponseBody
	@PostMapping("/createAjax")
	public String CreatetAjax(ContractVO contractVO) {
		log.info("CreatetAjax->contractVO: " + contractVO);
		
		
		int result = this.contracrtService.createContract(contractVO);
		log.info("danjiCreatetPost->result: " + result);

		
		return "success";
	}
	
	
	
	@GetMapping("/admin/list")
	public String adlist(Model model) {
		log.info("의무공개계약서 list에 왔다");
		
		List<ContractVO> contractVOList = this.contracrtService.contractList();
		log.info("list->contractVOList : " + contractVOList);
		
		model.addAttribute("contractVOList", contractVOList);
		
		return "admin/contract/list";
	}
	
	
	
}
