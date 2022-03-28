/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import define.DateUtils;
import dtos.LogDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtilities;

public class LogDAO implements Serializable {

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

    public void getInsertLog(LogDTO log) throws Exception {
        String sql = "INSERT INTO tblLog (cakeID, userID, description, date) values(?,?,?,?)";
        DateUtils dateUtils = new DateUtils();
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, log.getCakeID());
            preStm.setString(2, log.getUserID());
            preStm.setString(3, log.getDescription());
            preStm.setTimestamp(4, java.sql.Timestamp.valueOf(dateUtils.getCurrentDate()));
            preStm.executeUpdate();
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
    }
}
