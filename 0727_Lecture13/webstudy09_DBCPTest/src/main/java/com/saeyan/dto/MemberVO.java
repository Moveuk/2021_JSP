package com.saeyan.dto;

import lombok.*;

@Getter
@Setter
@ToString (exclude = "pwd")
public class MemberVO {
	private String name;
	private String userid;
	private String pwd;
	private String email;
	private String phone;
	private int admin;
	
}
