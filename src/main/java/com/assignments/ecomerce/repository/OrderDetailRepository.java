package com.assignments.ecomerce.repository;

import com.assignments.ecomerce.model.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail,Integer> {
    /*List<OrderDetail> findAllByOrderId(Integer orderId);*/
    @Query(value = "select * from orderdetail od where od.orderId =:orderId", nativeQuery = true)
    List<OrderDetail> findAllByOrderId(Integer orderId);

    @Query(value = "SELECT * FROM OrderDetail WHERE orderId = :orderId", nativeQuery = true)
    List<OrderDetail> findListProductByOrderId(@Param("orderId") Integer orderId);
}
