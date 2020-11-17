package com.danimar.irregularVerbsGame.data;

import java.util.Vector;

public class GameData {
	
	private Vector<String> espanol;
	private Vector<String> ingles1;
	private Vector<String> ingles2;
	private Vector<String> ingles3;

	public GameData() {
		espanol = new Vector<String>();
		ingles1 = new Vector<String>();
		ingles2 = new Vector<String>();
		ingles3 = new Vector<String>();
	}
	
	public Vector<String> getEspanol() {
		return espanol;
	}

	public Vector<String> getIngles1() {
		return ingles1;
	}
	public Vector<String> getIngles2() {
		return ingles2;
	}
	public Vector<String> getIngles3() {
		return ingles3;
	}

	public void addQuestion(String espanol, String ingles1, String ingles2, String ingles3) {
		this.espanol.add(espanol);
		this.ingles1.add(ingles1);
		this.ingles2.add(ingles2);
		this.ingles3.add(ingles3);
	}

}
