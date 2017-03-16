package com.clothing.handler;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;

import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;
import atg.userprofiling.ProfileFormHandler;

public class ClothingFormHandler extends ProfileFormHandler {

	private String day;
	private String month;
	private String year;

	@Override
	public void preCreateUser(DynamoHttpServletRequest request, DynamoHttpServletResponse response) {
		try {
			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
			Date dob = cal.getTime();
			getValue().put("dateOfBirth", dob);
			super.preCreateUser(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	public String sayHello() {
		return "Hello ATG";
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

}
