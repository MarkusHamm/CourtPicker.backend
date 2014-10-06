package com.courtpicker.configurator;

import org.junit.Test;
import static org.junit.Assert.*;

public class CssDefinitionTest {
    
    @Test
    public void getStringRepresentation_noDefinitionReturnsEmptyString() {
        CssDefinition cssDef = new CssDefinition();
        String stringRep = cssDef.getStringRepresentation();
        
        assertEquals("", stringRep);
    }
    
    @Test
    public void getStringRepresentation_severalDefinitionsReturnCorrectRepresentation() {
        CssDefinition cssDef = new CssDefinition();
        cssDef.add("background-color", "#ffffff");
        cssDef.add("background-color", "#000000");
        cssDef.add("margin", "0 auto");
        cssDef.add("padding", "10");
        cssDef.add("padding", "20");
        cssDef.add("border", "2px solid #ffffff");
        cssDef.remove("padding");
        String stringRep = cssDef.getStringRepresentation();
        
        String expectedResult = 
                "background-color: #ffffff;\r\n" + 
                "background-color: #000000;\r\n" +
                "margin: 0 auto;\r\n" +
                "border: 2px solid #ffffff;\r\n";
        assertEquals(expectedResult, stringRep);
    }
    
    @Test
    public void getStringRepresentationImportant_severalDefinitionsReturnCorrectRepresentation() {
        CssDefinition cssDef = new CssDefinition();
        cssDef.add("background-color", "#ffffff");
        cssDef.add("background-color", "#000000");
        cssDef.add("margin", "0 auto");
        cssDef.add("padding", "10");
        cssDef.add("padding", "20");
        cssDef.add("border", "2px solid #ffffff");
        cssDef.remove("padding");
        String stringRep = cssDef.getStringRepresentationImportant();
        
        String expectedResult = 
                "background-color: #ffffff !important;\r\n" + 
                "background-color: #000000 !important;\r\n" +
                "margin: 0 auto !important;\r\n" +
                "border: 2px solid #ffffff !important;\r\n";
        assertEquals(expectedResult, stringRep);
    }
}
