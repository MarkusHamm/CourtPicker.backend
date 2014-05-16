package com.courtpicker.model;

public class Webdesign {
    private Integer id;
    private Integer cpInstanceId;
    private String backgroundStyle;
    private String backgroundColor;
    private String headerColor;
    private String headerBackgroundColor;
    private String controlsColor;
    private String controlsTextColor;
    private String contentColor;
    private String contentBackgroundColor;
    private String ctSelectColor;
    private String ctSelectBackgroundColor;
    private String ctSelectFocusColor;
    private String linkColor;
    private String reservableHourColor;
    private String nonReservableHourColor;
    private String footerColor;

    public Webdesign() {
        this.id = null;
        this.cpInstanceId = null;
        this.backgroundStyle = "";
        this.backgroundColor = "";
        this.headerColor = "";
        this.headerBackgroundColor = "";
        this.controlsColor = "";
        this.controlsTextColor = "";
        this.contentColor = "";
        this.contentBackgroundColor = "";
        this.ctSelectColor = "";
        this.ctSelectBackgroundColor = "";
        this.ctSelectFocusColor = "";
        this.linkColor = "";
        this.reservableHourColor = "";
        this.nonReservableHourColor = "";
        this.footerColor = "";
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCpInstanceId() {
        return cpInstanceId;
    }

    public void setCpInstanceId(Integer cpInstanceId) {
        this.cpInstanceId = cpInstanceId;
    }

    public String getBackgroundStyle() {
        return backgroundStyle;
    }

    public void setBackgroundStyle(String backgroundStyle) {
        this.backgroundStyle = backgroundStyle;
    }

    public String getBackgroundColor() {
        return backgroundColor;
    }

    public void setBackgroundColor(String backgroundColor) {
        this.backgroundColor = backgroundColor;
    }

    public String getHeaderColor() {
        return headerColor;
    }

    public void setHeaderColor(String headerColor) {
        this.headerColor = headerColor;
    }

    public String getHeaderBackgroundColor() {
        return headerBackgroundColor;
    }

    public void setHeaderBackgroundColor(String headerBackgroundColor) {
        this.headerBackgroundColor = headerBackgroundColor;
    }

    public String getControlsColor() {
        return controlsColor;
    }

    public void setControlsColor(String controlsColor) {
        this.controlsColor = controlsColor;
    }
    
    public String getContentColor() {
        return contentColor;
    }

    public void setContentColor(String contentColor) {
        this.contentColor = contentColor;
    }

    public String getContentBackgroundColor() {
        return contentBackgroundColor;
    }

    public void setContentBackgroundColor(String contentBackgroundColor) {
        this.contentBackgroundColor = contentBackgroundColor;
    }

    public String getCtSelectColor() {
        return ctSelectColor;
    }

    public void setCtSelectColor(String ctSelectColor) {
        this.ctSelectColor = ctSelectColor;
    }
    
    public String getCtSelectBackgroundColor() {
        return ctSelectBackgroundColor;
    }

    public void setCtSelectBackgroundColor(String ctSelectBackgroundColor) {
        this.ctSelectBackgroundColor = ctSelectBackgroundColor;
    }
    
    public String getCtSelectFocusColor() {
        return ctSelectFocusColor;
    }

    public void setCtSelectFocusColor(String ctSelectFocusColor) {
        this.ctSelectFocusColor = ctSelectFocusColor;
    }

    public String getLinkColor() {
        return linkColor;
    }

    public void setLinkColor(String linkColor) {
        this.linkColor = linkColor;
    }

    public String getReservableHourColor() {
        return reservableHourColor;
    }

    public void setReservableHourColor(String reservableHourColor) {
        this.reservableHourColor = reservableHourColor;
    }

    public String getNonReservableHourColor() {
        return nonReservableHourColor;
    }

    public void setNonReservableHourColor(String nonReservableHourColor) {
        this.nonReservableHourColor = nonReservableHourColor;
    }

    public String getFooterColor() {
        return footerColor;
    }

    public void setFooterColor(String footerColor) {
        this.footerColor = footerColor;
    }

    public String getControlsTextColor() {
        return controlsTextColor;
    }

    public void setControlsTextColor(String controlsTextColor) {
        this.controlsTextColor = controlsTextColor;
    }
}
