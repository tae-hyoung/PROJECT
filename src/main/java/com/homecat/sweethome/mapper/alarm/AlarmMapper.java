package com.homecat.sweethome.mapper.alarm;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.alarm.AlarmVO;

public interface AlarmMapper {

	public int insert(Map<String, String> alarmData);

	public List<AlarmVO> getAlarms(String memId);

	public int read(Map<String, Object> data);

}
