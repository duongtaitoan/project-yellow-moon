/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import dtos.CategoryDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DBUtilities;

public class CategoryDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    private void closeConntion() throws SQLException {
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

    public ArrayList<CategoryDTO> getAll() throws SQLException {
        ArrayList<CategoryDTO> listCategory = new ArrayList<>();
        String sql = "SELECT categoryID, category FROM tblCategory";
        try {
            conn = DBUtilities.makeConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                CategoryDTO cate = new CategoryDTO();
                cate.setCategoryID(rs.getInt("categoryID"));
                cate.setCategory(rs.getString("category"));
                listCategory.add(cate);
            }
        } catch (Exception e) {
        } finally {
            closeConntion();
        }
        return listCategory;
    }
}
