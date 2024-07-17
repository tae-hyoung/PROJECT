package com.homecat.sweethome.unit;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.homecat.sweethome.vo.attach.AttachVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UploadController {
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	String uploadFolderDirect;
	
	@Autowired
	AttachDao attachDao;
	
	// CKEditor5 파일업로드
	// /image/upload
	// ckeditor는 이미지 업로드 후 이미지 표시하기 위해 uploaded 와 url을 json 형식으로 받아야 함
	// modelandview를 사용하여 json 형식으로 보내기위해 모델앤뷰 생성자 매개변수로 jsonView 라고 써줌
	// jsonView 라고 쓴다고 무조건 json 형식으로 가는건 아니고 @Configuration 어노테이션을 단 
	// WebConfig 파일에 MappingJackson2JsonView 객체를 리턴하는 jsonView 매서드를 만들어서 bean으로 등록해야 함 
	@ResponseBody
	@PostMapping("/image/upload")
	public Map<String, Object> image(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
		ModelAndView mav = new ModelAndView("jsonView");
		
		// ckeditor 에서 파일을 보낼 때 upload : [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 밸류를 받아서
		// uploadFile에 저장함
		MultipartFile uploadFile = request.getFile("upload");
		log.info("uploadFile: " + uploadFile);
		
		// 파일 명
		String originalFileName = uploadFile.getOriginalFilename();
		log.info("originalFileName: " + originalFileName);
		
		String ext = originalFileName.substring(originalFileName.indexOf("."));
		log.info("ext: " + ext);

		SimpleDateFormat sdf = new SimpleDateFormat("HHmmssSSS");
		Date date = new Date();
		String uploadTime = sdf.format(date);
		log.info("uploadTime: " + uploadTime);
		
//		String newFileName = UUID.randomUUID() + "_" + originalFileName;
		String newFileName = getFolder() + File.separator + uploadTime + "_" + originalFileName;
		
		File uploadFolderPath = new File(uploadFolderDirect, getFolder());
		if(uploadFolderPath.exists()==false) {
			uploadFolderPath.mkdirs();
		}
		
		File file = new File(uploadFolderDirect, newFileName);
		
		uploadFile.transferTo(file);
		
		// 브라우저에서 이미지 불러올 때 절대 경로로 불러오면 보안의 위험 있어 상대경로를 쓰거나 이미지 불러오는 jsp 또는 클래스 파일을 만들어
		// 가져오는 식으로 우회해야 함
		// 때문에 savePath와 별개로 상대 경로인 uploadPath 만들어줌
		String uploadPath = "/upload/ckeditor/" + newFileName;
		
		// uploaded, url 값을 modelandview를 통해 보냄
//		mav.addObject("uploaded", true); // 업로드 완료
//		mav.addObject("url", uploadPath); // 업로드 파일의 경로
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uploaded", true);
		map.put("url", uploadPath);
		
		log.info("map: " + map);
		
		return map;
	}
	
	
	//연/월/일 폴더 생성
	public String getFolder() {
		//2022-11-16 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2022-11-16
		String str = sdf.format(date);
		//2024-01-30 -> 2024\\01\\30
		return str.replace("-", File.separator);
	}

	public int uploadOne(MultipartFile uploadFile, String globalCode) {
		int result = 0;
		
		File uploadPath = new File(uploadFolder, getFolder());
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		log.info("-------------------");
		log.info("파일명: " + uploadFile.getOriginalFilename());
		log.info("파일크기: " + uploadFile.getSize());
		log.info("MIME타입: " + uploadFile.getContentType());


		SimpleDateFormat sdf = new SimpleDateFormat("HHmmssSSS");
		Date date = new Date();
		String uploadTime = sdf.format(date);
		log.info("uploadTime: " + uploadTime);
		
//		UUID uuid = UUID.randomUUID();
//		String uploadFileName = uuid.toString() + "_" + uploadFile.getOriginalFilename();
		String uploadFileName = uploadTime + "_" + uploadFile.getOriginalFilename();
		log.info("uploadPath: " + uploadPath);
		log.info("uploadFileName: " + uploadFileName);
		
		File saveFile = new File(uploadPath, uploadFileName);
		try {
			uploadFile.transferTo(saveFile);
			
			String fileName = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
			
			AttachVO attachVO = new AttachVO();
			attachVO.setGlobalCode(globalCode);
			attachVO.setAttchSeq(1);
			attachVO.setFileName(fileName);
			attachVO.setFileSize(uploadFile.getSize());
			attachVO.setContentType(uploadFile.getContentType());
			attachVO.setRegDt(null);
			
			log.info("uploadOne->attachVO: " + attachVO);
			
			result += attachDao.insertAttach(attachVO);
			log.info("uploadOne->result: " + result);
			
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage());
		}
		return result;
	}

	public int uploadMulti(MultipartFile[] pictures, String globalCode) {
		int result = 0;
		
		File uploadPath = new File(uploadFolder, getFolder());
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("HHmmssSSS");
		Date date = new Date();
		String uploadTime = sdf.format(date);
		log.info("uploadTime: " + uploadTime);
		
		int seq = 1;
		for(MultipartFile picture: pictures) {
//			UUID uuid = UUID.randomUUID();
//			String uploadFileName = uuid.toString() + "_" + picture.getOriginalFilename();
			String uploadFileName = uploadTime + "_" + picture.getOriginalFilename();
			log.info("uploadFileName: " + uploadFileName);
			
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				picture.transferTo(saveFile);
				
				String fileName = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
				
				AttachVO attachVO = new AttachVO();
				attachVO.setGlobalCode(globalCode);
				attachVO.setAttchSeq(seq++);
				attachVO.setFileName(fileName);
				attachVO.setFileSize(picture.getSize());
				attachVO.setContentType(picture.getContentType());
				attachVO.setRegDt(null);
				
				log.info("uploadOne->attachVO: " + attachVO);
				
				result += attachDao.insertAttach(attachVO);
				log.info("uploadOne->result: " + result);
				
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}
		
		return result;
	}
}
