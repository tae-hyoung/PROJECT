package com.homecat.sweethome.service.charge;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.charge.ChargeItemVO;
import com.homecat.sweethome.vo.charge.MGMTVO;
import com.homecat.sweethome.vo.charge.YearAvgVO;

public interface ChargeService {

	public List<String> getDongList(String danji);

	public List<String> getRoomList(String dongCode);

	public int chargeInsert(ChargeItemVO chargeItemVO);

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

	public ChargeItemVO adminGetInfo(Map<String, Object> data);

	public int chargeUpdate(Map<String, Object> data);

	public List<YearAvgVO> getYearAvg(Map<String, Object> data);

	public List<MGMTVO> getMonthList(Map<String, Object> data);

}
