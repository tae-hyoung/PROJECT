package com.homecat.sweethome.service.impl.moveout;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.alarm.AlarmMapper;
import com.homecat.sweethome.mapper.charge.ChargeMapper;
import com.homecat.sweethome.mapper.moveout.MoveoutMapper;
import com.homecat.sweethome.service.moveout.MoveoutService;
import com.homecat.sweethome.vo.charge.ChargeItemVO;
import com.homecat.sweethome.vo.moveout.MoveoutVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MoveoutServiceImpl implements MoveoutService {

	@Autowired
	MoveoutMapper moveoutMapper;
	
	@Autowired
	ChargeMapper chargeMapper;

	@Autowired
	AlarmMapper alarmMapper;

	@Override
	public MoveoutVO getInfo(String memId) {
		return this.moveoutMapper.getInfo(memId);
	}
	
	@Override
	public int insert(MoveoutVO moveoutVO) {
		return this.moveoutMapper.insert(moveoutVO);
	}
	
	@Override
	public int update(MoveoutVO moveoutVO) {
		return this.moveoutMapper.update(moveoutVO);
	}

	@Override
	public List<MoveoutVO> getList(String danjiCode) {
		return this.moveoutMapper.getList(danjiCode);
	}
	
	@Override
	public int delete(Map<String, Object> data) {
		return this.moveoutMapper.delete(data);
	}

	@Override
	public int moveoutOK(Map<String, Object> data) {
		int cnt = 0;
		
		String ym = this.chargeMapper.getLastYm(data.get("roomCode").toString());
		Map<String, Object> data0 = new HashMap<String, Object>();
		data0.put("ym", ym);
		data0.put("roomCode", data.get("roomCode"));
		log.info("ym: " + ym);
		
		ChargeItemVO chargeItemVO = this.chargeMapper.adminGetInfo(data0);
		
		int total = chargeItemVO.getTotalCharge();
		int electrocity = chargeItemVO.getElectrocity();
		int water = chargeItemVO.getWater();
		int heating = chargeItemVO.getHeating();
		int sharedCharge = total - (electrocity + water + heating);
		
		int charge = (int) data.get("charge") + sharedCharge;
		
		data.put("charge", charge);
		log.info("data: " + data);
		
		cnt += this.moveoutMapper.moveoutOK(data);	// MGMT_COST 테이블에는 추가 안하고 MOVE_OUT 테이블의 charge만 수정

		//// 알림 인서트 시작 ////
		String memId = this.moveoutMapper.getMemId(data.get("mvoSeq").toString());
		
		Map<String, String> alarmData = new HashMap<String, String>();
		alarmData.put("memId", memId);
		alarmData.put("globalCode", data.get("mvoSeq").toString());
		alarmData.put("category", "퇴거");
		
		int cnt2 = this.alarmMapper.insert(alarmData);
		log.info("alarmInsert->cnt: " + cnt2);
		//// 알림 인서트 끝 ////

		return cnt;
	}

	@Override
	public String getPayYN(Map<String, Object> data) {
		return this.moveoutMapper.getPayYN(data);
	}

	@Override
	public int paySuccess(Map<String, Object> data) {
		return this.moveoutMapper.paySuccess(data);
	}
}
