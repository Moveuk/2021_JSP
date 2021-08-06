package com.theater.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovieVO {
	private Integer code;
	private String title;
	private Integer price;
	private String director;
	private String actor;
	private String poster;
	private String synopsis;
	
	@Override
	public String toString() {
		return "MovieVO [code=" + code + ", title=" + title + ", price=" + price + ", director=" + director + ", actor="
				+ actor + ", poster=" + poster + ", synopsis=" + synopsis + "]";
	}
}
