package com.pzy.repository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.pzy.entity.Grade;
import com.pzy.entity.Major;
public interface GradeRepository extends PagingAndSortingRepository<Grade, Long>,JpaSpecificationExecutor<Grade>{
}

