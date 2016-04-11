package com.pzy.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.pzy.entity.Grade;
import com.pzy.entity.Standard;
public interface StandardRepository extends PagingAndSortingRepository<Standard, Long>,JpaSpecificationExecutor<Standard>{
	public List<Standard> findByGrade(Grade grade);
	public List<Standard> findByGradeAndYear(Grade grade,String year);
}

