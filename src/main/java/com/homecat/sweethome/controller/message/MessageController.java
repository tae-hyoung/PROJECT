package com.homecat.sweethome.controller.message;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.homecat.sweethome.service.message.MessageService;
import com.homecat.sweethome.vo.message.MessageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MessageController {

	@Autowired
	MessageService messageService;

	/* 메세지 리스트 뿌려주는 곳  */
	@GetMapping("/resident/msg")
	public String residentMsgList() {
		log.info("입주민이 메세지들 불러오는 페이지입니다.");
		
		return "resident/message/list";
	}
	
	@GetMapping("/admin/msg")
	public String adminMsgList() {
		log.info("관리자 메세지들 불러오는 페이지입니다.");
		
		return "admin/message/list";
	}
	
	@GetMapping("/master/msg")
	public String masterMsgList() {
		log.info("운영자 메세지들 불러오는 페이지입니다.");
		
		return "master/message/list";
	}
	
	/* 보낸 메시지 정렬  */
	@ResponseBody
	@GetMapping("/sendList")
	public List<MessageVO> getSendMessage(@RequestParam int sendPage, @RequestParam String receiver, Principal principal){
		Map<String, Object> map = new HashMap<>();
		map.put("sendPage", sendPage);
		map.put("receiver",receiver);
		map.put("sender", principal.getName());
		
		List<MessageVO> list = messageService.getSendMessage(map);
		log.info("받아온 거 {}",list);
		
		return list;
	}
	
	
	@ResponseBody
	@GetMapping("/sendListAsc")
	public List<MessageVO> getSendMessageAsc(@RequestParam int sendPage, @RequestParam String receiver, Principal principal){
		Map<String, Object> map = new HashMap<>();
		map.put("sendPage", sendPage);
		map.put("receiver",receiver);
		map.put("sender", principal.getName());
		
		List<MessageVO> list = messageService.getSendMessageAsc(map);
		log.info("받아온 거 {}",list);
		
		return list;
	}
	
	
	/* 받은 메세지 정렬  */
	@ResponseBody
	@GetMapping("/receiveList")
	public List<MessageVO> getReceiveMessage(@RequestParam int receivePage, @RequestParam String sender, Principal principal){
		Map<String, Object> map = new HashMap<>();
		map.put("receivePage", receivePage);
		map.put("receiver", principal.getName());
		map.put("sender", sender);
		
		List<MessageVO> list = messageService.getReceiveMessage(map);
		
		return list;
	}
	
	@ResponseBody
	@GetMapping("/receiveListAsc")
	public List<MessageVO> getReceiveMessageAsc(@RequestParam int receivePage, @RequestParam String sender, Principal principal){
		Map<String, Object> map = new HashMap<>();
		map.put("receivePage", receivePage);
		map.put("receiver", principal.getName());
		map.put("sender", sender);
		
		List<MessageVO> list = messageService.getReceiveMessageAsc(map);
		
		return list;
	}
	
	@ResponseBody
	@GetMapping("/readCheckAsc")
	public List<MessageVO> readCheckAsc(@RequestParam int sendPage, @RequestParam String receiver, Principal principal){
		Map<String, Object> map = new HashMap<>();
		map.put("sendPage", sendPage);
		map.put("receiver",receiver);
		map.put("sender", principal.getName());
		
		List<MessageVO> list = messageService.readCheckAsc(map);
		
		return list;
	}
	
	@ResponseBody
	@GetMapping("/readCheckDesc")
	public List<MessageVO> readCheckDesc(@RequestParam int sendPage, @RequestParam String receiver, Principal principal){
		Map<String, Object> map = new HashMap<>();
		map.put("sendPage", sendPage);
		map.put("receiver",receiver);
		map.put("sender", principal.getName());
		
		List<MessageVO> list = messageService.readCheckDesc(map);
		
		return list;
	}
	
	
	@ResponseBody
	@GetMapping("/receiveCount")
	public Map<String, Object> receiveCount(@RequestParam(value="sender") String sender, Principal principal){
		int count = 0;
		
		Map<String, Object> map  = new HashMap<>();
		
		String receiver = principal.getName();
		
		map.put("receiver", receiver);
		map.put("sender", sender);
		
		Map<String, Object> msgMap = new HashMap<>();
		
		count = messageService.receiveCount(map);
		msgMap.put("cnt", count);
		
	 	return msgMap; 
		
	}
	
	@ResponseBody
	@GetMapping("/receiveNotReadCount")
	public Map<String, Object> receiveNotReadCount(Principal principal){
		int count = 0;	
		String receiver = principal.getName();	
		Map<String, Object> msgMap = new HashMap<>();
		
		count = messageService.receiveNotReadCount(receiver);
		msgMap.put("cnt", count);
		
	 	return msgMap; 
		
	}
	
	
	@ResponseBody
	@GetMapping("/sendCount")
	public Map<String, Object> sendCount(@RequestParam(value="receiver") String receiver, Principal principal){
		int count = 0;
		
		Map<String, Object> map  = new HashMap<>();
		
		String sender = principal.getName();
		
		map.put("receiver", receiver);
		map.put("sender", sender);
		
		Map<String, Object> msgMap = new HashMap<>();
		
		count = messageService.sendCount(map);
		log.info("찍히는 count값 {}", count);
		msgMap.put("cnt", count);
		
	 	return msgMap; 
		
	}
	
	
	
	/**
	 * 메세지 전송
	 * @param messageVO
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping("/sendMsg")
	public int sendMessage(@RequestBody MessageVO messageVO, Principal principal) {
		
		MessageVO msgVO  = new MessageVO();
	
		msgVO.setSender(principal.getName());
		msgVO.setReceiver(messageVO.getReceiver());
		msgVO.setTitle(messageVO.getTitle());
		msgVO.setContent(messageVO.getContent());
		log.info(msgVO.toString(),"{} 메세지 관련 로그입니다~");
		
		int result = messageService.sendMessage(msgVO);
		
		log.info("1이뜨면 전송 성공{}", result);
		
		return result;
	}
	
	/**
	 * 아이디 유무 확인
	 * @param receiver
	 * @return
	 */
	@ResponseBody
	@PostMapping("/checkReceiver")
	public Map<String, Object> checkReceiver(@RequestBody String receiver){
		log.info("수신자 유무 체크");
		int count = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		count = messageService.checkReceiver(receiver);
		map.put("cnt", count);
		log.info("cnt 값 에 들어감 -> {}", count);
		log.info("맵값 : {}", map.get("cnt"));
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/readCheck")
	public int readCheck(@RequestParam int msgSeq, Principal principal) {
		
		log.info("어 읽었어. {}",msgSeq);
		Map<String, Object> map = new HashMap<String, Object>();
		String receiver = principal.getName();
		log.info("넘어온 시퀀스 값 : {}", msgSeq);
		map.put("msgSeq", msgSeq);
		map.put("receiver", receiver);
		
		return messageService.readCheck(map);
	}
	
	
	@ResponseBody
	@GetMapping("/msgDetail")
	public List<MessageVO> msgDetail(@RequestParam int msgSeq){
			
		List<MessageVO> detail = messageService.msgDetail(msgSeq);
		
		log.info("메세지 상세 {}", detail);
		
		return detail;
	}
	
	
	@ResponseBody
	@PostMapping("/receiveDel")
	public int receiveDel(@RequestBody List<Integer> msgSeq) {
		int deleteCount = 0;
		
		for(int seq: msgSeq) {
			int result = messageService.receiveDel(seq);
			if(result > 0) {
				deleteCount++;
			}
		}
		
		return deleteCount;
	}
	
	
	@ResponseBody
	@PostMapping("/sendDel")
	public int sendDel(@RequestBody List<Integer> msgSeq) {
		int deleteCount = 0;
		
		for(int seq: msgSeq) {
			int result = messageService.sendDel(seq);
			if(result > 0) {
				deleteCount++;
			}
		}
		
		return deleteCount;
	}
}
