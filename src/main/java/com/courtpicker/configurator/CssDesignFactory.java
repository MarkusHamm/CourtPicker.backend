package com.courtpicker.configurator;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Webdesign;

@Component("cssDesignFactory")
@Scope("singleton")
public class CssDesignFactory {
    @Inject
    private CssColorMixer cssColorMixer;
    @Inject
    private CssDefinitionGenerator cssDefinitionGenerator;
    
    public CssDesignFactory() {
    }
    
    public CssDesign create(Webdesign webdesign) {
        CssDesign cssdesign = new CssDesign();
        addGeneralDesign(webdesign, cssdesign);
        addHeaderDesign(webdesign, cssdesign);
        addControlsDesign(webdesign, cssdesign);
        addContentDesign(webdesign, cssdesign);
        addCourtTypeSelectDesign(webdesign, cssdesign);
        
        return cssdesign;
    }
    
    private void addGeneralDesign(Webdesign webdesign, CssDesign cssdesign) {
        CssDefinition cssDefBody = new CssDefinition();
        
        if (webdesign.getBackgroundStyle().equals("SOLID")) {
            cssDefBody.add("background", "none repeat scroll 0 0 #" + webdesign.getBackgroundColor());
        }
        else {
            cssDefBody.add("background", "url(\"/courtpicker/resources/css/images/texturedBackground.jpg\") repeat scroll 0 -20px #FFFFFF");
        }        
        cssdesign.put("body", cssDefBody);
        
        String linkColor = webdesign.getLinkColor();
        String linkHoverColor = cssColorMixer.modifyColorBrightness(linkColor, 0.22F);
        linkHoverColor = cssColorMixer.modifyColorSaturation(linkHoverColor, -0.14F);

        CssDefinition linkCssDef = new CssDefinition();
        linkCssDef.add("color", "#" + linkColor);
        cssdesign.put("a:link, a:visited", linkCssDef);
     
        CssDefinition linkHoverCssDef = new CssDefinition();
        linkHoverCssDef.add("color", "#" + linkHoverColor);
        cssdesign.put("a:hover", linkHoverCssDef);
        
        CssDefinition footerCssDef = new CssDefinition();
        footerCssDef.add("color", "#" + webdesign.getFooterColor());
        cssdesign.put("#footer", footerCssDef);
    }
    
    private void addHeaderDesign(Webdesign webdesign, CssDesign cssdesign) {
        CssDefinition cssColorDef = new CssDefinition();
        cssColorDef.add("color", "#" + webdesign.getHeaderColor());
        cssdesign.put("#headerText h1", cssColorDef);
        cssdesign.put("#headerContent", cssColorDef);
                
        CssDefinition cssBgColorDef = new CssDefinition();
        cssBgColorDef.add("background-color", "#" + webdesign.getHeaderBackgroundColor());
        cssdesign.put("#header", cssBgColorDef);
        
        CssDefinition cssContentColors = new CssDefinition();
        cssContentColors.add("background-color", "#" + webdesign.getContentBackgroundColor());
        cssContentColors.add("color", "#" + webdesign.getContentColor());
        cssdesign.put("#loginmenu", cssContentColors);
        cssdesign.put("#loginmenu h2", cssContentColors);
        cssdesign.put("#forgotpasswordmenu", cssContentColors);
        cssdesign.put("#forgotpasswordmenu h2", cssContentColors);
    }
    
    private void addControlsDesign(Webdesign webdesign, CssDesign cssdesign) {
        String baseColor = webdesign.getControlsColor();

        String secondaryColor = cssColorMixer.modifyColorBrightness(baseColor, 0.22F);
        secondaryColor = cssColorMixer.modifyColorSaturation(secondaryColor, -0.14F);

        String contrastColor = cssColorMixer.modifyColorBrightness(baseColor, 0.9F);
        contrastColor = cssColorMixer.modifyColorSaturation(contrastColor, -0.6F);
                
        CssDefinition buttonCssDef = cssDefinitionGenerator.createGradient(baseColor);
        buttonCssDef.add("color", "#" + webdesign.getControlsTextColor());
        cssdesign.put(".button", buttonCssDef);
        cssdesign.put(".buttonThinRound", buttonCssDef);
        
        CssDefinition buttonHoverCssDef = new CssDefinition();
        buttonHoverCssDef.add("background-color", "#" + baseColor);
        buttonHoverCssDef.add("background-image", "none");
        buttonHoverCssDef.add("color", "#" + webdesign.getControlsTextColor());
        cssdesign.put(".button:hover:enabled", buttonHoverCssDef);
        cssdesign.put(".buttonThinRound:hover:enabled", buttonHoverCssDef);       
        
        CssDefinition lightOptionDefaultCssDef = new CssDefinition();
        lightOptionDefaultCssDef.add("background-color", "#" + contrastColor);
        lightOptionDefaultCssDef.add("color", "#" + webdesign.getControlsTextColor());
        cssdesign.put(".buttonLight", lightOptionDefaultCssDef);
        
        CssDefinition lightOptionActiveCssDef = new CssDefinition();
        lightOptionActiveCssDef.add("background-color", "#" + baseColor);
        lightOptionActiveCssDef.add("color", "#" + webdesign.getControlsTextColor());
        cssdesign.put(".buttonLightSelected", lightOptionActiveCssDef);
        cssdesign.put(".buttonLight:hover:enabled", lightOptionActiveCssDef);
        
        CssDefinition inputBorderCssDef = new CssDefinition();
        inputBorderCssDef.add("border", "1px solid #" + baseColor);
        cssdesign.put("input[type=\"text\"]:focus, input[type=\"password\"]:focus", inputBorderCssDef);
                
        CssDefinition h3CssDef = new CssDefinition();
        h3CssDef.add("color", "#" + secondaryColor);
        cssdesign.put("h3", h3CssDef);

        CssDefinition h4CssDef = new CssDefinition();
        h4CssDef.add("color", "#" + secondaryColor);
        cssdesign.put("h4", h4CssDef);
    }
    
    private void addContentDesign(Webdesign webdesign, CssDesign cssdesign) {
        CssDefinition ctCssDef = new CssDefinition();
        ctCssDef.add("background-color", "#" + webdesign.getContentBackgroundColor());
        ctCssDef.add("color", "#" + webdesign.getContentColor());
        cssdesign.put("#mainframe", ctCssDef);
        
        CssDefinition resHourCssDef = new CssDefinition();
        resHourCssDef.add("background-color", "#" +  webdesign.getReservableHourColor());
        cssdesign.put(".notreserved-color", resHourCssDef);
        cssdesign.put(".timeslot-spacer-two-reservable", resHourCssDef);
        
        CssDefinition resHourHoverCssDef = new CssDefinition();
        String brightenedReservableColor = cssColorMixer.modifyColorBrightness(webdesign.getReservableHourColor(), 0.1F);
        resHourHoverCssDef.add("background-color", "#" + brightenedReservableColor);
        resHourHoverCssDef.add("box-shadow", "0 0 4px #" + brightenedReservableColor);
        cssdesign.put(".notreserved-color-clickable:hover", resHourHoverCssDef);
        
        /*
        CssDefinition nonResHourCssDef = new CssDefinition();
        nonResHourCssDef.add("background-color", "#" + webdesign.getNonReservableHourColor());
        cssdesign.put(".past-color", nonResHourCssDef);
        */
        
        cssdesign.put(".cpModal .modal-content", ctCssDef);
        cssdesign.put(".cpModal .modal-content h2", ctCssDef);
    }
    
    private void addCourtTypeSelectDesign(Webdesign webdesign, CssDesign cssdesign) {
        CssDefinition ctCssDef = cssDefinitionGenerator.createGradient(webdesign.getCtSelectBackgroundColor());
        ctCssDef.add("color", "#" + webdesign.getCtSelectColor());
        cssdesign.put("#courtTypeSelect", ctCssDef);
        
        CssDefinition selectedCourtTypeCssDef = new CssDefinition();
        selectedCourtTypeCssDef.add("color", "#" + webdesign.getCtSelectFocusColor());
        cssdesign.put(".selectedCourtType", selectedCourtTypeCssDef);
        cssdesign.put("#courtTypeSelect ul li:hover", selectedCourtTypeCssDef);
    }
    
    public CssColorMixer getCssColorMixer() {
        return cssColorMixer;
    }

    public void setCssColorMixer(CssColorMixer cssColorMixer) {
        this.cssColorMixer = cssColorMixer;
    }

    public CssDefinitionGenerator getCssDefinitionGenerator() {
        return cssDefinitionGenerator;
    }

    public void setCssDefinitionGenerator(CssDefinitionGenerator cssDefinitionGenerator) {
        this.cssDefinitionGenerator = cssDefinitionGenerator;
    }
}
