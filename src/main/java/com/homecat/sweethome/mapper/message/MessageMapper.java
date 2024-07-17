package com.homecat.sweethome.mapper.message;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.message.MessageVO;

public interface MessageMapper {
	
	public int sendMessage(MessageVO messageVO);
	
	/**
	 * 받는사람 확인
	 * @param receiver
	 * @return
	 */
	public int checkReceiver(String receiver);
	
	/**
	 * 받은 쪽지
	 * @param map
	 * @return
	 */
	public List<MessageVO> getReceiveMessage(Map<String, Object> map);
	
	/**
	 * 받은 쪽지 오름차순(날짜 기준)
	 * @param map
	 * @return
	 */
	public List<MessageVO> getReceiveMessageAsc(Map<String, Object> map);
	

	/**
	 * 보낸 쪽지
	 * @param map
	 * @return
	 */
	public List<MessageVO> getSendMessage(Map<String, Object> map);
	
	/**
	 * 보낸 쪽지 오름차순(날짜 기준)
	 * @param map
	 * @return
	 */
	public List<MessageVO> getSendMessageAsc(Map<String, Object> map);
	
	
	/**
	 * 쪽지 상세
	 * @return
	 */
	public List<MessageVO> msgDetail(int msgSeq);
	
	
	
	public int sendCount(Map<String, Object> map);
	
	public int receiveCount(Map<String, Object> map);
	
	public int receiveNotReadCount(String receiver);

	/**
	 * 읽었으면 읽음으로.
	 * @param map
	 * @return
	 */
	public int readCheck(Map<String, Object> map);
	
	

	/**
	 * 안 읽은거 먼저
	 * @param map
	 * @return
	 */
	public List<MessageVO> readCheckAsc(Map<String, Object> map);
	

	/**
	 * 읽은거 먼저
	 * @param map
	 * @return
	 */
	public List<MessageVO> readCheckDesc(Map<String, Object> map);
	
	/**
	 * 받은 쪽지함 삭제
	 * @param msgSeq
	 * @return
	 */
	public int receiveDel(int msgSeq);
	
	/**
	 * 보낸 쪽지함 삭제
	 * @param msgSeq
	 * @return
	 */
	public int sendDel(int msgSeq);
}
