/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import daos.CakeDAO;
import daos.CategoryDAO;
import define.DateUtils;
import define.Define;
import dtos.CakeDTO;
import dtos.CategoryDTO;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
public class CreateCakeController extends HttpServlet {

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
        String url = Define.CREATE_CAKE_PAGE;
        try {
            String action = request.getParameter("btnAction");
            if (action != null) {
                String txtCakeName = new String(request.getParameter("txtCakeName").getBytes("iso-8859-1"), "UTF-8");
                float price = Float.parseFloat(request.getParameter("txtPrice"));
                int selectedCategory = Integer.parseInt(request.getParameter("selectCategory"));
                int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                String txtDescription = new String(request.getParameter("txtDescription").getBytes("iso-8859-1"), "UTF-8");
                String txtCreateDate = request.getParameter("txtCreateDate");
                String txtExpirationDate = request.getParameter("txtExpirationDate");
                DateUtils dateUtils = new DateUtils();

                if (selectedCategory != 0) {
                    CakeDTO cakes = new CakeDTO();
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
                        String filePath = directoryPath + "/" + this.getFileName(image);
                        image.write(filePath);
                        cakes.setImage("images/" + this.getFileName(image));
                    }

                    cakes.setCakeName(txtCakeName);
                    cakes.setCategoryID(selectedCategory);
                    cakes.setPrice(price);
                    cakes.setQuantity(quantity);
                    cakes.setDescription(txtDescription);
                    cakes.setCreateDate(dateUtils.convertExpiDate(txtCreateDate));
                    cakes.setExpirationDate(dateUtils.convertExpiDate(txtExpirationDate));
                    CakeDAO cakeDAO = new CakeDAO();
                    boolean isSuccess = cakeDAO.insertCake(cakes);

                    if (isSuccess) {
                        url = Define.SEARCH_CAKE_CONTROLLER;
                        request.setAttribute("CREATE_CAKE_MSG_SUCCESS", "CREATE CAKE SUCCESS");
                    } else {
                        request.setAttribute("CREATE_CAKE_MSG_FAILED", "CREATE CAKE FAILED");
                    }
                } else {
                    request.setAttribute("txtCakeName", txtCakeName);
                    request.setAttribute("txtPrice", price);
                    request.setAttribute("selectCategory", selectedCategory);
                    request.setAttribute("txtQuantity", quantity);
                    request.setAttribute("txtDescription", txtDescription);
                    request.setAttribute("txtCreateDate", txtCreateDate);
                    request.setAttribute("txtExpDate", txtExpirationDate);
                    request.setAttribute("CREATE_CAKE_MSG_FAILED", "CREATE CAKE FALIED IS CATEGORY");
                }
            }
            if (url.equalsIgnoreCase(Define.CREATE_CAKE_PAGE)) {
                CategoryDAO categoryDAO = new CategoryDAO();
                ArrayList<CategoryDTO> listCategory = categoryDAO.getAll();
                request.setAttribute("LIST_CATEGORY", listCategory);
            }
        } catch (Exception e) {
            log("Error At Create Cake Controller " + e.getLocalizedMessage());
            request.setAttribute("ERROR_MSG", e.getLocalizedMessage());
//            url = Define.ERROR_PAGE;
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
