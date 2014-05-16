package com.courtpicker.tools;

import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("fileHandler")
@Scope("singleton")
public class FileHandler {
    public void writeStringToFile(String filePath, String fileContent) throws IOException {
        BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath), "UTF-8"));
        out.write(fileContent);
        out.close();
    }
    
    public void writeByteArrayToFile(String filePath, byte[] fileContent) throws IOException {
        FileOutputStream fos = new FileOutputStream(filePath);
        fos.write(fileContent);
        fos.close();
    }
}
