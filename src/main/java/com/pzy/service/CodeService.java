
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

import com.pzy.entity.Category;
import com.pzy.entity.Grade;
import com.pzy.entity.Item;
import com.pzy.entity.Major;
import com.pzy.repository.GradeRepository;
import com.pzy.repository.MajorRepository;
/***
 * 
 * @author qq:263608237
 *
 */
@Service
public class CodeService {
     
	 @Autowired
     private GradeRepository gradeRepository;
     
     @Autowired
     private MajorRepository majorpository;
     
     @Autowired
     private StandardService standardService;

 	 public List<Grade> findAllGrade(){
 		 return (List<Grade>) gradeRepository.findAll();
 	 }
 	 public List<Grade> findAllGrade(Long id){
 		 return (List<Grade>) gradeRepository.findAll();
 	 }
 	 public Grade findOne(Long id){
		 return gradeRepository.findOne(id);
	 }
 	 public List<Grade> findAllGrade(final Long gid,final Long mid,final String year){
         Specification<Grade> spec = new Specification<Grade>() {
              public Predicate toPredicate(Root<Grade> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (gid != null) {
                   predicate.getExpressions().add(cb.equal(root.get("id").as(Long.class), gid));
              }
              if (mid != null) {
                  predicate.getExpressions().add(cb.equal(root.get("major").get("id").as(Long.class), mid));
              }
              return predicate;
              }
         };
    	 List<Grade> grades=( List<Grade>) gradeRepository.findAll(spec);
         
         
 		 for(Grade grade:grades){
 			 grade.setStandard(standardService.findByGradeAndYear(grade,year));
 			 if(grade.getStandard()==null)
 				 grade.setState("未设置");
 			 else{
 				 grade.setState("已设置");
 				 
 				 Double all=0d;
 				 for(Item item:grade.getStandard().getItems()){
 					 all+=item.getFee();
 				 }
 				grade.setToalfee(all);
 			 }
 				
 			 grade.setYear(year+"学年");
 		 }
 		 return grades;
 	 }
 	  public List<Major> findAllMajor(){
 		 return (List<Major>) majorpository.findAll();
 	 }
}