package com.homecat.sweethome.controller.alarm;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.service.alarm.AlarmService;
import com.homecat.sweethome.vo.alarm.AlarmVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AlarmController {

	@Autowired
	AlarmService alarmService;
	
	@ResponseBody
	@PostMapping("/alarm")
	public List<AlarmVO> alarm(@RequestBody String memId) {
		memId = memId.replace("\"", "");
		log.info("alarm->memId: " + memId);
		
		List<AlarmVO> alarmVOList = this.alarmService.getAlarms(memId);
		
		return alarmVOList;
	}
	
	@ResponseBody
	@PostMapping("/alarm/read")
	public int read(@RequestBody Map<String, Object> data) {
		log.info("alarm->data: " + data);
		
		int cnt = this.alarmService.read(data);
		
		return cnt;
	}
}
