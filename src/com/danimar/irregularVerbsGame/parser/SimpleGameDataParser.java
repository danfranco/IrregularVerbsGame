package com.danimar.irregularVerbsGame.parser;

import java.io.IOException;
import java.io.Reader;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.danimar.irregularVerbsGame.data.SimpleGameData;

public class SimpleGameDataParser {
	
	private SimpleGameDataParser() {
	}
	
	public static SimpleGameData parse(Reader in) throws IOException, ParseException {
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(in);
		
		String gameDataType = (String) jsonObject.get("gameDataType");
		if (!"SimpleGameData".equals(gameDataType)) {
			throw new IOException("Incorrect game data type. Found='" + gameDataType + "'");
		}
		
		SimpleGameData gameData = new SimpleGameData();
		
		JSONArray questionList = (JSONArray) jsonObject.get("questionList");
		for (int i=0; i<questionList.size(); i++) {
			JSONObject question = (JSONObject)questionList.get(i);
			
			String esp = (String) question.get("esp");
			String ing = (String) question.get("ing");
			
			gameData.addQuestion(esp, ing);
		}
		
		return gameData;
	}

}
