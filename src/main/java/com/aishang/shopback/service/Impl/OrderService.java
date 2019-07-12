package com.aishang.shopback.service.Impl;

import com.aishang.shopback.dao.IOrderDao;
import com.aishang.shopback.po.Order;
import com.aishang.shopback.po.OrderExt;
import com.aishang.shopback.po.OrderItem;
import com.aishang.shopback.service.IOrderService;
import com.aishang.shopback.util.PageBeanForOrder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OrderService implements IOrderService {
    @Resource
    private IOrderDao orderDao;

    /**
     * 修改状态
     *
     * @param order
     */
    @Override
    public void updateOState(Order order) {
        orderDao.updateOState(order);
    }

    /**
     * 修改地址
     *
     * @param order
     */
    @Override
    public void updateOAddr(Order order) {
        orderDao.updateOAddr(order);
    }

    /**
     * 查询分页
     *
     * @param pageBeanForOrder
     * @return
     */
    @Override
    public PageBeanForOrder<OrderExt> findOrderByState(PageBeanForOrder<OrderExt> pageBeanForOrder) {
        /*完善PageBean*/
        /*set pageSize*/
        Integer pageSize = 5;
        pageBeanForOrder.setPageSize(pageSize);
        /*set rowCount*/
        Integer rowCount = orderDao.findOrderCountByState(pageBeanForOrder.getState());
        pageBeanForOrder.setRowCount(rowCount);
        /*set pageCount*/
        int pageCount = 1;
        if (rowCount % pageSize == 0) {
            pageCount = rowCount / pageSize;
        } else {
            pageCount = rowCount / pageSize + 1;
        }
        pageBeanForOrder.setPageCount(pageCount);
        /*set pageNow*/
        Integer pageNow = pageBeanForOrder.getPageNow();
        if (pageNow < 1) {
            pageBeanForOrder.setPageNow(1);
        }
        if (pageNow > pageCount && pageCount > 0) {
            pageBeanForOrder.setPageNow(pageCount);
        }
        /*set List*/
        List<OrderExt> orderExts = orderDao.findOrderByState(pageBeanForOrder);
        pageBeanForOrder.setProducts(orderExts);
        return pageBeanForOrder;
    }

    /**
     * find pid
     * @param pid
     * @return
     */
    @Override
    public List<OrderItem> findPid(Integer pid) {
        return orderDao.findPid(pid);
    }
}
