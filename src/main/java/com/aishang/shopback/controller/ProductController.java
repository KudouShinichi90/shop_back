package com.aishang.shopback.controller;

import com.aishang.shopback.po.*;
import com.aishang.shopback.service.IOrderService;
import com.aishang.shopback.service.IProductService;
import com.aishang.shopback.util.PageBeanForProduct;
import com.alibaba.fastjson.JSON;
import com.sun.deploy.net.HttpResponse;
import org.apache.ibatis.annotations.Param;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Resource
    private IProductService productService;
    @Resource
    private IOrderService orderService;

    /**
     * 商品管理分页
     */
    @RequestMapping("/products")
    public String products(PageBeanForProduct<Product> pageBeanForProduct, Model model) {
        /*封装pageBean  回传*/
        pageBeanForProduct = productService.findProduct(pageBeanForProduct);
        /*查询类目*/
        List<Category> category = productService.findCategory();
        Map<Integer, CategorySecond> categorySecond = productService.findCategorySecond();

        model.addAttribute("category", category);
        model.addAttribute("categorySecond", categorySecond);
        model.addAttribute("pageBean", pageBeanForProduct);
        return "products";
    }

    /**
     * 跳转页面
     *
     * @return
     */
    @RequestMapping("/addProduct.do")
    public String addProduct(Integer pid, Model model) {
        if (pid != 0) {
            Product proByPid = productService.findProByPid(pid);
            CategorySecond cidByPid = productService.findCidByPid(pid);
            model.addAttribute("product", proByPid);
            model.addAttribute("cs", cidByPid);
        }
        return "addProduct";
    }

    /**
     * json
     *
     * @param response
     * @throws IOException
     */
    @RequestMapping("/addProductJson")
    public void addProductJson(HttpServletResponse response) throws IOException {
        List<Category> category = productService.findCategory();
        response.setContentType("text/html;charset=utf-8");
        String c = JSON.toJSONString(category);
        response.getWriter().print(c);
    }

    /**
     * json2
     */
    @RequestMapping("/addProductJson2")
    public void addProductJson2(Integer cid, HttpServletResponse response) throws IOException {
        if (cid == 0) {
            String flag = "no";
            String s = JSON.toJSONString(flag);
            response.getWriter().print(s);
        } else {
            //根据cid  查csid
            List<CategorySecond> categorySeconds = productService.findCateSByCid(cid);
            response.setContentType("text/html;charset=utf-8");
            String cs = JSON.toJSONString(categorySeconds);
            response.getWriter().print(cs);
        }
    }

    /**
     * 上传
     *
     * @param file
     * @param product
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String fileUpload(@Param("file") MultipartFile file, Product product) throws UnsupportedEncodingException {

        if (product.getPid() == null) {
            // 直接上传
            productService.addProduct(file, product);
            return "redirect:/product/products?pageNow=1";
        } else {
            // 修改上传
            productService.updateWithPhoto(file, product);
            return "redirect:/product/products?pageNow=1";
        }
    }

    /**
     * 删除商品
     */
    @RequestMapping("doDelete")
    public void doDelete(Integer pid, HttpServletResponse response) throws IOException {
        // 查询订单里是否有改商品
        List<OrderItem> orderItems = orderService.findPid(pid);
        if (orderItems.size()<1) {
            //执行删除
            productService.deletePro(pid);
            response.getWriter().print("ok");
        }else {
            response.getWriter().print("no");
        }
    }
}
