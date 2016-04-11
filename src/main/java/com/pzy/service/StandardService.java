
package com.pzy.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.pzy.entity.Grade;
import com.pzy.entity.Item;
import com.pzy.entity.Standard;
import com.pzy.repository.StandardRepository;
/***
 * 
 * @author qq:263608237
 *
 */
@Service
public class StandardService {
     @Autowired
     private StandardRepository standardRepository;

 	public List<Standard> findTop3() {
 		return standardRepository.findAll(
 				new PageRequest(0, 15, new Sort(Direction.DESC, "createDate")))
 				.getContent();
 	}
 	
     public List<Standard> findAll() {
         return (List<Standard>) standardRepository.findAll(new Sort(Direction.DESC, "id"));
     }
     public Page<Standard> findAll(final int pageNumber, final int pageSize,final String name){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
         Specification<Standard> spec = new Specification<Standard>() {
              public Predicate toPredicate(Root<Standard> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (name != null) {
                   predicate.getExpressions().add(cb.like(root.get("name").as(String.class), "%"+name+"%"));
              }
              return predicate;
              }
         };
         Page<Standard> result = (Page<Standard>) standardRepository.findAll(spec, pageRequest);
         return result;
     	}
     
     public Page<Standard> findAll(final int pageNumber, final int pageSize,final Integer type ){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
         Specification<Standard> spec = new Specification<Standard>() {
              public Predicate toPredicate(Root<Standard> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (type != null) {
                  predicate.getExpressions().add(cb.equal(root.get("type").as(Integer.class),type));
               }
              return predicate;
              }
         };
         Page<Standard> result = (Page<Standard>) standardRepository.findAll(spec, pageRequest);
         return result;
     	}
		public void delete(Long id){
			standardRepository.delete(id);
		}
		public Standard find(Long id){
			  return standardRepository.findOne(id);
		}
		public void save(Standard standard){
			standardRepository.save(standard);
		}
		
		public Standard findByGradeAndYear(Grade grade,String year){
			List<Standard> list=standardRepository.findByGradeAndYear(grade,year);
			return list.size()==0?null:list.get(0);
		}
		public List<Standard> findByGrade(Grade grade){
			 List<Standard> list= standardRepository.findByGrade(grade);
			 for(Standard standard:list){
	 				 Double all=0d;
	 				 for(Item item:standard.getItems()){
	 					 all+=item.getFee();
	 				 }
	 				standard.setToalfee(all);
	 			 }
			 return list;
	 		 }
       }