package com.homecat.sweethome.mapper.publicFacilities;

import java.util.List;

import com.homecat.sweethome.vo.publicFacilities.FacilityVO;
import com.homecat.sweethome.vo.publicFacilities.ReserveVO;

/**
 * 공용시설물(테니스, 스크린골프 , 독서실) 관리  FacilityMapper interface
 * 
 * @author 이혜민
 *
 */
public interface FacilityMapper {

	/**
	 * 공용시살물 각 메인에  시설정보 불러오기
	 * @param facCode : 시설 코드값을 전달 받아서 해당하는 정보를 목록으로 조회 처리 할수 있도록 인자값을 넘긴다  
	 * @return List<FacilityVO> : 시설정보를 목록으로 반환 
	 */
	public List<FacilityVO> tennisMain(String facCode);

	/**
	 * 공용시설물 각 메인에 예약 내역 불러오기
	 * @param reserveVO : 예약 VO 을 전달 받아서 해당하는 정보를 목록으로 조회 처리 할수 있도록 인자값을 넘긴다
	 * @return List<ReserveVO> : 
	 */
	public List<ReserveVO> reserveList(ReserveVO reserveVO);

	/**
	 * 공용시설물 각 예약 insert
	 * @param reserveVO
	 * @return int : 정상적으로 등록에 성공하면 1을 반환
	 */
	public int reservation(ReserveVO reserveVO);

	/**
	 * 예약 취소
	 * @param reserveVO
	 * @return int : 정상적으로 취소에 성공하면 1을 반환
	 */
	public int cancleRe(ReserveVO reserveVO);

	/**
	 * 예약 내역을 불러와서 타입테이블에 예약 차 있는 곳 막아주기
	 * @param reserveVO
	 * @return List<ReserveVO> :  예약 내역을 담고 있는 list를 반환
	 */
	public List<ReserveVO> blockRe(ReserveVO reserveVO);

	/**
	 * 실시간으로 사용하고 있는 코트를 회색으로 처리해주기
	 * @param reserveVO
	 * @return List<ReserveVO> :  예약 내역을 담고 있는 list를 반환
	 */
	public List<ReserveVO> liveRe(ReserveVO reserveVO);

	/**
	 * [관리자] 각 시설물의 오늘 예약 내역을 볼 수 있음
	 * @param facCode : 공용시설물 코드
	 * @return List<ReserveVO> :  예약 내역을 담고 있는 list를 반환
	 */
	public List<ReserveVO> adReserveList(String facCode);

	/**
	 * [관리자] 전체 예약 리스트
	 * @return  List<ReserveVO> :  예약 내역을 담고 있는 list를 반환
	 */
	public List<ReserveVO> allReList();

	/**
	 * 전체 예약 게시판에 시설물 별로 볼 수 있음
	 * @param facCode : 공용시설물 코드
	 * @return List<ReserveVO> :  예약 내역을 담고 있는 list를 반환
	 */
	public List<ReserveVO> selectCa(String facCode);

	/**
	 * 예약별 상세 정보 보기 ( 예약 내역과 멤버 상세 )
	 * @param reserveVO
	 * @return ReserveVO : 예약의 상세 정보를 담고 있음
	 */
	public ReserveVO reDetail(ReserveVO reserveVO);

	/**
	 * 월별 예약 통계
	 * @return  List<ReserveVO> :  예약 내역을 담고 있는 list를 반환
	 */
	public List<ReserveVO> totalRe();

	/**
	 * 요일별 예약 통계
	 * @return  List<ReserveVO> :  예약 내역을 담고 있는 list를 반환
	 */
	public List<ReserveVO> dayCntList();

	/////////////////캘린더////////////////////////
	public List<ReserveVO> reserveCalList(ReserveVO reserveVO);

}
