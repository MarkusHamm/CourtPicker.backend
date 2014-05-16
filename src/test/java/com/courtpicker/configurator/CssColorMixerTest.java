package com.courtpicker.configurator;

import org.junit.Test;

import static org.junit.Assert.*;

public class CssColorMixerTest {
    private CssColorMixer cssColorMixer;
    
    public CssColorMixerTest() {
        cssColorMixer = new CssColorMixer();
    }

    @Test
    public void modifyColorBrightness_makeColorBrighterWorks() {
        assertEquals("7AB8F5", cssColorMixer.modifyColorBrightness("69c", 0.2F));
    }

    @Test
    public void modifyColorBrightness_makeColorDarkerWorks() {
        assertEquals("334D66", cssColorMixer.modifyColorBrightness("69c", -0.5F));
    }
    
    @Test
    public void modifyColorBrightness_BrightestColorCannotBeMadeBrighter() {
        assertEquals("FFFFFF", cssColorMixer.modifyColorBrightness("FFFFFF", 0.5F));
    }

    @Test
    public void modifyColorBrightness_DarkestColorCannotBeMadeDarker() {
        assertEquals("000000", cssColorMixer.modifyColorBrightness("000000", -0.5F));
    }

    @Test
    public void modifyColorBrightness_ignoresCase() {
        assertEquals("6699CC", cssColorMixer.modifyColorBrightness("69c", 0F));
        assertEquals("6699CC", cssColorMixer.modifyColorBrightness("69C", 0F));
    }

    @Test
    public void modifyColorBrightness_ignoresHashPrefix() {
        assertEquals("6699CC", cssColorMixer.modifyColorBrightness("69c", 0F));
        assertEquals("6699CC", cssColorMixer.modifyColorBrightness("#69c", 0F));
    }

    @Test
    public void modifyColorBrightness_3or6digitInputPossible() {
        assertEquals("6699CC", cssColorMixer.modifyColorBrightness("6699cc", 0F));
        assertEquals("6699CC", cssColorMixer.modifyColorBrightness("69c", 0F));
    }
    
    @Test
    public void modifyColorBrightness_zeroLuminanceDoesNotModifyColor() {
        assertEquals("6699CC", cssColorMixer.modifyColorBrightness("69C", 0F));
    }    
    
    @Test
    public void modifyColorSaturation_zeroFactorReturnsSameColor() {
        assertEquals("661567", cssColorMixer.modifyColorSaturation("#661567", 0F));
    }
    
    @Test
    public void modifyColorSaturation_reducingFactorWorksAsExpected() {
        assertEquals("673E67", cssColorMixer.modifyColorSaturation("#661567", -0.5F));
    }

    @Test
    public void modifyColorSaturation_increasingFactorWorksAsExpected() {
        assertEquals("660D67", cssColorMixer.modifyColorSaturation("#661567", 0.1F));
    }
    
    @Test
    public void modifyColorSaturation_MaximumSaturationCannotBeIncreased() {
        assertEquals("660067", cssColorMixer.modifyColorSaturation("#660067", 0.5F));
    }

    @Test
    public void modifyColorSaturation_MinimumSaturationCannotBeDecreased() {
        assertEquals("676767", cssColorMixer.modifyColorSaturation("#676767", -0.5F));
    }
}
