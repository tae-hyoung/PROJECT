package com.homecat.sweethome.service.impl.complain;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.alarm.AlarmMapper;
import com.homecat.sweethome.mapper.complain.ComplainMapper;
import com.homecat.sweethome.service.complain.ComplainService;
import com.homecat.sweethome.vo.complain.ComplainVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ComplainServiceImpl implements ComplainService {

	@Autowired
	ComplainMapper complainMapper;

	@Autowired
	AlarmMapper alarmMapper;

	@Override
	public int create(ComplainVO complainVO) {
		return this.complainMapper.create(complainVO);
	}

	@Override
	public List<ComplainVO> getList(Map<String,Object> map) {
		return this.complainMapper.getList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.complainMapper.getTotal(map);
	}
	
	@Override
	public List<ComplainVO> getAllList(Map<String,Object> map) {
		return this.complainMapper.getAllList(map);
	}
	
	@Override
	public int getAllTotal(Map<String, Object> map) {
		return this.complainMapper.getAllTotal(map);
	}

	@Override
	public int replyAjax(Map<String, Object> data) {
		//// 알림 인서트 시작 ////
		String memId = this.complainMapper.getMemId(data.get("compSeq").toString());
		
		Map<String, String> alarmData = new HashMap<String, String>();
		alarmData.put("memId", memId);
		alarmData.put("globalCode", data.get("compSeq").toString());
		alarmData.put("category", "민원");
		
		int cnt = this.alarmMapper.insert(alarmData);
		log.info("alarmInsert->cnt: " + cnt);
		//// 알림 인서트 끝 ////
		
		return this.complainMapper.replyAjax(data);
	}
	
	@Override
	public int delete(Map<String, Object> data) {
		return this.complainMapper.delete(data);
	}

	@Override
	public List<ComplainVO> homeCnt() {
		return complainMapper.homeCnt();
	}

}
