package com.aishang.shopback.dao;

import com.aishang.shopback.po.Category;
import com.aishang.shopback.po.CategorySecond;
import com.aishang.shopback.po.Categoryext;
import com.aishang.shopback.po.Product;
import com.aishang.shopback.util.PageBeanForProduct;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IProductDao {

    /**
     * 查询商品分页
     */
    List<Product> findProduct(PageBeanForProduct<Product> pageBeanForProduct);

    /**
     * 查询商品数量
     */
    Integer findProRowCount(PageBeanForProduct<Product> pageBeanForProduct);

    /*一级类目*/
    List<Category> findCategory();

    /**
     * 二级类目
     */
    List<CategorySecond> findCategorySecond();

    /**
     * 根据cid 查cs
     */
    List<CategorySecond> findCateSByCid(Integer cid);

    void addProduct(Product product);

    /**
     * 根据pid 查询 商品
     */
    Product findProBypid(Integer pid);

    /**
     * 跟据pid 查询 categorysecond
     */
    CategorySecond findCsByPid(Integer pid);

    /**
     * 修改商品
     *
     * @param product
     */
    void updateProduct(Product product);

    /**
     * 删除商品
     *
     * @param pid
     */
    void deletePro(Integer pid);
}
