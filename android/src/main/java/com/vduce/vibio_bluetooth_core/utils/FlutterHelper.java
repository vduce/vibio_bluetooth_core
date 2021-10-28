package android.src.main.java.com.vduce.vibio_bluetooth_core.utils;

import com.vduce.vibio_bluetooth_core.utils.aes.AESUtils;
import com.vduce.vibio_bluetooth_core.utils.aes.EncryptUtils;
import com.vduce.vibio_bluetooth_core.utils.random.AWRandomUtils;
import com.vduce.vibio_bluetooth_core.utils.sha.util.ConvertUtils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;


public class FlutterHelper {

    //random
    public static String fhFetchRandom(){
        return AWRandomUtils.createRandomString(SecurityHeader.getRandomCount());
    }

    //sha256
    //Get SHA-256 encrypted password
    public static String fhSHA256(String str) throws NoSuchAlgorithmException {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.update(str.getBytes());
        String sha256String = ConvertUtils.bytes2hex(messageDigest.digest());
        System.out.println(sha256String);
        return sha256String;
    }

    /** Parameters for the first step of obtaining certification
     * @return first step auth data
     */
    public static HashMap fhAuthFirstStepParmas (){
        String authKey = SecurityHeader.getAuthKey();
        String randomString = AWRandomUtils.createRandomString(SecurityHeader.getRandomCount());
        String passText = authKey + randomString + ";";
        String encodeText = AESUtils.Aes128EnCode(passText);

        System.out.println( passText);
        System.out.println( encodeText);

        HashMap myMap  = new HashMap(){{
            put("authMsg",randomString);
            put("authAesMag",encodeText);
        }};
        return myMap;
    }

    /**G// Parameters for the second step of obtaining certification
     * @param authString Obtain the data returned in the first step of the authentication process
     * @return second step auth data
     */
    public static HashMap fhAuthSecondStepParmas (String authString){
        String authKey = SecurityHeader.getAuthKey();
        try {
            String authShaString  = FlutterHelper.fhSHA256(authString);
            String codeString = authShaString.substring(0,4);
            String passText = authKey + codeString + ";";
            String aesAuthMsg = AESUtils.Aes128EnCode(passText);

            System.out.println(authShaString);
            System.out.println(passText);
            System.out.println(aesAuthMsg);

            HashMap myMap  = new HashMap(){{
                put("authAesMag",aesAuthMsg);
            }};
            return myMap;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    /** Encrypt plaintext string with AES
     * @param code  Plaintext
     * @return Aes-128 encryption string
     */
    public static String aesCommandCode (String code){
        String encodeText = AESUtils.Aes128EnCode(code);
        return encodeText;
    }

    /** Decrypt the plaintext string with AES
     * @param code  Plaintext
     * @return Aes-128 DecodeCode string
     */
    public static String aesDecodeCode (String code){
        String encodeText = AESUtils.Aes128Decode(code);
        return encodeText;
    }

    /**Byte array to hexadecimal string and Decode pass
     * @param bytes  bytes
     * @return returnMsg string
     * */
    public static String byte2hex(byte[] bytes){
        String passText = EncryptUtils.byte2hex(bytes);
        String returnMsg = AESUtils.Aes128Decode(passText);
        return returnMsg;
    }

    /** hexadecimal string to Byte array
     * @param hexadecimal string
     * @return bytes
     * */
    public static byte[] hex2byte(String plainText){
        byte[] returnBytes = new byte[0];
        returnBytes = EncryptUtils.hex2byte(plainText);
        return returnBytes;
    }
}
