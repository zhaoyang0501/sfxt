package com.pzy.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.pzy.entity.Fee;
import com.pzy.entity.User;
public interface FeeRepository extends PagingAndSortingRepository<Fee, Long>,JpaSpecificationExecutor<Fee>{
	public List<Fee> findByUserAndYear(User user,String year);
	public List<Fee> findByUser(User user);
}

