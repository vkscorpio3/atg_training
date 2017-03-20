package com.anupam.droplet;

import java.io.IOException;

import javax.servlet.ServletException;

import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;
import atg.servlet.DynamoServlet;

public class MyDroplet extends DynamoServlet {

	@Override
	public void service(DynamoHttpServletRequest req, DynamoHttpServletResponse res)
			throws ServletException, IOException {
		

		String input = req.getParameter("myinput");
		input = input.toUpperCase();
		req.setParameter("myoutput", input);
		req.serviceParameter("output", req, res);
		
	}
}
