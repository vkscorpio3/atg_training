package com.clothing.handler;

public class TestComponent {

	private String firstName, lastName;

	public String sayHello() {
		return "Hello ATG";
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

}
