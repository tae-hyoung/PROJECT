package com.homecat.sweethome.mapper.delivery;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.delivery.DeliveryVO;

public interface DeliveryMapper {

	public List<DeliveryVO> list(Map<String, Object> map);

	public DeliveryVO detail(DeliveryVO deliveryVO);

	public int delUpdate(DeliveryVO deliveryVO);

	public int create(DeliveryVO deliveryVO);

	public int updateFileName(AttachVO attachVO);

	public int update(DeliveryVO deliveryVO);

	////////////////협력업체 /////////////////
	public List<DeliveryVO> partList(Map<String, Object> map);

	public DeliveryVO deliveryDetail(DeliveryVO deliveryVO);

	public int back(DeliveryVO deliveryVO);

	public int pickUp(DeliveryVO deliveryVO);

	public List<DeliveryVO> ccpyFilter(String ccpyCode);

	public List<DeliveryVO> monthList();

	public List<DeliveryVO> dayList();

	public List<DeliveryVO> homeCnt();

	public String getMemId(String pckSeq);


}
