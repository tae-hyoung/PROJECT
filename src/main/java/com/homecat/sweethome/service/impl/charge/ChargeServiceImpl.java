package com.homecat.sweethome.service.impl.charge;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.charge.ChargeMapper;
import com.homecat.sweethome.service.charge.ChargeService;
import com.homecat.sweethome.vo.charge.ChargeItemVO;
import com.homecat.sweethome.vo.charge.MGMTVO;
import com.homecat.sweethome.vo.charge.YearAvgVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChargeServiceImpl implements ChargeService {

	@Autowired
	ChargeMapper chargeMapper;
	
	@Override
	public List<String> getDongList(String danji) {
		return this.chargeMapper.getDongList(danji);
	}

	@Override
	public List<String> getRoomList(String dongCode) {
		return this.chargeMapper.getRoomList(dongCode);
	}

	@Override
	public int chargeInsert(ChargeItemVO chargeItemVO) {
		int result = 0;
		
		// 관리비 테이블 등록
		Map<String, Object> chargeInfo = new HashMap<String, Object>();
		chargeInfo.put("roomCode", chargeItemVO.getRoomCode());
		chargeInfo.put("ym", chargeItemVO.getYm());
		chargeInfo.put("totalCt", chargeItemVO.getTotalCharge());
		result += this.chargeMapper.insertChargeInfo(chargeInfo);
		
		// 일반 관리비 등록 매퍼 연결
		Map<String, Integer> commons = new HashMap<String, Integer>();
		commons.put("salary", chargeItemVO.getSalary());
		commons.put("allowance", chargeItemVO.getAllowance());
		commons.put("bonus", chargeItemVO.getBonus());
		commons.put("rtrPay", chargeItemVO.getRtrPay());
		commons.put("iacIns", chargeItemVO.getIacIns());
		commons.put("empIns", chargeItemVO.getEmpIns());
		commons.put("npn", chargeItemVO.getNpn());
		commons.put("hlthIns", chargeItemVO.getHlthIns());
		commons.put("benefits", chargeItemVO.getBenefits());
		commons.put("oprodCt", chargeItemVO.getOprodCt());
		commons.put("printCt", chargeItemVO.getPrintCt());
		commons.put("tsptCt", chargeItemVO.getTsptCt());
		commons.put("commCt", chargeItemVO.getCommCt());
		commons.put("postCt", chargeItemVO.getPostCt());
		commons.put("cprodCt", chargeItemVO.getCprodCt());
		commons.put("etcCt", chargeItemVO.getEtcCt());
		commons.put("facCt", chargeItemVO.getFacCt());
		commons.put("otherCt", chargeItemVO.getCommonsOtherCt());
		commons.put("totalCt", chargeItemVO.getCommons());
		result += this.chargeMapper.insertCommons(commons);
		
		// 일반 관리비 산출근거 등록 매퍼 연결
		Map<String, String> commonsReason = new HashMap<String, String>();
		commonsReason.put("salary", chargeItemVO.getSalaryReason());
		commonsReason.put("allowance", chargeItemVO.getAllowanceReason());
		commonsReason.put("bonus", chargeItemVO.getBonusReason());
		commonsReason.put("rtrPay", chargeItemVO.getRtrPayReason());
		commonsReason.put("iacIns", chargeItemVO.getIacInsReason());
		commonsReason.put("empIns", chargeItemVO.getEmpInsReason());
		commonsReason.put("npn", chargeItemVO.getNpnReason());
		commonsReason.put("hlthIns", chargeItemVO.getHlthInsReason());
		commonsReason.put("benefits", chargeItemVO.getBenefitsReason());
		commonsReason.put("oprodCt", chargeItemVO.getOprodCtReason());
		commonsReason.put("printCt", chargeItemVO.getPrintCtReason());
		commonsReason.put("tsptCt", chargeItemVO.getTsptCtReason());
		commonsReason.put("commCt", chargeItemVO.getCommCtReason());
		commonsReason.put("postCt", chargeItemVO.getPostCtReason());
		commonsReason.put("cprodCt", chargeItemVO.getCprodCtReason());
		commonsReason.put("etcCt", chargeItemVO.getEtcCtReason());
		commonsReason.put("facCt", chargeItemVO.getFacCtReason());
		commonsReason.put("otherCt", chargeItemVO.getCommonsOtherCtReason());
		result += this.chargeMapper.insertCommonsReason(commonsReason);
		
		// 청소비 등록 매퍼 연결
		Map<String, Integer> cleans = new HashMap<String, Integer>();
		cleans.put("clnSvcCt", chargeItemVO.getClnSvcCt());
		cleans.put("expendableCt", chargeItemVO.getExpendableCt());
		cleans.put("wasteCt", chargeItemVO.getWasteCt());
		cleans.put("otherCt", chargeItemVO.getCleaningOtherCt());
		cleans.put("totalCt", chargeItemVO.getCleaning());
		result += this.chargeMapper.insertCleans(cleans);
		
		// 청소비 산출근거 등록 매퍼 연결
		Map<String, String> cleansReason = new HashMap<String, String>();
		cleansReason.put("clnSvcCt", chargeItemVO.getClnSvcCtReason());
		cleansReason.put("expendableCt", chargeItemVO.getExpendableCtReason());
		cleansReason.put("wasteCt", chargeItemVO.getWasteCtReason());
		cleansReason.put("otherCt", chargeItemVO.getCleaningOtherCtReason());
		result += this.chargeMapper.insertCleansReason(cleansReason);
		
		// 소독비 등록 매퍼 연결
		Map<String, Integer> disinfec = new HashMap<String, Integer>();
		disinfec.put("disinfCt", chargeItemVO.getClnSvcCt());
		disinfec.put("otherCt", chargeItemVO.getDisinfecOtherCt());
		disinfec.put("totalCt", chargeItemVO.getDisinfec());
		result += this.chargeMapper.insertDisinfec(disinfec);
		
		// 소독비 산출근거 등록 매퍼 연결
		Map<String, String> disinfecReason = new HashMap<String, String>();
		disinfecReason.put("disinfCt", chargeItemVO.getClnSvcCtReason());
		disinfecReason.put("otherCt", chargeItemVO.getDisinfecOtherCtReason());
		result += this.chargeMapper.insertDisinfecReason(disinfecReason);
		
		// 경비비 등록 매퍼 연결
		Map<String, Integer> secure = new HashMap<String, Integer>();
		secure.put("secCt", chargeItemVO.getSecCt());
		secure.put("otherCt", chargeItemVO.getSecOtherCt());
		secure.put("totalCt", chargeItemVO.getSecure());
		result += this.chargeMapper.insertSecure(secure);
		
		// 경비비 산출근거 등록 매퍼 연결
		Map<String, String> secureReason = new HashMap<String, String>();
		secureReason.put("secCt", chargeItemVO.getSecCtReason());
		secureReason.put("otherCt", chargeItemVO.getSecOtherCtReason());
		result += this.chargeMapper.insertSecureReason(secureReason);
		
		// 승강기유지비 등록 매퍼 연결
		Map<String, Integer> elevator = new HashMap<String, Integer>();
		elevator.put("mgmtCt", chargeItemVO.getEvtMgmtCt());
		elevator.put("inspCt", chargeItemVO.getEvtInspCt());
		elevator.put("expendableCt", chargeItemVO.getEvtExpendableCt());
		elevator.put("otherCt", chargeItemVO.getEvtOtherCt());
		elevator.put("totalCt", chargeItemVO.getElevator());
		result += this.chargeMapper.insertElevator(elevator);
		
		// 승강기유지비 산출근거 등록 매퍼 연결
		Map<String, String> elevatorReason = new HashMap<String, String>();
		elevatorReason.put("mgmtCt", chargeItemVO.getEvtMgmtCtReason());
		elevatorReason.put("inspCt", chargeItemVO.getEvtInspCtReason());
		elevatorReason.put("expendableCt", chargeItemVO.getEvtExpendableCtReason());
		elevatorReason.put("otherCt", chargeItemVO.getEvtOtherCtReason());
		result += this.chargeMapper.insertElevatorReason(elevatorReason);

		// 장기수선충당금 등록 매퍼 연결
		Map<String, Integer> ltrr = new HashMap<String, Integer>();
		ltrr.put("ltrrCt", chargeItemVO.getLtrrCt());
		ltrr.put("otherCt", chargeItemVO.getLtrrOtherCt());
		ltrr.put("totalCt", chargeItemVO.getLtrr());
		result += this.chargeMapper.insertLtrr(ltrr);
		
		// 장기수선충당금 산출근거 등록 매퍼 연결
		Map<String, String> ltrrReason = new HashMap<String, String>();
		ltrrReason.put("ltrrCt", chargeItemVO.getLtrrCtReason());
		ltrrReason.put("otherCt", chargeItemVO.getLtrrOtherCtReason());
		result += this.chargeMapper.insertLtrrReason(ltrrReason);

		// 시설유지비 등록 매퍼 연결
		Map<String, Integer> facilites = new HashMap<String, Integer>();
		facilites.put("mgmtCt", chargeItemVO.getFacilityMgmtCt());
		facilites.put("chkCt", chargeItemVO.getFacilityChkCt());
		facilites.put("prvntCt", chargeItemVO.getPreventCt());
		facilites.put("otherCt", chargeItemVO.getFacilitiesOtherCt());
		facilites.put("totalCt", chargeItemVO.getFacilities());
		result += this.chargeMapper.insertFacilites(facilites);
		
		// 시설유지비 산출근거 등록 매퍼 연결
		Map<String, String> facilitesReason = new HashMap<String, String>();
		facilitesReason.put("mgmtCt", chargeItemVO.getFacilityMgmtCtReason());
		facilitesReason.put("chkCt", chargeItemVO.getFacilityChkCtReason());
		facilitesReason.put("prvntCt", chargeItemVO.getPreventCtReason());
		facilitesReason.put("otherCt", chargeItemVO.getFacilitiesOtherCtReason());
		result += this.chargeMapper.insertFacilitesReason(facilitesReason);
		
		// 부가세 등록 매퍼 연결
		Map<String, Integer> vat = new HashMap<String, Integer>();
		vat.put("msvcCt", chargeItemVO.getMsvcCt());
		vat.put("csvsCt", chargeItemVO.getCsvcCt());
		vat.put("ssvcCt", chargeItemVO.getSsvcCt());
		vat.put("otherCt", chargeItemVO.getVatOtherCt());
		vat.put("totalCt", chargeItemVO.getVat());
		result += this.chargeMapper.insertVat(vat);
		
		// 부가세 산출근거 등록 매퍼 연결
		Map<String, String> vatReason = new HashMap<String, String>();
		vatReason.put("msvcCt", chargeItemVO.getMsvcCtReason());
		vatReason.put("csvsCt", chargeItemVO.getCsvcCtReason());
		vatReason.put("ssvcCt", chargeItemVO.getSsvcCtReason());
		vatReason.put("otherCt", chargeItemVO.getVatOtherCtReason());
		result += this.chargeMapper.insertVatReason(vatReason);
		
		// 위탁관리 등록 매퍼 연결
		Map<String, Integer> consignments = new HashMap<String, Integer>();
		consignments.put("cmgmtCt", chargeItemVO.getConsignmentCt());
		consignments.put("otherCt", chargeItemVO.getConsignmentOtherCt());
		consignments.put("totalCt", chargeItemVO.getConsignment());
		result += this.chargeMapper.insertConsignments(consignments);
		
		// 위탁관리 산출근거 등록 매퍼 연결
		Map<String, String> consignmentsReason = new HashMap<String, String>();
		consignmentsReason.put("cmgmtCt", chargeItemVO.getConsignmentCtReason());
		consignmentsReason.put("otherCt", chargeItemVO.getConsignmentOtherCtReason());
		result += this.chargeMapper.insertConsignmentsReason(consignmentsReason);
		
		// 입주자대표회의운영비 등록 매퍼 연결
		Map<String, Integer> meeting = new HashMap<String, Integer>();
		meeting.put("cbCt", chargeItemVO.getCbCt());
		meeting.put("abCt", chargeItemVO.getAbCt());
		meeting.put("attdcCt", chargeItemVO.getAttdcCt());
		meeting.put("operationCt", chargeItemVO.getOperationCt());
		meeting.put("otherCt", chargeItemVO.getMeetingOtherCt());
		meeting.put("totalCt", chargeItemVO.getMeeting());
		result += this.chargeMapper.insertMeeting(meeting);
		
		// 입주자대표회의운영비 산출근거 등록 매퍼 연결
		Map<String, String> meetingReason = new HashMap<String, String>();
		meetingReason.put("cbCt", chargeItemVO.getCbCtReason());
		meetingReason.put("abCt", chargeItemVO.getAbCtReason());
		meetingReason.put("attdcCt", chargeItemVO.getAttdcCtReason());
		meetingReason.put("operationCt", chargeItemVO.getOperationCtReason());
		meetingReason.put("otherCt", chargeItemVO.getMeetingOtherCtReason());
		result += this.chargeMapper.insertMeetingReason(meetingReason);
		
		// 건문보험료 등록 매퍼 연결
		Map<String, Object> building = new HashMap<String, Object>();
		building.put("binsrCt", chargeItemVO.getBuildingInsr());
		building.put("note", chargeItemVO.getBuildingNote());
		result += this.chargeMapper.insertBuilding(building);
		
		// 전기비 등록
		Map<String, Integer> electrocity = new HashMap<String, Integer>();
		electrocity.put("selectCt", chargeItemVO.getSharedElec());
		electrocity.put("ielectCt", chargeItemVO.getIndividualElec());
		electrocity.put("totalCt", chargeItemVO.getElectrocity());
		result += this.chargeMapper.insertElectrocity(electrocity);
		
		// 공용 전기비 등록
		Map<String, Integer> sharedElec = new HashMap<String, Integer>();
		sharedElec.put("usage", chargeItemVO.getShElecUsage());
		sharedElec.put("price", chargeItemVO.getShElecPrice());
		result += this.chargeMapper.insertSharedElec(sharedElec);
		
		// 개별 전기비 등록
		Map<String, Integer> individualElec = new HashMap<String, Integer>();
		individualElec.put("usage", chargeItemVO.getIdvElecUsage());
		individualElec.put("price", chargeItemVO.getIdvElecPrice());
		result += this.chargeMapper.insertIndividualElec(individualElec);
		
		// 수도비 등록
		Map<String, Integer> water = new HashMap<String, Integer>();
		water.put("swaterCt", chargeItemVO.getSharedWater());
		water.put("iwaterCt", chargeItemVO.getIndividualWater());
		water.put("totalCt", chargeItemVO.getWater());
		result += this.chargeMapper.insertWater(water);
		
		// 공용 수도비 등록
		Map<String, Integer> sharedWater = new HashMap<String, Integer>();
		sharedWater.put("usage", chargeItemVO.getShWaterUsage());
		sharedWater.put("price", chargeItemVO.getShWaterPrice());
		result += this.chargeMapper.insertSharedWater(sharedWater);
		
		// 개별 수도비 등록
		Map<String, Integer> individualWater = new HashMap<String, Integer>();
		individualWater.put("usage", chargeItemVO.getIdvWaterUsage());
		individualWater.put("price", chargeItemVO.getIdvWaterPrice());
		result += this.chargeMapper.insertIndividualWater(individualWater);
		
		// 난방비 등록
		Map<String, Integer> heating = new HashMap<String, Integer>();
		heating.put("sheatCt", chargeItemVO.getSharedHeating());
		heating.put("iheatCt", chargeItemVO.getIndividualHeating());
		heating.put("totalCt", chargeItemVO.getHeating());
		result += this.chargeMapper.insertHeating(heating);
		
		// 공용 난방비 등록
		Map<String, Integer> sharedHeating = new HashMap<String, Integer>();
		sharedHeating.put("usage", chargeItemVO.getShHeatingUsage());
		sharedHeating.put("price", chargeItemVO.getShHeatingPrice());
		result += this.chargeMapper.insertSharedHeating(sharedHeating);
		
		// 개별 난방비 등록
		Map<String, Integer> individualHeating = new HashMap<String, Integer>();
		individualHeating.put("usage", chargeItemVO.getIdvHeatingUsage());
		individualHeating.put("price", chargeItemVO.getIdvHeatingPrice());
		result += this.chargeMapper.insertIndividualHeating(individualHeating);
		
		return result;
	}

	@Override
	public List<ChargeItemVO> getChargeList(Map<String, Object> map) {
		return this.chargeMapper.getChargeList(map);
	}

	@Override
	public List<ChargeItemVO> getInfo(Map<String, String> data) {
		return this.chargeMapper.getInfo(data);
	}

	@Override
	public String getLastYm(String roomCode) {
		return this.chargeMapper.getLastYm(roomCode);
	}

	@Override
	public double getAvg(Map<String, String> data) {
		return this.chargeMapper.getAvg(data);
	}
	
	@Override
	public String getPayYN(Map<String, Object> data) {
		return this.chargeMapper.getPayYN(data);
	}

	@Override
	public int payment(Map<String, Object> data) {
		return this.chargeMapper.payment(data);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.chargeMapper.getTotal(map);
	}

	@Override
	public List<Map<String, Object>> getAvgYm(String danjiCode) {
		return this.chargeMapper.getAvgYm(danjiCode);
	}
	
	@Override
	public List<Map<String, Object>> getAvgDong(String danjiCode) {
		return this.chargeMapper.getAvgDong(danjiCode);
	}

	@Override
	public int lateProc() {
		String updDt = this.chargeMapper.getUpdDt();
		if(updDt != null) {
			Calendar calendar = Calendar.getInstance();
			String year = String.valueOf(calendar.get(Calendar.YEAR));
			String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
			if(month.length()<2)	month = '0' + month;
			String now = year + "-" + month;
			
			log.info("updDt: " + updDt);
			log.info("now: " + now);
			if(updDt.equals(now)) {
				return 0;
			}
		}
		
		return this.chargeMapper.lateProc();
	}

	@Override
	public ChargeItemVO adminGetInfo(Map<String, Object> data) {
		return this.chargeMapper.adminGetInfo(data);
	}

	@Override
	public int chargeUpdate(Map<String, Object> data) {
		return this.chargeMapper.chargeUpdate(data);
	}

	@Override
	public List<YearAvgVO> getYearAvg(Map<String, Object> data) {
		return this.chargeMapper.getYearAvg2(data);
	}

	@Override
	public List<MGMTVO> getMonthList(Map<String, Object> data) {
		return this.chargeMapper.getMonthList(data);
	}


}
