package com.danimar.irregularVerbsGame.parser;

import java.io.IOException;
import java.io.Reader;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.danimar.irregularVerbsGame.data.GameData;

public class GameDataParser {
	
	private GameDataParser() {
	}
	
	public static GameData parse(Reader in) throws IOException, ParseException {
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(in);
		
		String gameDataType = (String) jsonObject.get("gameDataType");
		if (!"GameData".equals(gameDataType)) {
			throw new IOException("Incorrect game data type. Found='" + gameDataType + "'");
		}
		
		GameData gameData = new GameData();
		
		JSONArray questionList = (JSONArray) jsonObject.get("questionList");
		for (int i=0; i<questionList.size(); i++) {
			JSONObject question = (JSONObject)questionList.get(i);
			
			String esp = (String) question.get("esp");
			String ing1 = (String) question.get("ing1");
			String ing2 = (String) question.get("ing2");
			String ing3 = (String) question.get("ing3");
			
			gameData.addQuestion(esp, ing1, ing2, ing3);
		}
		
		return gameData;
	}

}
