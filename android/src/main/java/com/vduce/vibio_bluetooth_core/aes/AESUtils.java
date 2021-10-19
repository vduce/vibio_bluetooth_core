package com.vduce.vibio_bluetooth_core.aes;


/**
 *Aes-128 encryption and decryption classes
 */
public class AESUtils {
    //key Aes-128 encryption key
    static String key = AESHeader.getKey();
    /**
     * @param string Plaintext
     * @return Aes-128 encryption function
     */
    public static String Aes128EnCode(String string){
        byte[] encodeByte = EncryptUtils.Aes128Encode(string,key.getBytes());
        String encodeStr = EncryptUtils.byte2hex(encodeByte).toUpperCase();
        System.out.println(string);
        System.out.println(encodeByte);
        System.out.println(encodeStr);
        System.out.println("=======================");
        return encodeStr;
    }
    /**
     * @param string Cipher
     * @return Aes-128 decryption function
     */
    public static String Aes128Decode(String string){
        byte[] deCodeByte = EncryptUtils.hex2byte(string.toLowerCase());
        String deCodeString = EncryptUtils.Aes128Decode(deCodeByte,key.getBytes());
        System.out.println(string);
        System.out.println(deCodeByte);
        System.out.println(deCodeString);
        return deCodeString;
    }

}
