package com.courtpicker.configurator;

import java.awt.Color;
import java.util.regex.Pattern;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("cssColorMixer")
@Scope("singleton")
public class CssColorMixer {
    /**
     * Method responsible for modifying the brightness of a given color
     * 
     * @param baseColorHex A hex color value such as "#abc" or "#123456" (the hash is optional)
     * @param luminance The luminosity factor, i.e. -0.1 is 10% darker, 0.2 is 20% lighter, etc.
     * @return Modified/luminanced hex color (upper case, without # prefix)
     */
    public String modifyColorBrightness(String baseColorHex, Float luminance) {
        baseColorHex = standardizeHexColorString(baseColorHex);
        
        if (luminance == null || luminance > 1 || luminance < -1) {
            luminance = 0F;
        }
        
        // convert to decimal and change luminosity
        String rgb = "";
        int c, i;
        for (i = 0; i < 3; i++) {
            c = Integer.parseInt(baseColorHex.substring(i*2,i*2+2), 16);
            c = Math.round(Math.min(Math.max(0, c + (c * luminance)), 255));
            rgb += String.format("%02X", c);
        }
        
        return rgb;
    }
    
    /**
     * Method responsible for modifying the saturation of a given color.
     * 
     * @param baseColorHex A hex color value such as "#abc" or "#123456" (the hash is optional)
     * @param saturationFactor The brightness factor, i.e. -0.1 is 10% darker, 0.2 is 20% lighter, etc.
     * @return Modified/saturated hex color (upper case, without # prefix)
     */
    public String modifyColorSaturation(String baseColorHex, Float saturationFactor) {
        String standardizedBaseColorHex = standardizeHexColorString(baseColorHex);
        Color color = getRGBColor(standardizedBaseColorHex);
        Color saturatedColor = calculateColorSaturation(saturationFactor, color);
        String modifiedColorHex = getHexString(saturatedColor);
        
        return modifiedColorHex;
    }

    private String getHexString(Color color) {
        return String.format("%02X%02X%02X", color.getRed(), color.getGreen(), color.getBlue());
    }

    private Color calculateColorSaturation(Float saturationFactor, Color color) {
        float[] hsbVals = Color.RGBtoHSB(color.getRed(), color.getGreen(), color.getBlue(), null);
        float hue = hsbVals[0];
        float saturation = hsbVals[1];
        float brightness = hsbVals[2];
        
        saturation = saturation + (saturation * saturationFactor);
        saturation = Math.min(saturation, 1F);
        saturation = Math.max(saturation, 0F);
        
        return Color.getHSBColor(hue, saturation, brightness);
    }
    
    private String standardizeHexColorString(String hexColorString) {
        String standardizedHexColor = hexColorString.replaceAll("(?i)[^0-9a-f]", "");
        if (standardizedHexColor.length() < 6) {
            standardizedHexColor = transform3DigitHexTo6DigitHex(standardizedHexColor);
        }

        return standardizedHexColor.toUpperCase();
    }

    private String transform3DigitHexTo6DigitHex(String threeDigitHexColor) {
        String sixDigitHexColor = "" + threeDigitHexColor.charAt(0) + threeDigitHexColor.charAt(0)
                                     + threeDigitHexColor.charAt(1) + threeDigitHexColor.charAt(1)
                                     + threeDigitHexColor.charAt(2) + threeDigitHexColor.charAt(2);
        return sixDigitHexColor;
    }
    
    private Color getRGBColor(String hexColor) {
        int red = Integer.parseInt(hexColor.substring(0,2), 16);
        int green = Integer.parseInt(hexColor.substring(2,4), 16);
        int blue = Integer.parseInt(hexColor.substring(4,6), 16);

        Color rgbColor = new Color(red, green, blue);
        return rgbColor;
    }
    
}
