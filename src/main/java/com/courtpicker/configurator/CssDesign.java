package com.courtpicker.configurator;

import java.util.LinkedHashMap;
import java.util.Map;

public class CssDesign {
    private Map<String, CssDefinition> cssDefinitions;

    public CssDesign() {
        this.cssDefinitions = new LinkedHashMap<String, CssDefinition>();
    }

    public void put(String identifier, CssDefinition cssDef) {
        cssDefinitions.put(identifier, cssDef);
    }

    public CssDefinition get(String identifier) {
        return cssDefinitions.get(identifier);
    }

    public void remove(String identifier) {
        cssDefinitions.remove(identifier);
    }

    public String getStringRepresentation() {
        String stringRep = "";

        for (String key : cssDefinitions.keySet()) {
            CssDefinition cssDef = cssDefinitions.get(key);
            stringRep += key + " {\r\n" + cssDef.getStringRepresentation() + "}\r\n";
        }

        return stringRep;
    }
}
