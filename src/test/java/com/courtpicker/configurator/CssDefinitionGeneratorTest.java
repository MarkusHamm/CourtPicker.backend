package com.courtpicker.configurator;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.junit.Test;

public class CssDefinitionGeneratorTest {
    @Test
    public void createGradient_returnCorrectResult() {
        CssDefinitionGenerator cssGen = new CssDefinitionGenerator();
        
        CssColorMixer colorMixer = mock(CssColorMixer.class);
        when(colorMixer.modifyColorBrightness("999", 0.2F)).thenReturn("AAAAAA");
        cssGen.setColorMixer(colorMixer);
        
        CssDefinition cssDef = cssGen.createGradient("999");
        assertTrue(cssDef.get("background-color").contains("#999"));
        assertTrue(cssDef.get("background").contains("-moz-linear-gradient(top, #AAAAAA 0%, #999 50%)"));
        assertTrue(cssDef.get("background").contains("-webkit-linear-gradient(top, #AAAAAA 0%, #999 50%)"));
        assertTrue(cssDef.get("background").contains("-o-linear-gradient(top, #AAAAAA 0%, #999 50%)"));
        assertTrue(cssDef.get("background").contains("-ms-linear-gradient(top, #AAAAAA 0%, #999 50%)"));
    }
}
