package net.blog.bean;

public class Diary {

  String id;
  String name;
  String title;
  String text;
  String date;
  boolean repost;
  boolean visual;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
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

  public boolean isRepost() {
    return repost;
  }

  public void setRepost(boolean repost) {
    this.repost = repost;
  }

  public boolean isVisual() {
    return visual;
  }

  public void setVisual(boolean visual) {
    this.visual = visual;
  }
}
