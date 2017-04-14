package com.gx.club.domain;

public class Club {
	private int id;
	private String club_name;
	private int club_id;
	private int user_id;
	private int isfocus;
	private int gflag;
	private String club_parent;
	private int parent_id;
	private int comment_count;
	private int like_count;
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

	public int getComment_count() {
		return comment_count;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}

	public int getLike_count() {
		return like_count;
	}

	public void setLike_count(int like_count) {
		this.like_count = like_count;
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
	
	
}
