package com.pzy.entity;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
/***
 * 分类
 *
 */
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
/**上课单
 * @author Administrator
 *
 */
@Entity
@Table(name = "t_fee")
public class Fee {
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	private String name;
	
	private String remark;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	private User user;
	
	private Date createDate;
	
	private String state;
	
	private String year;
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	private String paytype;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.EAGER,cascade=CascadeType.ALL) 
	private List<FeeItem> feeitems;
	
	private Double allfee;
	
	private Double  needfee;
	
	private Double payfee;
	
	private Double lastfee;
	
	public Double getAllfee() {
		return allfee;
	}
	public void setAllfee(Double allfee) {
		this.allfee = allfee;
	}
	
	public List<FeeItem> getFeeitems() {
		return feeitems;
	}
	public void setFeeitems(List<FeeItem> feeitems) {
		this.feeitems = feeitems;
	}
	
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	public Double getNeedfee() {
		return needfee;
	}
	public void setNeedfee(Double needfee) {
		this.needfee = needfee;
	}
	public Double getPayfee() {
		return payfee;
	}
	public void setPayfee(Double payfee) {
		this.payfee = payfee;
	}
	public Double getLastfee() {
		return lastfee;
	}
	public void setLastfee(Double lastfee) {
		this.lastfee = lastfee;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}