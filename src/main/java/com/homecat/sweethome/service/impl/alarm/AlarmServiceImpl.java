package com.homecat.sweethome.service.impl.alarm;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.alarm.AlarmMapper;
import com.homecat.sweethome.service.alarm.AlarmService;
import com.homecat.sweethome.vo.alarm.AlarmVO;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	AlarmMapper alarmMapper;

	@Override
	public List<AlarmVO> getAlarms(String memId) {
		return this.alarmMapper.getAlarms(memId);
	}

	@Override
	public int read(Map<String, Object> data) {
		return this.alarmMapper.read(data);
	}
}
