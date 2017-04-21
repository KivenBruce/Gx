package com.gx.entity;

public class User {
	private int id;
	private String Gusername;
	private String Gpwd;
	private String Gmail;
	private String Gtel;
	private String GcreateTime;
	private String Gsex;
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
	
	
	
	public String getGsex() {
		return Gsex;
	}

	public void setGsex(String gsex) {
		Gsex = gsex;
	}

	/**
	 * 
	 */
	public User() {
		super();
	}

	/**
	 * @param id
	 * @param gusername
	 * @param gpwd
	 * @param gmail
	 * @param gtel
	 * @param gcreateTime
	 * @param level
	 * @param gimage
	 * @param gtitle
	 */
	public User(String gusername,String gmail, String gtel,String gsex,int level,String gimage, String gtitle) {
		super();
		Gusername = gusername;
		Gmail = gmail;
		Gtel = gtel;
		this.level = level;
		Gimage = gimage;
		Gtitle = gtitle;
		Gsex=gsex;
	}

	/**
	 * @param id
	 * @param gusername
	 * @param gpwd
	 * @param gmail
	 * @param gtel
	 * @param gcreateTime
	 * @param level
	 * @param gimage
	 * @param gtitle
	 */
	public User(int id, String gusername, String gpwd, String gmail, String gtel, String gcreateTime, int level,
			String gimage, String gtitle) {
		super();
		this.id = id;
		Gusername = gusername;
		Gpwd = gpwd;
		Gmail = gmail;
		Gtel = gtel;
		GcreateTime = gcreateTime;
		this.level = level;
		Gimage = gimage;
		Gtitle = gtitle;
	}
	
	
	
}
