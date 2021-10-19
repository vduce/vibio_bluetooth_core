package com.vduce.vibio_bluetooth_core.sha;


public abstract class MsgDigest {

    private final String algorithm;

    public MsgDigest(String algorithm) {
        this.algorithm = algorithm;
    }

    public abstract void reset();

    public abstract void update(byte[] b);

    public abstract void update(byte[] b, int ofs, int len);

    public abstract byte[] digest();

    public abstract String toString();

    public String getAlgorithm() {
        return algorithm;
    }
}
