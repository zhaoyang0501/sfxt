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
/**上课单
 * @author Administrator
 *
 */
@Entity
@Table(name = "t_work")
public class Work {
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	private String name;
	
	private String remark;
	
	private String grade;
	
	private String type;
	
	private String title;
	
	private String clazz;
	
	private String lessonbefore;
	
	private String lessonafter;
	
	@OneToMany( mappedBy = "work",fetch=FetchType.EAGER,cascade = CascadeType.ALL)
	private List<Report> report;
	
	
	@ManyToOne(fetch = FetchType.EAGER)
	private User user;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	private Date workdate;
	
	private Date createDate;
	
	private String state;
	
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
	public List<Report> getReport() {
		return report;
	}
	public void setReport(List<Report> report) {
		this.report = report;
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
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getClazz() {
		return clazz;
	}
	public void setClazz(String clazz) {
		this.clazz = clazz;
	}
	public String getLessonbefore() {
		return lessonbefore;
	}
	public void setLessonbefore(String lessonbefore) {
		this.lessonbefore = lessonbefore;
	}
	public String getLessonafter() {
		return lessonafter;
	}
	public void setLessonafter(String lessonafter) {
		this.lessonafter = lessonafter;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getWorkdate() {
		return workdate;
	}
	public void setWorkdate(Date workdate) {
		this.workdate = workdate;
	}
	
	
}