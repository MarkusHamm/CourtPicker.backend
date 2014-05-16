package com.courtpicker.tools;

import java.io.File;
import java.io.IOException;

import org.junit.Test;
import static org.junit.Assert.*;

public class FileHandlerTest {
    @Test
    public void writeStringToFile_storesFileCorrectly() throws IOException {
        // setup
        String filePath = "C:/Temp/stringtest.txt";
        File f = new File(filePath);
        f.delete();
        
        // execute
        FileHandler fileHandler = new FileHandler();
        fileHandler.writeStringToFile(filePath, "Däs ist mein Testtex$€t\r\nNeue Zeile ?Ä$$");
        
        // assert        
        assertTrue(f.exists());
        
        // clean
        f.delete();
    }
    
    @Test
    public void writeByteArrayToFile_storesFileCorrectly() throws IOException {
        // setup
        String filePath = "C:/Temp/bytetest.txt";
        File f = new File(filePath);
        f.delete();
        
        // execute
        FileHandler fileHandler = new FileHandler();
        fileHandler.writeByteArrayToFile(filePath, "Däs ist mein Testtex$€t\r\nNeue Zeile ?Ä$$".getBytes());
        
        // assert        
        assertTrue(f.exists());
        
        // clean
        f.delete();
    }
}
