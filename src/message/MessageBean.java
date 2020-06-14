package message;

import java.sql.Timestamp;

public class MessageBean {

	private int num;
	private String send_id;
	private String receive_id;
	private String subject;
	private String content;
	private Timestamp date;
	private int send_del;
	private int receive_del;
	private int send_read;
	private int receive_read;
	
	
	public int getSend_del() {
		return send_del;
	}
	public void setSend_del(int send_del) {
		this.send_del = send_del;
	}
	public int getReceive_del() {
		return receive_del;
	}
	public void setReceive_del(int receive_del) {
		this.receive_del = receive_del;
	}
	public int getSend_read() {
		return send_read;
	}
	public void setSend_read(int send_read) {
		this.send_read = send_read;
	}
	public int getReceive_read() {
		return receive_read;
	}
	public void setReceive_read(int receive_read) {
		this.receive_read = receive_read;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getReceive_id() {
		return receive_id;
	}
	public void setReceive_id(String receive_id) {
		this.receive_id = receive_id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	
}
