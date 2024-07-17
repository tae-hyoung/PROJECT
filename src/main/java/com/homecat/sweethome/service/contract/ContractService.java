package com.homecat.sweethome.service.contract;

import java.util.List;

import com.homecat.sweethome.vo.contract.ContractVO;

public interface ContractService {

	public List<ContractVO> contractList();

	public int createContract(ContractVO contractVO);

	public List<ContractVO> getTopList(int num);

}
