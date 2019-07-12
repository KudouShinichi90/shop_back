package com.aishang.shopback.service.Impl;

import com.aishang.shopback.dao.IProductDao;
import com.aishang.shopback.po.Category;
import com.aishang.shopback.po.CategorySecond;
import com.aishang.shopback.po.Categoryext;
import com.aishang.shopback.po.Product;
import com.aishang.shopback.service.IProductService;
import com.aishang.shopback.util.PageBeanForProduct;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Transactional
@Service
public class ProductService implements IProductService {
    @Resource
    private IProductDao productDao;

    /**
     * 商品分页
     *
     * @param pageBeanForProduct
     * @return
     */

    @Override
    public PageBeanForProduct<Product> findProduct(PageBeanForProduct<Product> pageBeanForProduct) {
        /*完善PageBean*/
        /*set pname*/
        if (pageBeanForProduct.getPname() != null) {
            pageBeanForProduct.setPname(pageBeanForProduct.getPname().trim());
        }
        /*set pageSize*/
        Integer pageSize = 10;
        pageBeanForProduct.setPageSize(pageSize);
        /*set rowCount*/
        Integer rowCount = productDao.findProRowCount(pageBeanForProduct);
        pageBeanForProduct.setRowCount(rowCount);
        /*set pageCount*/
        int pageCount = 1;
        if (rowCount % pageSize == 0) {
            pageCount = rowCount / pageSize;
        } else {
            pageCount = rowCount / pageSize + 1;
        }
        pageBeanForProduct.setPageCount(pageCount);
        /*set pageNow*/
        Integer pageNow = pageBeanForProduct.getPageNow();
        if (pageNow < 1) {
            pageBeanForProduct.setPageNow(1);
        }
        if (pageNow > pageCount && pageCount > 0) {
            pageBeanForProduct.setPageNow(pageCount);
        }
        /*set List*/
        List<Product> products = productDao.findProduct(pageBeanForProduct);
        pageBeanForProduct.setProducts(products);
        return pageBeanForProduct;
    }

    /**
     * 一级类目
     *
     * @return
     */
    @Override
    public List<Category> findCategory() {
        return productDao.findCategory();
    }

    /**
     * 二级类目
     *
     * @return
     */
    @Override
    public Map<Integer, CategorySecond> findCategorySecond() {
        Map<Integer, CategorySecond> secondMap = new HashMap<Integer, CategorySecond>();
        List<CategorySecond> categorySecond = productDao.findCategorySecond();
        for (CategorySecond second : categorySecond) {
            secondMap.put(second.getCsid(), second);
        }
        return secondMap;
    }

    /**
     * 根据cid 查cs
     *
     * @param cid
     * @return
     */
    @Override
    public List<CategorySecond> findCateSByCid(Integer cid) {
        return productDao.findCateSByCid(cid);
    }

    /**
     * 上传
     *
     * @param file
     * @param product
     */
    @Override
    public void addProduct(MultipartFile file, Product product) {
        File nfile = null;
        try {
            //获取时间
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            product.setIs_hot(1);
            product.setPdate(dateFormat.format(new Date()));
            //文件路径+上传文件名
            File path = new File("D:/IdeaProjects/shopback/src/main/webapp/images");
            File newfile = makefullDirectoryObj(path);
            String filename = UUID.randomUUID() + file.getOriginalFilename();
            nfile = new File(newfile, filename);
            file.transferTo(nfile);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String dateDirectory = sdf.format(new Date());
            String image = "images/" + dateDirectory + "/" + filename;
            product.setImage(image);
            productDao.addProduct(product);
        } catch (Exception e) {
            e.printStackTrace();
            nfile.delete();
        }

    }

    /**
     * 根据pid 查询商品
     */
    @Override
    public Product findProByPid(Integer pid) {
        return productDao.findProBypid(pid);
    }

    /**
     * 跟据pid 查询 cid
     */
    @Override
    public CategorySecond findCidByPid(Integer pid) {
        return productDao.findCsByPid(pid);
    }

    /**
     * 修改商品
     *
     * @param file
     * @param product
     */
    @Override
    public void updateWithPhoto(MultipartFile file, Product product) {
        //获取时间
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        product.setIs_hot(1);
        product.setPdate(dateFormat.format(new Date()));
        Product pro = productDao.findProBypid(product.getPid());
        String oldimg = pro.getImage();
        String oldpath = "D:/IdeaProjects/shop_back/src/main/webapp/" + oldimg;
        if (product.getImage() == null) {
            //删除旧图片
            File oldfile = new File(oldpath);
            oldfile.delete();

            // 上传新图片
            File nfile = null;
            try {
                //文件路径+上传文件名
                File path = new File("D:/IdeaProjects/shop_back/src/main/webapp/images");
                File newfile = makefullDirectoryObj(path);
                String filename = UUID.randomUUID() + file.getOriginalFilename();
                nfile = new File(newfile, filename);
                file.transferTo(nfile);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String dateDirectory = sdf.format(new Date());
                String image = "images/" + dateDirectory + "/" + filename;
                product.setImage(image);
                productDao.updateProduct(product);
            } catch (Exception e) {
                e.printStackTrace();
                nfile.delete();
            }
        } else {
            product.setImage(oldimg);
            productDao.updateProduct(product);
        }
    }

    /**
     * 删除商品
     *
     * @param pid
     */
    @Override
    public void deletePro(Integer pid) {
        Product proBypid = productDao.findProBypid(pid);
        String oldimg = proBypid.getImage();
        String oldpath = "D:/IdeaProjects/shop_back/src/main/webapp/" + oldimg;
        //删除旧图片
        File oldfile = new File(oldpath);
        oldfile.delete();
        //删除信息
        productDao.deletePro(pid);
    }

    /**
     * 多级目录
     *
     * @param storyDirectory
     * @return
     */
    public File makefullDirectoryObj(File storyDirectory) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateDirectory = sdf.format(new Date());
        File file = new File(storyDirectory, dateDirectory);
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

}
