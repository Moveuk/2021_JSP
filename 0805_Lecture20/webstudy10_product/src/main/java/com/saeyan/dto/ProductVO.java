package com.saeyan.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductVO {
	private Integer code;
	private String name;
	private Integer price;
	private String description;
	private String pictureUrl;
	
	@Override
	public String toString() {
		return "ProductVO [code=" + code + ", name=" + name + ", price=" + price + ", description=" + description
				+ ", pictureUrl=" + pictureUrl + "]";
	}
	
}
