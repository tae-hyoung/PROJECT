package com.homecat.sweethome.service.impl.message;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.message.MessageMapper;
import com.homecat.sweethome.service.message.MessageService;
import com.homecat.sweethome.vo.message.MessageVO;

@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	MessageMapper messageMapper;

	@Override
	public int sendMessage(MessageVO messageVO) {
		return this.messageMapper.sendMessage(messageVO);
	}

	@Override
	public int checkReceiver(String receiver) {
		return this.messageMapper.checkReceiver(receiver);
	}

	@Override
	public List<MessageVO> getReceiveMessage(Map<String, Object> map) {
		return this.messageMapper.getReceiveMessage(map);
	}

	@Override
	public List<MessageVO> getSendMessage(Map<String, Object> map) {
		return this.messageMapper.getSendMessage(map);
	}

	@Override
	public int readCheck(Map<String, Object> map) {
		return this.messageMapper.readCheck(map);
	}

	@Override
	public int sendCount(Map<String, Object> map) {
		return this.messageMapper.sendCount(map);
	}

	@Override
	public int receiveCount(Map<String, Object> map) {
		return this.messageMapper.receiveCount(map);
	}

	@Override
	public List<MessageVO> msgDetail(int msgSeq) {
		return this.messageMapper.msgDetail(msgSeq);
	}

	@Override
	public List<MessageVO> getReceiveMessageAsc(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.messageMapper.getReceiveMessageAsc(map);
	}

	@Override
	public List<MessageVO> getSendMessageAsc(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.messageMapper.getSendMessageAsc(map);
	}

	@Override
	public List<MessageVO> readCheckAsc(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return this.messageMapper.readCheckAsc(map);
	}

	@Override
	public List<MessageVO> readCheckDesc(Map<String, Object> map) {
		
		return this.messageMapper.readCheckDesc(map);
	}

	@Override
	public int receiveDel(int msgSeq) {
		return this.messageMapper.receiveDel(msgSeq);
	}

	@Override
	public int sendDel(int msgSeq) {
		return this.messageMapper.sendDel(msgSeq);
	}

	@Override
	public int receiveNotReadCount(String receiver) {
		return this.messageMapper.receiveNotReadCount(receiver);
	}

}
