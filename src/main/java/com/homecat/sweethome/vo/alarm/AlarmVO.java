package com.homecat.sweethome.vo.alarm;

import lombok.Data;

@Data
public class AlarmVO {
	private String alarmSeq;
	private String memId;
	private String globalCode;
	private String regDt;
	private String category;
	private String readYn;
}
