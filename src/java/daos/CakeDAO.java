/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CakeDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utils.DBUtilities;

public class CakeDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    private void closeConnection() throws Exception {
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

    public ArrayList<CakeDTO> getCakesByParam(String cakeName, Integer categoryID, Float priceFrom, Float priceTo) throws Exception {
        ArrayList<CakeDTO> listCake = new ArrayList<>();
        String sql = "SELECT c.cakeID, c.cakeName, c.price, c.image, c.quantity, ct.category, c.createDate, c.expirationDate, c.description, c.status"
                + " FROM tblCake c"
                + " INNER JOIN tblCategory ct"
                + " on c.categoryID = ct.categoryID"
                + " WHERE"
                + " c.quantity >= 0"
                + " and c.cakeName LIKE ?"
                + " and c.price >= ?"
                + " and c.price <= ?";
        if (categoryID != 0) {
            sql += " and ct.categoryID = ?";
        }
        sql += " Order by c.createDate";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + cakeName + "%");
            if (priceFrom != null) {
                preStm.setFloat(2, priceFrom);
            } else {
                preStm.setFloat(2, 0);
            }
            if (priceTo != null) {
                preStm.setFloat(3, priceTo);
            } else {
                preStm.setFloat(3, Integer.MAX_VALUE);
            }
            if (categoryID != 0) {
                preStm.setInt(4, categoryID);
            }
            rs = preStm.executeQuery();
            while (rs.next()) {
                CakeDTO cakes = new CakeDTO();
                cakes.setCakeID(rs.getInt("cakeID"));
                cakes.setCakeName(rs.getString("cakeName"));
                cakes.setPrice(rs.getFloat("price"));
                cakes.setImage(rs.getString("image"));
                cakes.setQuantity(rs.getInt("quantity"));
                cakes.setCategory(rs.getString("category"));
                cakes.setCreateDate(rs.getDate("createDate").toString());
                cakes.setExpirationDate(rs.getDate("expirationDate").toString());
                cakes.setDescription(rs.getString("description"));
                cakes.setStatus(rs.getBoolean("status"));
                listCake.add(cakes);
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return listCake;
    }

    public CakeDTO getCakeByID(int cakeID) throws Exception {
        CakeDTO cakeDTO = new CakeDTO();
        String sql = "SELECT c.cakeName, c.status, c.price, c.image, c.categoryID, c.createDate, c.expirationDate,"
                + " c.description, c.quantity, ct.category"
                + " FROM tblCake c"
                + " INNER JOIN tblCategory ct ON"
                + " c.categoryID = ct.categoryID"
                + " WHERE cakeID = ?";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, cakeID);
            rs = preStm.executeQuery();
            while (rs.next()) {
                cakeDTO.setCakeID(cakeID);
                cakeDTO.setCakeName(rs.getString("cakeName"));
                cakeDTO.setStatus(rs.getBoolean("status"));
                cakeDTO.setPrice(rs.getFloat("price"));
                cakeDTO.setImage(rs.getString("image"));
                cakeDTO.setCategoryID(rs.getInt("categoryID"));
                cakeDTO.setCreateDate(rs.getDate("createDate").toString());
                cakeDTO.setExpirationDate(rs.getDate("expirationDate").toString());
                cakeDTO.setDescription(rs.getString("description"));
                cakeDTO.setQuantity(rs.getInt("quantity"));
                cakeDTO.setCategory(rs.getString("category"));
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return cakeDTO;
    }

    public boolean updateCake(CakeDTO cake) throws Exception {
        boolean isSuccess = false;
        String sql = "UPDATE tblCake SET cakeName = ?, price = ?, image = ?, categoryID = ?,"
                + " description = ?, quantity = ?, status = ?, createDate = ?, expirationDate = ? where cakeID = ?";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, cake.getCakeName());
            preStm.setFloat(2, cake.getPrice());
            preStm.setString(3, cake.getImage());
            preStm.setInt(4, cake.getCategoryID());
            preStm.setString(5, cake.getDescription());
            preStm.setInt(6, cake.getQuantity());
            preStm.setBoolean(7, cake.isStatus());
            preStm.setTimestamp(8, java.sql.Timestamp.valueOf(cake.getCreateDate()));
            preStm.setTimestamp(9, java.sql.Timestamp.valueOf(cake.getExpirationDate()));
            preStm.setInt(10, cake.getCakeID());
            if (preStm.executeUpdate() > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return isSuccess;
    }

    public boolean insertCake(CakeDTO cake) throws Exception {
        boolean isSuccess = false;
        String sql = "INSERT INTO tblCake "
                + "(cakeName, status, price, image, categoryID, createDate, expirationDate, description, quantity) VALUES(?,?,?,?,?,?,?,?,?)";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, cake.getCakeName());
            preStm.setBoolean(2, Boolean.TRUE);
            preStm.setFloat(3, cake.getPrice());
            preStm.setString(4, cake.getImage());
            preStm.setInt(5, cake.getCategoryID());
            preStm.setTimestamp(6, java.sql.Timestamp.valueOf(cake.getCreateDate()));
            preStm.setTimestamp(7, java.sql.Timestamp.valueOf(cake.getExpirationDate()));
            preStm.setString(8, cake.getDescription());
            preStm.setInt(9, cake.getQuantity());
            preStm.executeUpdate();
            isSuccess = true;
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return isSuccess;
    }

    public void subQuantity(int cakeID, int subQuantity) throws Exception {
        String sql = "UPDATE tblCake SET quantity = quantity - ? where cakeID = ?";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, subQuantity);
            preStm.setInt(2, cakeID);
            preStm.executeUpdate();
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
    }

    public int getQuantity(int cakeID) throws Exception {
        int quantity = 0;
        String sql = "SELECT quantity FROM tblCake WHERE cakeID = ?";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, cakeID);
            rs = preStm.executeQuery();
            while (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return quantity;
    }
}
