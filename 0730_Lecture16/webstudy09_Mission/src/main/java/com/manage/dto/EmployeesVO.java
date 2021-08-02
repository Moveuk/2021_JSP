package com.manage.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeesVO {
	private String id,pass,name,lev,phone;
	private Date enter;
	private Integer gender;
	
	@Override
	public String toString() {
		return "EmployeesVO [id=" + id + ", pass=" + pass + ", name=" + name + ", lev=" + lev + ", phone=" + phone
				+ ", enter=" + enter + ", gender=" + gender + "]";
	}
}
