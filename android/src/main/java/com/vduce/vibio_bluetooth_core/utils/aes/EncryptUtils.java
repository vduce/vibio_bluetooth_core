package android.src.main.java.com.vduce.vibio_bluetooth_core.utils.aes;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;


public class EncryptUtils {

    //ALGORITHM
    public static final String ALGORITHM = "AES/ECB/PKCS5Padding";
    //KEY_ALGORITHM
    public static final String KEY_ALGORITHM = "AES";

    /**
     * @param str The string that needs to be encrypted
     * @param key Aes-128 encryption key
     * @return byte[] An encrypted array of bytes
     */
    public static byte[] Aes128Encode(String str, byte[] key) {
        //initialize();
        byte[] result = null;
        try {
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            SecretKeySpec keySpec = new SecretKeySpec(key, "AES"); //生成加密解密需要的Key
            cipher.init(Cipher.ENCRYPT_MODE, keySpec);
            byte[] bytes = str.getBytes("UTF-8");
            result = cipher.doFinal(bytes);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * @param bytes An array of bytes to be decrypted
     * @param key   Aes-128 encryption key
     * @return String  The decrypted string
     */
    public static String Aes128Decode(byte[] bytes, byte[] key) {
        //initialize();
        String result = null;
        try {
            Cipher cipher = Cipher.getInstance(ALGORITHM/*, "BC"*/);
            SecretKeySpec keySpec = new SecretKeySpec(key, "AES"); //生成加密解密需要的Key
            cipher.init(Cipher.DECRYPT_MODE, keySpec);
            byte[] decoded = cipher.doFinal(bytes);
            result = new String(decoded, "UTF-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static byte[] initKey() throws Exception {
        KeyGenerator kg = KeyGenerator.getInstance(KEY_ALGORITHM);
        kg.init(128);
        SecretKey secretKey = kg.generateKey();
        System.out.println(secretKey.getEncoded().length);
        System.out.println(secretKey.getEncoded());
        return secretKey.getEncoded();
    }


    public static byte[] initRootKey() throws Exception {
        return new byte[]{0x08, 0x08, 0x04, 0x0b, 0x02, 0x0f, 0x0b, 0x0c,
                0x01, 0x03, 0x09, 0x07, 0x0c, 0x03, 0x07, 0x0a, 0x04, 0x0f,
                0x06, 0x0f, 0x0e, 0x09, 0x05, 0x01, 0x0a, 0x0a, 0x01, 0x09,
                0x06, 0x07, 0x09, 0x0d};
    }


    public static Key toKey(byte[] key) throws Exception {
        SecretKey secretKey = new SecretKeySpec(key, KEY_ALGORITHM);
        return secretKey;
    }


    public static byte[] encrypt(byte[] data, byte[] key) throws Exception {
        Key k = toKey(key);
        //Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
        Cipher cipher = Cipher.getInstance(ALGORITHM/*, "BC"*/);
        cipher.init(Cipher.ENCRYPT_MODE, k);
        return cipher.doFinal(data);
    }


    public static byte[] decrypt(byte[] data, byte[] key) throws Exception {
        Key k = toKey(key);
        //Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
        Cipher cipher = Cipher.getInstance(ALGORITHM/*, "BC"*/);
        cipher.init(Cipher.DECRYPT_MODE, k);
        return cipher.doFinal(data);
    }


    /**Byte arrays are converted to hexadecimal strings
     * @param bytes Byte arrays
     * @return hexadecimal strings
     */
    public static String byte2hex(byte[] bytes) {
        StringBuffer sb = new StringBuffer(bytes.length * 2);
        String tmp = "";
        for (int n = 0; n < bytes.length; n++) {
            tmp = (java.lang.Integer.toHexString(bytes[n] & 0XFF));
            if (tmp.length() == 1) {
                sb.append("0");
            }
            sb.append(tmp);
        }
        return sb.toString().toLowerCase(); // 转成小写
    }

    /**Convert the HEX string to a byte array
     * @param str hexadecimal string
     * @return Byte arrays
     */
    public static byte[] hex2byte(String str) {
        if (str == null || str.length() < 2) {
            return new byte[0];
        }
        str = str.toLowerCase();
        int l = str.length() / 2;
        byte[] result = new byte[l];
        for (int i = 0; i < l; ++i) {
            String tmp = str.substring(2 * i, 2 * i + 2);
            result[i] = (byte) (Integer.parseInt(tmp, 16) & 0xFF);
        }
        return result;
    }

    /**
     * String is converted to hexadecimal string
     * @param str ASCII string to be converted
     * @return String Byte A string with no delimiters between each Byte. eg: [616C6B]
     */
    public static String str2HexStr(String str) {
        char[] chars = "0123456789ABCDEF".toCharArray();
        StringBuilder sb = new StringBuilder("");
        byte[] bs = str.getBytes();
        int bit;

        for (int i = 0; i < bs.length; i++) {
            bit = (bs[i] & 0x0f0) >> 4;
            sb.append(chars[bit]);
            bit = bs[i] & 0x0f;
            sb.append(chars[bit]);
//            sb.append(' ');
        }
        return sb.toString().trim();
    }

    /**
     * Hexadecimal strings are converted to Byte arrays
     * @param src Byte A string with no delimiters between each Byte. eg:616C6B
     * @return byte[] Byte arrays
     */
    public static byte[] hexStr2Bytes(String src) {
        int m = 0, n = 0;
        int l = src.length() / 2;
        System.out.println(l);
        byte[] ret = new byte[l];
        for (int i = 0; i < l; i++) {
            m = i * 2 + 1;
            n = m + 1;
            ret[i] = Byte.decode("0x" + src.substring(i * 2, m) + src.substring(m, n));
        }
        return ret;
    }

    /**
     * Hexadecimal array to String
     * @param data byte[] Byte arrays
     * @return string Hexadecimal String
     */
    public static String formatHex2String(byte[] data) {
        final StringBuilder stringBuilder = new StringBuilder(data.length);
        for (byte byteChar : data)
            stringBuilder.append(String.format("%02X ", byteChar));
        return stringBuilder.toString();
    }

    /**
     * The hexadecimal string is converted to the letter ASCALL code
     * @param hex The hexadecimal numbers to be converted are separated by Spaces
     *            for example：53 68 61 64 6f 77
     * @return ASCALL code
     */
    public static String convertHexToAsCall(String hex) {
        StringBuilder sb = new StringBuilder();
        String[] split = hex.split(" ");
        for (String str : split) {
            int i = Integer.parseInt(str, 16);
            if (i < 0x20 || i == 0x7F) {
                continue;
            }
            sb.append((char) i);
        }
        return sb.toString();
    }
}
