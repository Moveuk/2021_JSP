package com.nonage.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddressVO {
	private String zip_num;
	private String sido;
	private String gugun;
	private String dong;
	private String zip_code;
	private String bunji;
	
	@Override
	public String toString() {
		return "AddressVO [zip_num=" + zip_num + ", sido=" + sido + ", gugun=" + gugun + ", dong=" + dong
				+ ", zip_code=" + zip_code + ", bunji=" + bunji + "]";
	}
	
	
}
