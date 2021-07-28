package com.saeyan.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	private String name; 
    private String userid;
    private String pwd;
    private String email;
    private String phone;
    private int admin;
    
	@Override
	public String toString() {
		
		return "MemberVO [name=" + name + ", userid=" + userid + ", pwd=" + pwd
				+ ", email=" + email + ", phone=" + phone + ", admin=" + admin
				+ "]";
	}  
}
