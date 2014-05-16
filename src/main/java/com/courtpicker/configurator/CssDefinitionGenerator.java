package com.courtpicker.configurator;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("cssDefinitionGenerator")
@Scope("singleton")
public class CssDefinitionGenerator {
    @Inject
    private CssColorMixer colorMixer;
    
    /**
     * Method responsible to generate css for visualize a gradient.
     * 
     * @param baseColorHex A hex color value such as "abc" or "123456"
     * @return The whole css definition required to visualize this gradient
     */
    public CssDefinition createGradient(String baseColorHex) {
        String contrastColour = colorMixer.modifyColorBrightness(baseColorHex, 0.2F);
        
        CssDefinition cssDef = new CssDefinition();
        // fallback
        cssDef.add("background-color", "#" + baseColorHex);
        // gradient for different browser
        cssDef.add("background", "-moz-linear-gradient(top, #" + contrastColour + " 0%, #" + baseColorHex + " 50%)");
        cssDef.add("background", "-webkit-linear-gradient(top, #" + contrastColour + " 0%, #" + baseColorHex + " 50%)");
        cssDef.add("background", "-o-linear-gradient(top, #" + contrastColour + " 0%, #" + baseColorHex + " 50%)");
        cssDef.add("background", "-ms-linear-gradient(top, #" + contrastColour + " 0%, #" + baseColorHex + " 50%)");
        
        return cssDef;
    }

    public CssColorMixer getColorMixer() {
        return colorMixer;
    }

    public void setColorMixer(CssColorMixer colorMixer) {
        this.colorMixer = colorMixer;
    }
}
