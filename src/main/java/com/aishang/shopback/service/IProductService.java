package com.aishang.shopback.service;

import com.aishang.shopback.po.Category;
import com.aishang.shopback.po.CategorySecond;
import com.aishang.shopback.po.Categoryext;
import com.aishang.shopback.po.Product;
import com.aishang.shopback.util.PageBeanForProduct;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface IProductService {
    /**
     * 商品分页
     */
    PageBeanForProduct<Product> findProduct(PageBeanForProduct<Product> pageBeanForProduct);


    /**
     * 一级类目
     */
    List<Category> findCategory();

    /**
     * 二级类目
     */
    Map<Integer, CategorySecond> findCategorySecond();

    /**
     * 根据cid 查cs
     */
    List<CategorySecond> findCateSByCid(Integer cid);

    void addProduct(MultipartFile file, Product product);

    /**
     * 根据pid 查询商品
     */
    Product findProByPid(Integer pid);

    /**
     * 跟据pid 查询 cs
     */
    CategorySecond findCidByPid(Integer pid);

    /**
     * 修改商品
     *
     * @param file
     * @param product
     */
    void updateWithPhoto(MultipartFile file, Product product);

    /**
     * 删除商品
     *
     * @param pid
     */
    void deletePro(Integer pid);
}
