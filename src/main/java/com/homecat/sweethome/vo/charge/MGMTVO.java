package com.homecat.sweethome.vo.charge;

import lombok.Data;

@Data
public class MGMTVO {
	private int rnum;
	private String mgmtSeq;
	private String roomCode;
	private String ym;
	private int totalCt;
	private String payYn;
	private String payDt;
	private int lateCt;
	private int lateCnt;
	private String updDt;
}
