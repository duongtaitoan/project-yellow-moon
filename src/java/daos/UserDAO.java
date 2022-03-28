/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import define.Constants;
import dtos.GooglePojo;
import dtos.UserDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtilities;

public class UserDAO implements Serializable {

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

    public boolean inserGoogleUser(GooglePojo google) throws Exception {
        boolean isSuccess = false;
        String sql = "insert into tblUser(userID,role,password,status) values(?,?,?,?)";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, google.getEmail());
            preStm.setString(2, "CUSTOMER");
            preStm.setString(3, Constants.SAVE_PASSWORD);
            preStm.setBoolean(3, true);
            preStm.executeUpdate();
            isSuccess = true;
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return isSuccess;
    }

    public String getRole(UserDTO user) throws Exception {
        String role = "";
        String sql = "Select role from tblUser where"
                + " userID = ? and password = ? and status = ?";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, user.getUserId());
            preStm.setString(2, user.getPassword());
            preStm.setBoolean(3, true);
            rs = preStm.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return role;
    }

    public String loginWithGoogle(String email) throws Exception {
        String role = "";
        String sql = "select role from tblUser where userID = ? and status = ?";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setBoolean(2, Boolean.TRUE);
            rs = preStm.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return role;
    }
}
