package com.homecat.sweethome.controller.charge;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.controller.BaseController;
import com.homecat.sweethome.service.charge.ChargeService;
import com.homecat.sweethome.unit.ArticlePage;
import com.homecat.sweethome.vo.charge.ChargeItemVO;
import com.homecat.sweethome.vo.charge.MGMTVO;
import com.homecat.sweethome.vo.charge.YearAvgVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/charge")
@Controller
public class ChargeController extends BaseController {

	@Autowired
	ChargeService chargeService;

	String danjiCode = "D001";
	
	@GetMapping("/admin/insert2")
	public String chargeInsert(Model model,
			@RequestParam(value = "payYn", required = false, defaultValue = "false") boolean payYn,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		log.info("chargeInsert에 왔다");
//		
//		List<String> dongList = this.chargeService.getDongList(danjiCode);
//		log.info("dongList: " + dongList);
//		model.addAttribute("dongList", dongList);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("danjiCode",danjiCode );
		map.put("keyword",keyword );
		map.put("currentPage", currentPage);
		map.put("payYn", payYn);

		int size = 10;
		
		List<ChargeItemVO> chargeList = this.chargeService.getChargeList(map);
		log.info("chargeList: " + chargeList);
		
		int total = this.chargeService.getTotal(map);
		log.info("total: " + total);
		
		model.addAttribute("articlePage", new ArticlePage<ChargeItemVO>(total, currentPage, size, chargeList, keyword, payYn));
		
		return "admin/charge/insert";
	}
	
	@ResponseBody
	@PostMapping("/list")
	public ArticlePage<ChargeItemVO> chargeSearch(@RequestBody Map<String, Object> map) {
		log.info("chargeSearch->map: " + map);

		map.put("danjiCode",danjiCode );
		int size = 10;

		int total = this.chargeService.getTotal(map);
		log.info("total: " + total);
		
		List<ChargeItemVO> chargeList = this.chargeService.getChargeList(map);
		log.info("chargeList: " + chargeList);
		
		return new ArticlePage<ChargeItemVO>(total, Integer.parseInt(map.get("currentPage").toString()), size, chargeList, map.get("keyword").toString(), (boolean) map.get("payYn"));
	}
	
	@ResponseBody
	@PostMapping("/getDongList")
	public List<String> getDongList(){
		List<String> dongList = this.chargeService.getDongList(danjiCode);
		log.info("dongList: " + dongList);
		return dongList;
	}
	
	@ResponseBody
	@PostMapping("/getAvgs")
	public List<List<Map<String, Object>>> getAvgs() {
		List<List<Map<String, Object>>> result = new ArrayList<List<Map<String,Object>>>();
		List<Map<String, Object>> AvgYm = this.chargeService.getAvgYm(danjiCode);
		List<Map<String, Object>> AvgDong = this.chargeService.getAvgDong(danjiCode);
		result.add(AvgYm);
		result.add(AvgDong);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/dongSelAjax")
	public List<String> dongSelAjax(@RequestBody HashMap<String, String> data) {
		log.info("dongSelAjax->dongCode: " + data);
		
		List<String> roomList = this.chargeService.getRoomList(data.get("dongCode"));
		log.info("roomList: " + roomList);
		
		return roomList;
	}
	
	@PostMapping("/admin/insert")
	public String preView(Model model, MultipartFile file) throws IOException {
		log.info("preView->file: " + file);

		XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());
	    XSSFSheet worksheet = workbook.getSheetAt(0);
	    
	    for(int i=2;i<worksheet.getPhysicalNumberOfRows() ;i++) {
	    	ChargeItemVO chargeItemVO = new ChargeItemVO();
	    	DataFormatter formatter = new DataFormatter();
	    	XSSFRow row = worksheet.getRow(i);

	    	String year = formatter.formatCellValue(row.getCell(0));
	    	String month = formatter.formatCellValue(row.getCell(1)).length() < 2 ? '0' + formatter.formatCellValue(row.getCell(1)) : formatter.formatCellValue(row.getCell(1));;
	    	String roomCode = danjiCode + "_" + formatter.formatCellValue(row.getCell(2)) + "_" + formatter.formatCellValue(row.getCell(3));
	    	
	    	chargeItemVO.setYm(year + "-" + month);
	    	chargeItemVO.setRoomCode(roomCode);
	    	chargeItemVO.setTotalCharge			(Integer.parseInt(formatter.formatCellValue(row.getCell(3+1))));
	    	chargeItemVO.setCommons				(Integer.parseInt(formatter.formatCellValue(row.getCell(4+1))));
	    	chargeItemVO.setCleaning			(Integer.parseInt(formatter.formatCellValue(row.getCell(5+1))));
	    	chargeItemVO.setDisinfec			(Integer.parseInt(formatter.formatCellValue(row.getCell(6+1))));
	    	chargeItemVO.setSecure				(Integer.parseInt(formatter.formatCellValue(row.getCell(7+1))));
	    	chargeItemVO.setElevator			(Integer.parseInt(formatter.formatCellValue(row.getCell(8+1))));
	    	chargeItemVO.setLtrr				(Integer.parseInt(formatter.formatCellValue(row.getCell(9+1))));
	    	chargeItemVO.setFacilities			(Integer.parseInt(formatter.formatCellValue(row.getCell(10+1))));
	    	chargeItemVO.setVat					(Integer.parseInt(formatter.formatCellValue(row.getCell(11+1))));
	    	chargeItemVO.setConsignment			(Integer.parseInt(formatter.formatCellValue(row.getCell(12+1))));
	    	chargeItemVO.setMeeting				(Integer.parseInt(formatter.formatCellValue(row.getCell(13+1))));
	    	chargeItemVO.setBuilding			(Integer.parseInt(formatter.formatCellValue(row.getCell(14+1))));
	    	chargeItemVO.setElectrocity			(Integer.parseInt(formatter.formatCellValue(row.getCell(15+1))));
	    	chargeItemVO.setWater				(Integer.parseInt(formatter.formatCellValue(row.getCell(16+1))));
	    	chargeItemVO.setHeating				(Integer.parseInt(formatter.formatCellValue(row.getCell(17+1))));
	        chargeItemVO.setSalary				(Integer.parseInt(formatter.formatCellValue(row.getCell(18+1))));
	        chargeItemVO.setAllowance			(Integer.parseInt(formatter.formatCellValue(row.getCell(19+1))));
	        chargeItemVO.setBonus				(Integer.parseInt(formatter.formatCellValue(row.getCell(20+1))));
	        chargeItemVO.setRtrPay				(Integer.parseInt(formatter.formatCellValue(row.getCell(21+1))));
	        chargeItemVO.setIacIns				(Integer.parseInt(formatter.formatCellValue(row.getCell(22+1))));
	        chargeItemVO.setEmpIns				(Integer.parseInt(formatter.formatCellValue(row.getCell(23+1))));
	        chargeItemVO.setNpn					(Integer.parseInt(formatter.formatCellValue(row.getCell(24+1))));
	        chargeItemVO.setHlthIns				(Integer.parseInt(formatter.formatCellValue(row.getCell(25+1))));
	        chargeItemVO.setBenefits			(Integer.parseInt(formatter.formatCellValue(row.getCell(26+1))));
	        chargeItemVO.setOprodCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(27+1))));
	        chargeItemVO.setPrintCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(28+1))));
	        chargeItemVO.setTsptCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(29+1))));
	        chargeItemVO.setCommCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(30+1))));
	        chargeItemVO.setPostCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(31+1))));
	        chargeItemVO.setCprodCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(32+1))));
	        chargeItemVO.setEtcCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(33+1))));
	        chargeItemVO.setFacCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(34+1))));
	        chargeItemVO.setCommonsOtherCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(35+1))));
	        chargeItemVO.setClnSvcCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(36+1))));
	        chargeItemVO.setExpendableCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(37+1))));
	        chargeItemVO.setWasteCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(38+1))));
	        chargeItemVO.setCleaningOtherCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(39+1))));
	        chargeItemVO.setDisinfecCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(40+1))));
	        chargeItemVO.setDisinfecOtherCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(41+1))));
	        chargeItemVO.setSecCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(42+1))));
	        chargeItemVO.setSecOtherCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(43+1))));
	        chargeItemVO.setEvtMgmtCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(44+1))));
	        chargeItemVO.setEvtInspCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(45+1))));
	        chargeItemVO.setEvtExpendableCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(46+1))));
	        chargeItemVO.setEvtOtherCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(47+1))));
	        chargeItemVO.setLtrrCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(48+1))));
	        chargeItemVO.setLtrrOtherCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(49+1))));
	        chargeItemVO.setFacilityMgmtCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(50+1))));
	        chargeItemVO.setFacilityChkCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(51+1))));
	        chargeItemVO.setPreventCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(52+1))));
	        chargeItemVO.setFacilitiesOtherCt	(Integer.parseInt(formatter.formatCellValue(row.getCell(53+1))));
	        chargeItemVO.setMsvcCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(54+1))));
	        chargeItemVO.setCsvcCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(55+1))));
	        chargeItemVO.setSsvcCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(56+1))));
	        chargeItemVO.setVatOtherCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(57+1))));
	        chargeItemVO.setConsignmentCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(58+1))));
	        chargeItemVO.setConsignmentOtherCt	(Integer.parseInt(formatter.formatCellValue(row.getCell(59+1))));
	        chargeItemVO.setCbCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(60+1))));
	        chargeItemVO.setAbCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(61+1))));
	        chargeItemVO.setAttdcCt				(Integer.parseInt(formatter.formatCellValue(row.getCell(62+1))));
	        chargeItemVO.setOperationCt			(Integer.parseInt(formatter.formatCellValue(row.getCell(63+1))));
	        chargeItemVO.setMeetingOtherCt		(Integer.parseInt(formatter.formatCellValue(row.getCell(64+1))));
	        chargeItemVO.setBuildingInsr		(Integer.parseInt(formatter.formatCellValue(row.getCell(65+1))));
	        chargeItemVO.setShElecUsage			(Integer.parseInt(formatter.formatCellValue(row.getCell(66+1))));
	        chargeItemVO.setIdvElecUsage		(Integer.parseInt(formatter.formatCellValue(row.getCell(67+1))));
	        chargeItemVO.setShWaterUsage		(Integer.parseInt(formatter.formatCellValue(row.getCell(68+1))));
	        chargeItemVO.setIdvWaterUsage		(Integer.parseInt(formatter.formatCellValue(row.getCell(69+1))));
	        chargeItemVO.setShHeatingUsage		(Integer.parseInt(formatter.formatCellValue(row.getCell(70+1))));
	        chargeItemVO.setIdvHeatingUsage		(Integer.parseInt(formatter.formatCellValue(row.getCell(71+1))));
	        
	        // 산출근거 세팅
	        chargeItemVO.setSalaryReason			(formatter.formatCellValue(row.getCell(72+1)));
    		chargeItemVO.setAllowanceReason			(formatter.formatCellValue(row.getCell(73+1)));
    		chargeItemVO.setBonusReason				(formatter.formatCellValue(row.getCell(74+1)));
    		chargeItemVO.setRtrPayReason			(formatter.formatCellValue(row.getCell(75+1)));
    		chargeItemVO.setIacInsReason			(formatter.formatCellValue(row.getCell(76+1)));
    		chargeItemVO.setEmpInsReason			(formatter.formatCellValue(row.getCell(77+1)));
    		chargeItemVO.setNpnReason				(formatter.formatCellValue(row.getCell(78+1)));
    		chargeItemVO.setHlthInsReason			(formatter.formatCellValue(row.getCell(79+1)));
    		chargeItemVO.setBenefitsReason			(formatter.formatCellValue(row.getCell(80+1)));
    		chargeItemVO.setOprodCtReason			(formatter.formatCellValue(row.getCell(81+1)));
    		chargeItemVO.setPrintCtReason			(formatter.formatCellValue(row.getCell(82+1)));
    		chargeItemVO.setTsptCtReason			(formatter.formatCellValue(row.getCell(83+1)));
    		chargeItemVO.setCommCtReason			(formatter.formatCellValue(row.getCell(84+1)));
    		chargeItemVO.setPostCtReason			(formatter.formatCellValue(row.getCell(85+1)));
    		chargeItemVO.setCprodCtReason			(formatter.formatCellValue(row.getCell(86+1)));
    		chargeItemVO.setEtcCtReason				(formatter.formatCellValue(row.getCell(87+1)));
    		chargeItemVO.setFacCtReason				(formatter.formatCellValue(row.getCell(88+1)));
    		chargeItemVO.setCommonsOtherCtReason	(formatter.formatCellValue(row.getCell(89+1)));
    		chargeItemVO.setClnSvcCtReason			(formatter.formatCellValue(row.getCell(90+1)));
    		chargeItemVO.setExpendableCtReason		(formatter.formatCellValue(row.getCell(91+1)));
    		chargeItemVO.setWasteCtReason			(formatter.formatCellValue(row.getCell(92+1)));
    		chargeItemVO.setCleaningOtherCtReason	(formatter.formatCellValue(row.getCell(93+1)));
    		chargeItemVO.setDisinfecCtReason		(formatter.formatCellValue(row.getCell(94+1)));
    		chargeItemVO.setDisinfecOtherCtReason	(formatter.formatCellValue(row.getCell(95+1)));
    		chargeItemVO.setSecCtReason				(formatter.formatCellValue(row.getCell(96+1)));
    		chargeItemVO.setSecOtherCtReason		(formatter.formatCellValue(row.getCell(97+1)));
    		chargeItemVO.setEvtMgmtCtReason			(formatter.formatCellValue(row.getCell(98+1)));
    		chargeItemVO.setEvtInspCtReason			(formatter.formatCellValue(row.getCell(99+1)));
    		chargeItemVO.setEvtExpendableCtReason	(formatter.formatCellValue(row.getCell(100+1)));
    		chargeItemVO.setEvtOtherCtReason		(formatter.formatCellValue(row.getCell(101+1)));
    		chargeItemVO.setLtrrCtReason			(formatter.formatCellValue(row.getCell(102+1)));
    		chargeItemVO.setLtrrOtherCtReason		(formatter.formatCellValue(row.getCell(103+1)));
    		chargeItemVO.setFacilityMgmtCtReason	(formatter.formatCellValue(row.getCell(104+1)));
    		chargeItemVO.setFacilityChkCtReason		(formatter.formatCellValue(row.getCell(105+1)));
    		chargeItemVO.setPreventCtReason			(formatter.formatCellValue(row.getCell(106+1)));
    		chargeItemVO.setFacilitiesOtherCtReason	(formatter.formatCellValue(row.getCell(107+1)));
    		chargeItemVO.setMsvcCtReason			(formatter.formatCellValue(row.getCell(108+1)));
    		chargeItemVO.setCsvcCtReason			(formatter.formatCellValue(row.getCell(109+1)));
    		chargeItemVO.setSsvcCtReason			(formatter.formatCellValue(row.getCell(110+1)));
    		chargeItemVO.setVatOtherCtReason		(formatter.formatCellValue(row.getCell(111+1)));
    		chargeItemVO.setConsignmentCtReason		(formatter.formatCellValue(row.getCell(112+1)));
    		chargeItemVO.setConsignmentOtherCtReason(formatter.formatCellValue(row.getCell(113+1)));
    		chargeItemVO.setCbCtReason				(formatter.formatCellValue(row.getCell(114+1)));
    		chargeItemVO.setAbCtReason				(formatter.formatCellValue(row.getCell(115+1)));
    		chargeItemVO.setAttdcCtReason			(formatter.formatCellValue(row.getCell(116+1)));
    		chargeItemVO.setOperationCtReason		(formatter.formatCellValue(row.getCell(117+1)));
    		chargeItemVO.setMeetingOtherCtReason	(formatter.formatCellValue(row.getCell(118+1)));
    		chargeItemVO.setBuildingNote			(formatter.formatCellValue(row.getCell(119+1)));
	        chargeItemVO.setShElecPrice				(Integer.parseInt(formatter.formatCellValue(row.getCell(120+1))));
	        chargeItemVO.setIdvElecPrice			(Integer.parseInt(formatter.formatCellValue(row.getCell(121+1))));
	        chargeItemVO.setShWaterPrice			(Integer.parseInt(formatter.formatCellValue(row.getCell(122+1))));
	        chargeItemVO.setIdvWaterPrice			(Integer.parseInt(formatter.formatCellValue(row.getCell(123+1))));
	        chargeItemVO.setShHeatingPrice			(Integer.parseInt(formatter.formatCellValue(row.getCell(124+1))));
	        chargeItemVO.setIdvHeatingPrice			(Integer.parseInt(formatter.formatCellValue(row.getCell(125+1))));
	        
	        chargeItemVO.setSharedElec				(Integer.parseInt(formatter.formatCellValue(row.getCell(66+1))) * Integer.parseInt(formatter.formatCellValue(row.getCell(120+1))));
	        chargeItemVO.setIndividualElec			(Integer.parseInt(formatter.formatCellValue(row.getCell(67+1))) * Integer.parseInt(formatter.formatCellValue(row.getCell(121+1))));
	        chargeItemVO.setSharedWater				(Integer.parseInt(formatter.formatCellValue(row.getCell(68+1))) * Integer.parseInt(formatter.formatCellValue(row.getCell(122+1))));
	        chargeItemVO.setIndividualWater			(Integer.parseInt(formatter.formatCellValue(row.getCell(69+1))) * Integer.parseInt(formatter.formatCellValue(row.getCell(123+1))));
	        chargeItemVO.setSharedHeating			(Integer.parseInt(formatter.formatCellValue(row.getCell(70+1))) * Integer.parseInt(formatter.formatCellValue(row.getCell(124+1))));
	        chargeItemVO.setIndividualHeating		(Integer.parseInt(formatter.formatCellValue(row.getCell(71+1))) * Integer.parseInt(formatter.formatCellValue(row.getCell(125+1))));
	        log.info("chargeItemVO: " + chargeItemVO);
	        
	        int cnt = this.chargeService.chargeInsert(chargeItemVO);
	        log.info("cnt: " + cnt);
	    }
		
	    workbook.close();


		
		return "redirect:/charge/admin/insert";
	}
	
//	@GetMapping("/admin/list")
//	public String chargeList(Model model) {
//		log.info("chargeList에 왔다");
//
//		List<String> dongList = this.chargeService.getDongList(danjiCode);
//		log.info("dongList: " + dongList);
//		model.addAttribute("dongList", dongList);
//		
//		List<ChargeItemVO> chargeList = this.chargeService.getChargeList(danjiCode);
//		log.info("chargeList: " + chargeList);
//		
//		model.addAttribute("chargeList", chargeList);
//		
//		return "admin/charge/list";
//	}
	
	@ResponseBody
	@PostMapping("/getLastInfo")
	public ChargeItemVO getLastInfo(@RequestBody String roomCode) {
		log.info("roomCode: " + roomCode);

		String lastYm = this.chargeService.getLastYm(roomCode);
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("roomCode", roomCode);
		data.put("ym", lastYm);
		
		ChargeItemVO chargeItemVO = this.chargeService.getInfo(data).get(0);
		
		return chargeItemVO;
	}
	
	@ResponseBody
	@PostMapping("/lateProc")
	public int lateProc() {
		int cnt = this.chargeService.lateProc();
		log.info("lateProc->cnt: " + cnt);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/admin/getInfo")
	public ChargeItemVO adminGetInfo(@RequestBody Map<String, Object> data) {
		log.info("adminGetInfo->data: " + data);
		
		String year = (String) data.get("year");
		String month = (String) data.get("month");
		String dong = (String) data.get("dong");
		String room = (String) data.get("room");
		
		String ym = year + "-" + month;
		String roomCode = danjiCode + "_" + dong + "_" + room;
		
		Map<String, Object> inputData = new HashMap<String, Object>();
		inputData.put("ym", ym);
		inputData.put("roomCode", roomCode);
		log.info("adminGetInfo->inputData: " + inputData);
		
		ChargeItemVO chargeItemVO = this.chargeService.adminGetInfo(inputData);
		log.info("chargeItemVO: " + chargeItemVO);
		
		return chargeItemVO;
	}
	
	@ResponseBody
	@PostMapping("/admin/update")
	public int chargeUpdate(@RequestBody Map<String, Object> data) {
		log.info("chargeUpdate->data: " + data);
		
		// 관리비 개별 업데이트 쿼리 짜야함~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//		int cnt = this.chargeService.chargeUpdate(data);
		
		return 0;
	}
	
	////////////////////////////// 입주민 ////////////////////////////////////
	
	@GetMapping("/resident/payment")
	public String chargeResidentPayment(Model model, HttpSession session) {
		log.info("chargeResidentPayment에 왔다");

		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		
		String roomCode = member.getRoomCode();
		
		String ym = this.chargeService.getLastYm(roomCode);
//		String ym = "2023-06";
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("roomCode", roomCode);
		data.put("ym", ym);
		
		log.info("getChargeInfo->data: " + data);
		
		ChargeItemVO chargeItemVO = this.chargeService.getInfo(data).get(0);
		log.info("chargeItemVO: " + chargeItemVO);
		
		
		double avg = this.chargeService.getAvg(data);
		log.info("avg: " + avg);
		
		model.addAttribute("ym", ym);
		model.addAttribute("avg", avg);
		model.addAttribute("chargeItemVO", chargeItemVO);
		
		return "resident/charge/payment";
	}
	
	@ResponseBody
	@PostMapping("/getInfo")
	public List<ChargeItemVO> getChargeInfo(@RequestBody Map<String, String> data){
		log.info("getChargeInfo->data: " + data);
		
		log.info("getChargeInfo->data: " + data);
		
		List<ChargeItemVO> chargeItemVOList = this.chargeService.getInfo(data);
		log.info("chargeItemVOList: " + chargeItemVOList);
		
		return chargeItemVOList;
	}
	
	@ResponseBody
	@PostMapping("/getPayYN")
	public String getPayYN(@RequestBody Map<String, Object> data) {
		log.info("getPayYN->data: " + data);
		
		String yn = this.chargeService.getPayYN(data);
		
		return yn;
	}
	
	@ResponseBody
	@PostMapping("/paySuccess")
	public int paySuccess(@RequestBody Map<String, Object> data) {
		log.info("paySuccess->data: " + data);
		
		int cnt = this.chargeService.payment(data);
		
		return cnt;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	임시 매핑
	@GetMapping("/admin/insert")
	public String chargeInsert2() {
		log.info("chargeInsert에 왔다");

		return "admin/charge/insert2";
	}
	
	@ResponseBody
	@PostMapping("/getYearAvg")
	public List<YearAvgVO> getYearAvg(@RequestBody Map<String, Object> data){
		log.info("getYearAvg->data: " + data);

		List<YearAvgVO> yearAvg = this.chargeService.getYearAvg(data);
		log.info("yearAvg: " + yearAvg);
		
		return yearAvg;
	}
	
	@ResponseBody
	@PostMapping("/getMonthList")
	public List<MGMTVO> getMonthList(@RequestBody Map<String, Object> data){
		log.info("getMonthList->data: " + data);
		
		List<MGMTVO> monthList = this.chargeService.getMonthList(data);
		
		return monthList;
	}
	
	@ResponseBody
	@PostMapping("/getDetail")
	public ChargeItemVO getDetail(@RequestBody Map<String, Object> data){
		log.info("getDetail->data: " + data);
		
		ChargeItemVO detail = this.chargeService.adminGetInfo(data);
		
		return detail;
	}
}
