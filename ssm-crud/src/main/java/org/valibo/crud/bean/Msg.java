package org.valibo.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
	private int code;
	private String msg;
	private Map<String, Object> map = new HashMap<String, Object>();

	public static Msg success() {
		return Msg.success("");
	}
	
	public static Msg success(String msg) {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg(msg);

		return result;
	}
	public static Msg fail(String msg) {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg(msg);
		return result;
	}
	public static Msg fail() {
		return Msg.fail("");
	}
	
	public Msg add(String key,Object value){
		this.map.put(key, value);
		return this;
	}
	
	/*get or set */

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
}
