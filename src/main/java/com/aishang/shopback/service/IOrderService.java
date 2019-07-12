package com.aishang.shopback.service;

import com.aishang.shopback.po.Order;
import com.aishang.shopback.po.OrderExt;
import com.aishang.shopback.po.OrderItem;
import com.aishang.shopback.util.PageBeanForOrder;

import java.util.List;

public interface IOrderService {

    /**
     * 修改订单状态
     */
    void updateOState(Order order);

    /**
     * 修改订单addr
     */
    void updateOAddr(Order order);

    /*
     * 根据订单uid查询fenye
     */
    PageBeanForOrder<OrderExt> findOrderByState(PageBeanForOrder<OrderExt> pageBeanForOrder);

   List<OrderItem> findPid(Integer pid);
}
