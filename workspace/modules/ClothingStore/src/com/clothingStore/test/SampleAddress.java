package com.clothingStore.test;

import java.io.Serializable;

public class SampleAddress implements Serializable {

	private String 		name;
	private String 		street;
	private String		city;
	private String		state;
	private String		country;
	private String		zip;
	

	public SampleAddress() {

		name = "Tim Aiken";
		street = "49 Stevenson";
		city="San Francisco";
		state = "California";
		country="USA";
		zip="96160";
	}

	public SampleAddress(String name, String street, String city, String state, String country, String zip) {
		this.name = name;
		this.street = street;
		this.city = city;
		this.state = state;
		this.country = country;
		this.zip = zip;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}
	
	
}
