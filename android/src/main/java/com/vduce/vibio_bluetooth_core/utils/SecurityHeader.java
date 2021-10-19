package com.vduce.vibio_bluetooth_core.utils;


class SecurityHeader {
    private static String authKey = "Auth:";
    private static int randomCount = 8;

    /**
     * @return The prefix of the authentication mark
     */
    public static String getAuthKey() {
        return authKey;
    }

    /**
     * @return Length of the authentication character
     */
    public static int getRandomCount() {
        return randomCount;
    }
}
