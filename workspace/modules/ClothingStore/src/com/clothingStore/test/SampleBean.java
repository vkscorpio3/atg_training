package com.clothingStore.test;

import java.io.Serializable;

public class SampleBean implements Serializable {

	private String 			samplePropertyString;
	private int 			samplePropertyInt;
	private SampleAddress 	samplePropertyAddress;

	
	public SampleBean() {
		samplePropertyString = "This is a default";
		samplePropertyInt = 99;
		samplePropertyAddress = new SampleAddress();
	}
	
	public SampleAddress getSamplePropertyAddress() {
		return samplePropertyAddress;
	}

	public void setSamplePropertyAddress(SampleAddress samplePropertyAddress) {
		this.samplePropertyAddress = samplePropertyAddress;
	}

	public String getSamplePropertyString() {
		return samplePropertyString;
	}

	public void setSamplePropertyString(String samplePropertyString) {
		this.samplePropertyString = samplePropertyString;
	}

	public int getSamplePropertyInt() {
		return samplePropertyInt;
	}

	public void setSamplePropertyInt(int samplePropertyInt) {
		this.samplePropertyInt = samplePropertyInt;
	}


}
