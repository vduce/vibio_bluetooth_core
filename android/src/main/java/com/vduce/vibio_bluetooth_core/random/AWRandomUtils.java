package android.src.main.java.com.vduce.vibio_bluetooth_core.random;

import java.util.Random;

/**
 * Random string class
 */
public class AWRandomUtils {

    /**
     * @param length 8
     * @return A string of eight random characters consisting of numbers or letters
     */
    public static String createRandomString(int length){
        Random random = new Random();
        StringBuffer stringBuffer = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(3);
            long result = 0;
            switch (number) {
                case 0:
                    result = Math.round(Math.random()*25+65);
                    stringBuffer.append(String.valueOf((char)result));
                    break;
                case 1:
                    result = Math.round(Math.random()*25+97);
                    stringBuffer.append(String.valueOf((char)result));
                    break;
                case 2:
                    stringBuffer.append(String.valueOf(new Random().nextInt(10)));
                    break;
            }
        }
        return stringBuffer.toString();
    }
}
