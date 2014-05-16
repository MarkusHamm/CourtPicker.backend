package com.courtpicker.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.courtpicker.dao.WebdesignDAO;
import com.courtpicker.dao.WebdesignFileDAO;
import com.courtpicker.model.Webdesign;
import com.courtpicker.model.WebdesignFile;
import com.courtpicker.tools.FileHandler;

@Controller
public class FileUploadController {
    @Inject
    private WebdesignFileDAO webdesignFileDAO;
    @Inject
    private FileHandler fileHandler;
    
    @RequestMapping("upload/webdesignfile")
    public @ResponseBody String uploadWebdesignFile(HttpServletRequest request, HttpServletResponse response,
            @RequestParam("logowebdesignid") Integer webdesignId, @RequestParam("logotype") String type, 
            @RequestParam("logofile") MultipartFile file) 
                    throws IOException {
        WebdesignFile webdesignFile = saveWebdesignFileToDb(webdesignId, type, file);
        //String servletPath = saveWebdesignFileToServerDisk(request, file, webdesignFile);        
        String base64EncodedFileContent = new String(Base64.encodeBase64(webdesignFile.getContent()));
        
        return base64EncodedFileContent;
    }

    private WebdesignFile saveWebdesignFileToDb(Integer webdesignId, String type, MultipartFile file)
            throws IOException {
        WebdesignFile webdesignFile = webdesignFileDAO.getWebdesignFile(webdesignId, type);
        if (webdesignFile == null) {
            webdesignFile = new WebdesignFile();
            webdesignFile.setWebdesignId(webdesignId);
            webdesignFile.setType(type);
        }
        webdesignFile.setContent(file.getBytes());
        
        webdesignFile = webdesignFileDAO.persist(webdesignFile);
        
        return webdesignFile;
    }
    
    private String saveWebdesignFileToServerDisk(HttpServletRequest request, MultipartFile file,
            WebdesignFile webdesignFile) throws IOException {
        Integer cpInstanceId = (Integer) request.getSession().getAttribute("cpInstanceId");
        String serverfileName = cpInstanceId + "-" + webdesignFile.getType() + "." + getFileExtension(file.getOriginalFilename()).toLowerCase();
        String servletPath = "/resources/css/instance/images/" + serverfileName;
        String serverPath = getServerPath(servletPath, request);
        fileHandler.writeByteArrayToFile(serverPath, webdesignFile.getContent());
        
        return servletPath;
    }
    
    private String getFileExtension(String fileName) {
        String extension = "";

        int i = fileName.lastIndexOf('.');
        if (i > 0) {
            extension = fileName.substring(i+1);
        }
        
        return extension;
    }
    
    private String getServerPath(String servletPath, HttpServletRequest request) {
        HttpSession session = request.getSession();      
        ServletContext sc = session.getServletContext();
        String realPath = sc.getRealPath(servletPath);

        return realPath;
    }
}
