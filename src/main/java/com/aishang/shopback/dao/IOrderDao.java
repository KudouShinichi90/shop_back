package com.aishang.shopback.dao;

import com.aishang.shopback.po.Order;
import com.aishang.shopback.po.OrderExt;
import com.aishang.shopback.po.OrderItem;
import com.aishang.shopback.util.PageBeanForOrder;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IOrderDao {
    /**
     * 查询分页订单
     */
    List<OrderExt> findOrderByState(PageBeanForOrder<OrderExt> pageBeanForOrder);

    /**
     * state 查询订单数量
     */
    int findOrderCountByState(Integer state);

    /**
     * 修改订单状态
     */
    void updateOState(Order order);
    /**
     * 修改订单addr
     */
    void updateOAddr(Order order);

    /**
     * find pid
     * @param pid
     * @return
     */

    List<OrderItem> findPid(Integer pid);
}
