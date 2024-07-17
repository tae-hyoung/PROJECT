package com.homecat.sweethome.mapper.charge;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.charge.ChargeItemVO;
import com.homecat.sweethome.vo.charge.MGMTVO;
import com.homecat.sweethome.vo.charge.YearAvgVO;

public interface ChargeMapper {

	public List<String> getDongList(String danji);

	public List<String> getRoomList(String dongCode);

	public int insertChargeInfo(Map<String, Object> chargeInfo);

	public int insertCommons(Map<String, Integer> commons);

	public int insertCommonsReason(Map<String, String> commonsReason);

	public int insertCleans(Map<String, Integer> cleans);

	public int insertCleansReason(Map<String, String> cleansReason);

	public int insertDisinfec(Map<String, Integer> disinfec);

	public int insertDisinfecReason(Map<String, String> disinfecReason);

	public int insertSecure(Map<String, Integer> secure);

	public int insertSecureReason(Map<String, String> secureReason);

	public int insertElevator(Map<String, Integer> elevator);

	public int insertElevatorReason(Map<String, String> elevatorReason);

	public int insertLtrr(Map<String, Integer> ltrr);

	public int insertLtrrReason(Map<String, String> ltrrReason);

	public int insertFacilites(Map<String, Integer> facilites);

	public int insertFacilitesReason(Map<String, String> facilitesReason);

	public int insertVat(Map<String, Integer> vat);

	public int insertVatReason(Map<String, String> vatReason);

	public int insertConsignments(Map<String, Integer> consignments);

	public int insertConsignmentsReason(Map<String, String> consignmentsReason);

	public int insertMeeting(Map<String, Integer> meeting);

	public int insertMeetingReason(Map<String, String> meetingReason);

	public int insertBuilding(Map<String, Object> building);

	public int insertBuildingNote(Map<String, String> buildingNote);

	public int insertElectrocity(Map<String, Integer> electrocity);

	public int insertSharedElec(Map<String, Integer> sharedElec);

	public int insertIndividualElec(Map<String, Integer> individualElec);

	public int insertWater(Map<String, Integer> water);

	public int insertSharedWater(Map<String, Integer> sharedWater);

	public int insertIndividualWater(Map<String, Integer> individualWater);

	public int insertHeating(Map<String, Integer> heating);

	public int insertSharedHeating(Map<String, Integer> sharedHeating);

	public int insertIndividualHeating(Map<String, Integer> individualHeating);

	public List<ChargeItemVO> getChargeList(Map<String, Object> map);

	public String getLastYm(String roomCode);

	public List<ChargeItemVO> getInfo(Map<String, String> data);

	public double getAvg(Map<String, String> data);

	public String getPayYN(Map<String, Object> data);
	
	public int payment(Map<String, Object> data);

	public int getTotal(Map<String, Object> map);

	public List<Map<String, Object>> getAvgYm(String danjiCode);

	public List<Map<String, Object>> getAvgDong(String danjiCode);

	public int lateProc();

	public String getUpdDt();

	public ChargeItemVO adminGetInfo(Map<String, Object> data);

	public int chargeUpdate(Map<String, Object> data);

	public List<MGMTVO> getYearAvg(Map<String, Object> data);
	
	public List<YearAvgVO> getYearAvg2(Map<String, Object> data);

	public List<MGMTVO> getMonthList(Map<String, Object> data);


}
