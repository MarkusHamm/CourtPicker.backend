package com.courtpicker.configurator;

import org.junit.Test;
import static org.junit.Assert.*;

import static org.mockito.Mockito.*;

public class CssDesignTest {
    @Test
    public void getStringRepresentation_noDefinitionReturnsEmptyString() {
        CssDesign cssDesign = new CssDesign();
        String stringRep = cssDesign.getStringRepresentation();
        
        assertEquals("", stringRep);
    }
    
    @Test
    public void getStringRepresentation_severalDefinitionsReturnCorrectRepresentation() {
        CssDefinition emptyCssDef = mock(CssDefinition.class);
        when(emptyCssDef.getStringRepresentation()).thenReturn("");
        CssDefinition filledCssDef = mock(CssDefinition.class);
        when(filledCssDef.getStringRepresentation()).thenReturn("border: 10px;\r\nmargin: 0 auto;\r\n");
        
        CssDesign cssDesign = new CssDesign();
        cssDesign.put("#header", emptyCssDef);
        cssDesign.put(".div", filledCssDef);
        cssDesign.put(".test", filledCssDef);
        cssDesign.remove(".test");
        
        String expectedResult = "#header {\r\n" +
                                "}\r\n" +
                                ".div {\r\n" +
                                "border: 10px;\r\nmargin: 0 auto;\r\n" +
                                "}\r\n";
        assertEquals(expectedResult, cssDesign.getStringRepresentation());
    }
}
