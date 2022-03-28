/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import daos.CakeDAO;
import daos.CategoryDAO;
import daos.LogDAO;
import define.DateUtils;
import define.Define;
import dtos.CakeDTO;
import dtos.CategoryDTO;
import dtos.LogDTO;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author toan
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5
)

public class UpdateCakeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = Define.UPDATE_CAKE_PAGE;
        HttpSession session = request.getSession();
        try {
            String action = request.getParameter("btnAction");
            int txtCakeID = Integer.parseInt(request.getParameter("txtCakeID"));
            CakeDAO cakeDAO = new CakeDAO();
            CakeDTO cake = cakeDAO.getCakeByID(txtCakeID);

            if (action.equalsIgnoreCase("Go To Update Page")) {
                request.setAttribute("CAKE_DETAIL", cake);
            } else if (action.equalsIgnoreCase("Update Cake")) {
                String txtCakeName = new String(request.getParameter("txtCakeName").getBytes("iso-8859-1"), "UTF-8");
                String description = new String(request.getParameter("txtDescription").getBytes("iso-8859-1"), "UTF-8");
                float price = Float.parseFloat(request.getParameter("txtPrice"));
                int categoryID = Integer.parseInt(request.getParameter("selectCategory"));
                int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                String slStatus = String.valueOf(request.getParameter("txtStatus"));
                String txtExpDate = request.getParameter("txtExpirationDate");
                String txtCreateDate = request.getParameter("txtCreateDate");
                DateUtils dateUtils = new DateUtils();

                CakeDTO updatedCake = new CakeDTO();
                updatedCake.setCakeID(txtCakeID);
                updatedCake.setCakeName(txtCakeName);
                updatedCake.setPrice(price);
                updatedCake.setCategoryID(categoryID);
                updatedCake.setQuantity(quantity);
                updatedCake.setDescription(description);
                updatedCake.setCreateDate(dateUtils.convertExpiDate(txtCreateDate));
                updatedCake.setExpirationDate(dateUtils.convertExpiDate(txtExpDate));
                updatedCake.setStatus(Boolean.valueOf(slStatus));

                // get file image
                Part image = request.getPart("inputImage");
                if (!getFileName(image).equals("")) {
                    String directoryPath = this.getServletContext().getRealPath("") + "/images";
                    File directory = new File(directoryPath);
                    if (!directory.exists()) {
                        boolean directoryCreated = directory.mkdirs();
                        if (!directoryCreated) {
                            throw new IllegalStateException("Cannot create directory to save file");
                        }
                    }
                    //get path file
                    String filePath = directoryPath + "/" + this.getFileName(image);
                    //save file
                    image.write(filePath);;
                    updatedCake.setImage("images/" + this.getFileName(image));
                } else {
                    updatedCake.setImage(cake.getImage());
                }

                boolean isSuccess = cakeDAO.updateCake(updatedCake);
                // update data and save to Log
                if (isSuccess) {
                    LogDAO logDAO = new LogDAO();
                    LogDTO log = new LogDTO();
                    String userID = (String) session.getAttribute("USER");

                    log.setCakeID(updatedCake.getCakeID());
                    log.setUserID(userID);
                    log.setDescription("User " + userID + " UPDATED This Cake");
                    logDAO.getInsertLog(log);

                    url = Define.SEARCH_CAKE_CONTROLLER;
                    request.setAttribute("UPDATE_CAKE_MSG_SUCCESS", "Update Cake (" + updatedCake.getCakeName() + ") Success ");
                    request.setAttribute("CAKE_DETAIL", updatedCake);
                } else {
                    request.setAttribute("UPDATE_CAKE_MSG_FAILED", "Update Cake(" + updatedCake.getCakeName() + ") Failed ");
                    request.setAttribute("CAKE_DETAIL", cake);
                }
            }
            if (url.equals(Define.UPDATE_CAKE_PAGE)) {
                CategoryDAO categoryDAO = new CategoryDAO();
                ArrayList<CategoryDTO> listCategory = categoryDAO.getAll();
                request.setAttribute("LIST_CATEGORY", listCategory);
            }
        } catch (Exception e) {
            log("Error At Update Cake Controller" + e.getLocalizedMessage());
            request.setAttribute("ERROR_MSG", e.getLocalizedMessage());
            url = Define.ERROR_PAGE;
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return UUID.randomUUID().toString() + ".jpg";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
