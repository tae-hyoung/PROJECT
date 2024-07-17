package com.homecat.sweethome.vo.charge;

import lombok.Data;

@Data
public class YearAvgVO {
	private String ym;
	private int payCt;
	private int nonPayCt;
	private int lateCt;
}
