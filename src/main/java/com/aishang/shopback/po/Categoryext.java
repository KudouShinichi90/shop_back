package com.aishang.shopback.po;

import java.util.List;

public class Categoryext extends Category {
    private List<CategorySecondext> categorySecondextList;

    public List<CategorySecondext> getCategorySecondextList() {
        return categorySecondextList;
    }

    public void setCategorySecondextList(List<CategorySecondext> categorySecondextList) {
        this.categorySecondextList = categorySecondextList;
    }

    @Override
    public String toString() {
        return "Categoryext{" +
            "categorySecondextList=" + categorySecondextList +
            '}';
    }
}
