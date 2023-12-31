package com.assignments.ecomerce.service;

import com.assignments.ecomerce.model.*;
import com.assignments.ecomerce.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public interface OrderService {
     Orders save(Orders orders);
     Orders findById(Integer id);
     List<Orders> getAllOrders() ;
     Orders getOrderById(Integer id);
     int countOrders();
     Page<Orders> pageOrders(int pageNo);
     Page<Orders> pageOrdersById(int pageNo,Integer customerId);
     Page<Orders> searchOrders(int pageNo, String keyword);
     Page toPage(List<Orders> list, Pageable pageable);
     List<Orders> transfer(List<Orders> orders);
     List<Object> getData(Date dateFrom, Date dateTo,int year, String chartType);
     Page<Orders> searchOrdersByTime(int pageNo, Date dateFrom, Date dateTo);
     Page<Orders> searchOrdersByTimeEmployee(int pageNo, Date dateFrom, Date dateTo);
     List<Orders> searchOrdersByTimeToExcel(Date dateFrom, Date dateTo);
     Orders getById(Integer id);
     Orders getEmployeeById(Integer id);

     List<Orders> findOrderByStatusAndEmailAndProductId(String userEmail,Integer id);

    Integer saveOrderPay(Orders order);
}
