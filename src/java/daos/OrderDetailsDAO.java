/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.OrderDetailDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBUtilities;

public class OrderDetailsDAO implements Serializable {

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

    public boolean insertOrderDetail(OrderDetailDTO orderDetailDTO) throws SQLException {
        boolean isSuccess = false;
        String sql = "INSERT INTO tblOrderDetail (orderID, cakeID, quantity, unitPrice) VALUES(?,?,?,?)";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, orderDetailDTO.getOrderID());
            preStm.setInt(2, orderDetailDTO.getCakeID());
            preStm.setInt(3, orderDetailDTO.getQuantity());
            preStm.setFloat(4, orderDetailDTO.getUnitPrice());
            if (preStm.executeUpdate() > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return isSuccess;
    }
}
