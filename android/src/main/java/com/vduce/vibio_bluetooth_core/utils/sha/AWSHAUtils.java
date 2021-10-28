package android.src.main.java.com.vduce.vibio_bluetooth_core.utils.sha;

import com.vduce.vibio_bluetooth_core.utils.sha.util.ConvertUtils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class AWSHAUtils {
    public static String SHA256(String str) throws NoSuchAlgorithmException {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        messageDigest.update(str.getBytes());
        String sha256String = ConvertUtils.bytes2hex(messageDigest.digest());
        System.out.println(sha256String);
        return sha256String;
    }
}
