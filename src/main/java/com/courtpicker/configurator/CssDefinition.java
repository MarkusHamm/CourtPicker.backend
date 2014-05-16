package com.courtpicker.configurator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CssDefinition {    
    private Map<String, List<String>> definitions;
    
    public CssDefinition() {
        definitions = new HashMap<String, List<String>>();
    }
    
    public void add(String key, String value) {
        List<String> valueList;
        valueList = definitions.get(key);
        
        if (valueList == null) {
            valueList = new ArrayList<String>();
        }
        
        valueList.add(value);        
        definitions.put(key, valueList);
    }
    
    public List<String> get(String key) {
        return definitions.get(key);
    }
    
    public Map<String, List<String>> getAll() {
        return definitions;
    }
    
    public void remove(String key) {
        definitions.remove(key);
    }
    
    public String getStringRepresentation() {
        String result = "";
        
        for(String key : definitions.keySet()) {
            for (String value : definitions.get(key)) {
                result += key + ": " + value + ";\r\n";
            }
        }

        return result;
    }
}
