package com.gx.user.domain;

public class User {
	private int id;
	private String Gusername;
	private String Gpwd;
	private String Gmail;
	private String Gtel;
	private String GcreateTime;
	// private String Gsex;
	private int level;
	private String Gimage;
	private String Gtitle;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGusername() {
		return this.Gusername;
	}

	public void setGusername(String gusername) {
		this.Gusername = gusername;
	}

	public String getGpwd() {
		return this.Gpwd;
	}

	public void setGpwd(String gpwd) {
		this.Gpwd = gpwd;
	}

	public String getGmail() {
		return this.Gmail;
	}

	public void setGmail(String gmail) {
		this.Gmail = gmail;
	}

	public String getGtel() {
		return this.Gtel;
	}

	public void setGtel(String gtel) {
		this.Gtel = gtel;
	}

	public String getGcreateTime() {
		return this.GcreateTime;
	}

	public void setGcreateTime(String gcreateTime) {
		this.GcreateTime = gcreateTime;
	}

	/*
	 * public String getGsex() { return this.Gsex; }
	 * 
	 * public void setGsex(String gsex) { this.Gsex = gsex; }
	 */

	public int getLevel() {
		return this.level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getGimage() {
		return Gimage;
	}

	public void setGimage(String gimage) {
		Gimage = gimage;
	}

	public String getGtitle() {
		return Gtitle;
	}

	public void setGtitle(String gtitle) {
		Gtitle = gtitle;
	}

	
}
