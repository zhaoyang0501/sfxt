
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

import com.pzy.entity.Fee;
import com.pzy.entity.Grade;
import com.pzy.entity.User;
import com.pzy.repository.FeeRepository;
import com.pzy.repository.UserRepository;
/***
 * 
 * @author qq:263608237
 *
 */
@Service
public class FeeService {
     @Autowired
     private FeeRepository feeRepository;
     
     @Autowired
     private UserRepository userRepository;
 	public List<Fee> findTop3() {
 		return feeRepository.findAll(
 				new PageRequest(0, 15, new Sort(Direction.DESC, "createDate")))
 				.getContent();
 	}
 	
 	
 	 public Page<User> findAllFee(final int pageNumber, final int pageSize,final Long gid,final Long mid,final String year){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
        
         Specification<User> spec = new Specification<User>() {
             public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
             Predicate predicate = cb.conjunction();
             if (gid != null) {
                  predicate.getExpressions().add(cb.equal(root.get("grade").get("id").as(Long.class), gid));
             }
             if (mid != null) {
                 predicate.getExpressions().add(cb.equal(root.get("grade").get("major").get("id").as(Long.class), mid));
             }
             return predicate;
             }
        };
         Page<User> result = (Page<User>)  userRepository.findAll(spec,pageRequest);
         wrapFee(result,year);
         return result;
     }
 	  private void wrapFee(Page<User> users,String year){
     	 for(User user:users.getContent()){
     		 user.setFee(this.find(user, year));
     	 }
     	 
      }
     public List<Fee> findAll() {
         return (List<Fee>) feeRepository.findAll(new Sort(Direction.DESC, "id"));
     }
     public Page<Fee> findAll(final int pageNumber, final int pageSize,final String name){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
         Specification<Fee> spec = new Specification<Fee>() {
              public Predicate toPredicate(Root<Fee> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (name != null) {
                   predicate.getExpressions().add(cb.like(root.get("name").as(String.class), "%"+name+"%"));
              }
              return predicate;
              }
         };
         Page<Fee> result = (Page<Fee>) feeRepository.findAll(spec, pageRequest);
         return result;
     	}
     
     public Page<Fee> findAll(final int pageNumber, final int pageSize,final Integer type ){
         PageRequest pageRequest = new PageRequest(pageNumber - 1, pageSize, new Sort(Direction.DESC, "id"));
         Specification<Fee> spec = new Specification<Fee>() {
              public Predicate toPredicate(Root<Fee> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
              Predicate predicate = cb.conjunction();
              if (type != null) {
                  predicate.getExpressions().add(cb.equal(root.get("type").as(Integer.class),type));
               }
              return predicate;
              }
         };
         Page<Fee> result = (Page<Fee>) feeRepository.findAll(spec, pageRequest);
         return result;
     	}
		public void delete(Long id){
			feeRepository.delete(id);
		}
		public Fee find(Long id){
			  return feeRepository.findOne(id);
		}
		public Fee find(User user ,String year){
			  List<Fee> fees= feeRepository.findByUserAndYear(user,year);
			  return fees.size()==0?null:fees.get(0);
		}
		public  List<Fee> find(User user){
			  return  feeRepository.findByUser(user);
		}
		public void save(Fee fee){
			feeRepository.save(fee);
		}
}