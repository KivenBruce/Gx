package com.gx.entity;

public class Club {
	private int id;
	private String club_name;
	private int club_id;
	private int user_id;
	private int isfocus;
	private int gflag;
	private String club_parent;
	private int parent_id;
	private String club_image;
	private String club_desc;
	private String club_hoster;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getClub_name() {
		return club_name;
	}

	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}

	public int getClub_id() {
		return club_id;
	}

	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getIsfocus() {
		return isfocus;
	}

	public void setIsfocus(int isfocus) {
		this.isfocus = isfocus;
	}

	public int getGflag() {
		return gflag;
	}

	public void setGflag(int gflag) {
		this.gflag = gflag;
	}

	public String getClub_parent() {
		return club_parent;
	}

	public void setClub_parent(String club_parent) {
		this.club_parent = club_parent;
	}

	public int getParent_id() {
		return parent_id;
	}

	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}



	public String getClub_image() {
		return club_image;
	}

	public void setClub_image(String club_image) {
		this.club_image = club_image;
	}

	

	public String getClub_desc() {
		return club_desc;
	}

	public void setClub_desc(String club_desc) {
		this.club_desc = club_desc;
	}

	public String getClub_hoster() {
		return club_hoster;
	}

	public void setClub_hoster(String club_hoster) {
		this.club_hoster = club_hoster;
	}
	
	public Club() {
	}

	public Club(String club_name, int club_id, int gflag, String club_parent,int parent_id, String club_image,
			String club_desc, String club_hoster) {
		super();
		this.club_name = club_name;
		this.club_id = club_id;
		this.gflag = gflag;
		this.club_parent = club_parent;
		this.parent_id=parent_id;
		this.club_image = club_image;
		this.club_desc = club_desc;
		this.club_hoster = club_hoster;
	}

	public Club(int id, String club_name, int club_id, int user_id, int isfocus, int gflag, String club_parent,
			int parent_id, String club_image, String club_desc, String club_hoster) {
		super();
		this.id = id;
		this.club_name = club_name;
		this.club_id = club_id;
		this.user_id = user_id;
		this.isfocus = isfocus;
		this.gflag = gflag;
		this.club_parent = club_parent;
		this.parent_id = parent_id;
		this.club_image = club_image;
		this.club_desc = club_desc;
		this.club_hoster = club_hoster;
	}
	
	
	
}
