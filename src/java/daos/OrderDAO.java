/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CakeDTO;
import dtos.OrderDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DBUtilities;

public class OrderDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public ArrayList<OrderDTO> getByOrderID(String userID, String orderID) throws SQLException {
        ArrayList<OrderDTO> listOrder = new ArrayList<>();
        String sql = "SELECT orderID,totalPrice,fullName,paymentMethod,paymentStatus,phoneNumber,shippingAddress,date"
                + " From tblOrder WHERE orderID = ?";
        if (userID != null) {
            sql += " and userID = ?";
        }
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, orderID);
            if (userID != null) {
                preStm.setString(2, userID);
            }
            rs = preStm.executeQuery();
            if (rs.next()) {
                OrderDTO orderDTO = new OrderDTO();
                orderDTO.setOrderID(rs.getInt("orderID"));
                orderDTO.setTotalPrice(rs.getFloat("totalPrice"));
                orderDTO.setFullName(rs.getString("fullName"));
                orderDTO.setPaymentMethod(rs.getString("paymentMethod"));
                orderDTO.setPaymentStatus(rs.getString("paymentStatus"));
                orderDTO.setPhoneNumber(rs.getString("phoneNumber"));
                orderDTO.setShippingAddress(rs.getString("shippingAddress"));
                orderDTO.setDate(rs.getDate("date").toString());
                listOrder.add(orderDTO);
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return listOrder;
    }

    public ArrayList<CakeDTO> getCakesByOrderID(String orderID) throws SQLException {
        ArrayList<CakeDTO> listCakes = new ArrayList<>();
        String sql = "SELECT c.cakeID,c.cakeName,c.image, od.quantity FROM tblOrderDetail od"
                + " INNER JOIN tblOrder o ON o.orderID = od.orderID"
                + " INNER JOIN tblCake c ON c.cakeID = od.cakeID"
                + " WHERE o.orderID = ?";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, orderID);
            rs = preStm.executeQuery();
            while (rs.next()) {
                CakeDTO cakeDTO = new CakeDTO();
                cakeDTO.setCakeID(rs.getInt("cakeID"));
                cakeDTO.setCakeName(rs.getString("cakeName"));
                cakeDTO.setImage(rs.getString("image"));
                cakeDTO.setQuantity(rs.getInt("quantity"));
                listCakes.add(cakeDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return listCakes;
    }

    public int insertOrder(OrderDTO order) throws SQLException {
        int insertedID = 0;
        String sql = "INSERT INTO tblOrder"
                + " (userId,totalPrice,date,paymentMethod,paymentStatus,shippingAddress,phoneNumber,fullName)"
                + " OUTPUT inserted.orderID values(?,?,?,?,?,?,?,?)";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, order.getUserID());
            preStm.setFloat(2, order.getTotalPrice());
            preStm.setTimestamp(3, java.sql.Timestamp.valueOf(order.getDate()));
            preStm.setString(4, order.getPaymentMethod());
            preStm.setString(5, order.getPaymentStatus());
            preStm.setString(6, order.getShippingAddress());
            preStm.setString(7, order.getPhoneNumber());
            preStm.setString(8, order.getFullName());
            rs = preStm.executeQuery();
            if (rs.next()) {
                insertedID = rs.getInt("orderID");
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return insertedID;
    }
}
