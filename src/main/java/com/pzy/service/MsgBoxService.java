
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

import com.pzy.entity.MsgBox;
import com.pzy.entity.Work;
import com.pzy.repository.MsgBoxRepository;
/***
 * 
 * @author qq:263608237
 *
 */
@Service
public class MsgBoxService {
     @Autowired
     private MsgBoxRepository MsgBoxRepository;

 	public List<MsgBox> findTop3() {
 		return MsgBoxRepository.findAll(
 				new PageRequest(0, 15, new Sort(Direction.DESC, "createDate")))
 				.getContent();
 	}
 	 public List<MsgBox> findByWork(Work work) {
         return MsgBoxRepository.findByWork(work);
     }
     public List<MsgBox> findAll() {
         return (List<MsgBox>) MsgBoxRepository.findAll(new Sort(Direction.DESC, "id"));
     }
     public Page<MsgBox> findAll(final int pageNumber, final int pageSize,final String name){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
         Specification<MsgBox> spec = new Specification<MsgBox>() {
              public Predicate toPredicate(Root<MsgBox> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (name != null) {
                   predicate.getExpressions().add(cb.like(root.get("remark").as(String.class), "%"+name+"%"));
              }
              return predicate;
              }
         };
         Page<MsgBox> result = (Page<MsgBox>) MsgBoxRepository.findAll(spec, pageRequest);
         return result;
     	}
     
     public Page<MsgBox> findAll(final int pageNumber, final int pageSize,final Integer type ){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
         Specification<MsgBox> spec = new Specification<MsgBox>() {
              public Predicate toPredicate(Root<MsgBox> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (type != null) {
                  predicate.getExpressions().add(cb.equal(root.get("type").as(Integer.class),type));
               }
              return predicate;
              }
         };
         Page<MsgBox> result = (Page<MsgBox>) MsgBoxRepository.findAll(spec, pageRequest);
         return result;
     	}
		public void delete(Long id){
			MsgBoxRepository.delete(id);
		}
		public MsgBox find(Long id){
			  return MsgBoxRepository.findOne(id);
		}
		public void save(MsgBox MsgBox){
			MsgBoxRepository.save(MsgBox);
		}
}