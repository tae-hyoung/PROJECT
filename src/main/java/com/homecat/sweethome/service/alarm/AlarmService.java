package com.homecat.sweethome.service.alarm;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.alarm.AlarmVO;

public interface AlarmService {

	public List<AlarmVO> getAlarms(String memId);

	public int read(Map<String, Object> data);

}
