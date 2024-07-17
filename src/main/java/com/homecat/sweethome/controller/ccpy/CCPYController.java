package com.homecat.sweethome.controller.ccpy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.ccpy.CcpyService;
import com.homecat.sweethome.vo.ccpy.CcpyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ccpy")
public class CCPYController extends BaseController{

	@Autowired
	CcpyService ccpyService;

	// 협력업체 리스트
	@GetMapping("/admin/list")
	public String list(Model model) {
		log.info("list야!");

		Map<String, Object> map = new HashMap<String, Object>();

		List<CcpyVO> ccpyList = this.ccpyService.list(map);
		log.info("list->ccpyList : " + ccpyList);

		model.addAttribute("ccpyList", ccpyList);

		return "admin/ccpy/list";
	}
}
