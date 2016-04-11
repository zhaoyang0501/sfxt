package com.pzy.repository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.pzy.entity.Major;
public interface MajorRepository extends PagingAndSortingRepository<Major, Long>,JpaSpecificationExecutor<Major>{
}

