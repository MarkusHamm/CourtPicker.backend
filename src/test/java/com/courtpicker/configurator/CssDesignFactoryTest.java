package com.courtpicker.configurator;

import org.junit.Test;
import static org.junit.Assert.*;

import com.courtpicker.model.Webdesign;

public class CssDesignFactoryTest {
    @Test
    public void create_exampleWebdesignJustConverted() {
        Webdesign webdesign = new Webdesign();
        webdesign.setBackgroundStyle("SOLID");
        webdesign.setBackgroundColor("FFFFFF");
        webdesign.setHeaderBackgroundColor("BBBBBB");
        webdesign.setHeaderColor("FFFFFF");
        webdesign.setControlsColor("BBBBBB");
        webdesign.setLinkColor("#FFFFFF");
        webdesign.setCtSelectBackgroundColor("#FFFFFF");
        
        CssColorMixer cssColorMixer = new CssColorMixer();
        CssDefinitionGenerator cssDefinitionGenerator = new CssDefinitionGenerator();
        cssDefinitionGenerator.setColorMixer(cssColorMixer);
        CssDesignFactory factory = new CssDesignFactory();
        factory.setCssColorMixer(cssColorMixer);
        factory.setCssDefinitionGenerator(cssDefinitionGenerator);
        
        CssDesign cssDesign = factory.create(webdesign);
        
        assertNotNull(cssDesign.get("body"));
        assertNotNull(cssDesign.get("#header"));
        assertNotNull(cssDesign.get("#headerText h1"));
        assertNotNull(cssDesign.get(".button"));
    }
}
