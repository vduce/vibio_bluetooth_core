package com.vduce.vibio_bluetooth_core.sha.hash;

import com.vduce.vibio_bluetooth_core.utils.sha.hash.SHA2;

public class SHA256 extends SHA2 {

    private static final int[] INITIAL_HASHES = {
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
    };

    public SHA256() {
        super("SHA-256", 32, INITIAL_HASHES);
    }
}
