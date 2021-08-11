package com.ldu.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeeVO {	
	private Integer num;
	private String id;
	private String pass;
	private String name;
	private String lev;
	private Timestamp enter;
	private String gender;
	private String phone;
}
