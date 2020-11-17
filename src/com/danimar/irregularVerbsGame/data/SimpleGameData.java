package com.danimar.irregularVerbsGame.data;

import java.util.Vector;

public class SimpleGameData {
	
	private Vector<String> espanol;
	private Vector<String> ingles;

	public SimpleGameData() {
		espanol = new Vector<String>();
		ingles = new Vector<String>();
	}
	
	public Vector<String> getEspanol() {
		return espanol;
	}

	public Vector<String> getIngles() {
		return ingles;
	}

	public void addQuestion(String espanol, String ingles) {
		this.espanol.add(espanol);
		this.ingles.add(ingles);
	}

}
