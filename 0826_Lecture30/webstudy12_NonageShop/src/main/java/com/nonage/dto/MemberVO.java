package com.nonage.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String zipNum;
	private String address;
	private String phone;
	private String useyn;
	private Timestamp indate;
}
