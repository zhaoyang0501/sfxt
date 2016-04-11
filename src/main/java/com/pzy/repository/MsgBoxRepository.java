package com.pzy.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.pzy.entity.MsgBox;
import com.pzy.entity.Work;
public interface MsgBoxRepository extends PagingAndSortingRepository<MsgBox, Long>,JpaSpecificationExecutor<MsgBox>{
	public List<MsgBox> findByWork(Work work);

}

