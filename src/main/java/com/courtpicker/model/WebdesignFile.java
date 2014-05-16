package com.courtpicker.model;

public class WebdesignFile {
    private Integer id;
    private Integer webdesignId;
    private String type;
    private byte[] content;

    public WebdesignFile() {
        this.id = null;
        this.webdesignId = null;
        this.type = "";
        this.content = "".getBytes();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getWebdesignId() {
        return webdesignId;
    }

    public void setWebdesignId(Integer webdesignId) {
        this.webdesignId = webdesignId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public byte[] getContent() {
        return content;
    }

    public void setContent(byte[] content) {
        this.content = content;
    }
}
