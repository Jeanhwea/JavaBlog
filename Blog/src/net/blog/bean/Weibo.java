package net.blog.bean;

public class Weibo {
	String id;
	String user_name;
	String text;
	String date;
	int repost;
	int visual;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getRepost() {
		return repost;
	}
	public void setRepost(int repost) {
		this.repost = repost;
	}
	public int getVisual() {
		return visual;
	}
	public void setVisual(int visual) {
		this.visual = visual;
	}
}
