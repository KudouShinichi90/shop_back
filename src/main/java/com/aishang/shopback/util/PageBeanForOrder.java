package com.aishang.shopback.util;

public class PageBeanForOrder<T> extends PageBean<T> {
    private Integer state;

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "PageBeanForOrder{" +
                "state=" + state +
                '}';
    }
}
