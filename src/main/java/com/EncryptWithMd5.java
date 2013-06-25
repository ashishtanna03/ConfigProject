package com;

import java.math.BigInteger;
import java.security.MessageDigest;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/16/13
 * Time: 9:56 PM
 * To change this template use File | Settings | File Templates.
 */
public class EncryptWithMd5 {

    public String encrypt(String text){
        try {
            if(text==null || text.equals(""))
                return null;

            //Create MessageDigest object for MD5
            MessageDigest digest = MessageDigest.getInstance("MD5");

            //Update input string in message digest
            digest.update(text.getBytes(), 0, text.length());

            String encrypted = new BigInteger(1, digest.digest()).toString(16);

            if (encrypted.length() < 32) {
                encrypted = "0" + encrypted;
            }

            //Converts message digest value in base 16 (hex)
            return encrypted;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
