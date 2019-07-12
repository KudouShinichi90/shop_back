package com.aishang.shopback.controller;

import com.aishang.shopback.po.Order;
import com.aishang.shopback.po.OrderExt;
import com.aishang.shopback.service.IOrderService;
import com.aishang.shopback.util.PageBeanForOrder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/order")
public class OrderController {
    @Resource
    private IOrderService orderService;

    /**
     * 订单详情分页
     *
     * @param pageBeanForOrder
     * @param model
     * @return
     */
    @RequestMapping("/orders")
    public String orders(PageBeanForOrder<OrderExt> pageBeanForOrder, Model model) {
        Integer state = pageBeanForOrder.getState();
        if (state == null) {
            pageBeanForOrder.setState(-1);
        }
        pageBeanForOrder = orderService.findOrderByState(pageBeanForOrder);
        model.addAttribute("pageBeanForOrder", pageBeanForOrder);
        return "orders";

    }

    /**
     * ajax修改状态  地址
     */
    @RequestMapping("/updateOrder")
    public void updateOrder(HttpServletResponse response, Integer state, String addr, Integer oid) throws IOException {
        Order order = new Order();
        order.setOid(oid);
        order.setAddr(addr);
        order.setState(state);
        orderService.updateOAddr(order);
        orderService.updateOAddr(order);
        response.getWriter().print("ok");
    }
}
