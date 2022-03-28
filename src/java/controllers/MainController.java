/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import daos.CategoryDAO;
import define.Define;
import dtos.CategoryDTO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author toan
 */
@MultipartConfig
public class MainController extends HttpServlet {

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
        String url = Define.INDEX_PAGE;
        try {
            String action = request.getParameter("btnAction");
            if (action != null && action != "") {
                if (action.equals("Login")) {
                    url = Define.LOGIN_CONTROLLER;
                } else if (action.equals("Logout")) {
                    url = Define.LOGOUT_CONTROLLER;
                } else if (action.equals("Search Cake")) {
                    url = Define.SEARCH_CAKE_CONTROLLER;
                } else if (action.equals("Add To Cart")) {
                    url = Define.ADD_TO_CART_CONTROLLER;
                } else if (action.equals("Remove From Cart")) {
                    url = Define.REMOVE_FROM_CART_CONTROLLER;
                } else if (action.equals("Update Cart")) {
                    url = Define.UPDATE_CART_CONTROLLER;
                } else if (action.equals("Check Out Paypal")
                        || action.equals("Check Out")) {
                    url = Define.CHECK_OUT_CONTROLLER;
                } else if (action.equalsIgnoreCase("Go To Update Page")
                        || action.equalsIgnoreCase("Update Cake")) {
                    url = Define.UPDATE_CAKE_CONTROLLER;
                } else if (action.equals("Create Cake")) {
                    url = Define.CREATE_CAKE_CONTROLLER;
                } else if (action.equals("Order Tracking")) {
                    url = Define.ORDER_TRACKING_CONTROLLER;
                }
            }
            if (url.equalsIgnoreCase(Define.INDEX_PAGE)) {
                CategoryDAO categoryDAO = new CategoryDAO();
                ArrayList<CategoryDTO> listCategory = categoryDAO.getAll();
                request.setAttribute("LIST_CATEGORY", listCategory);
            }
        } catch (Exception e) {
            log("Error at MainController " + e.getLocalizedMessage());
            request.setAttribute("error", e.getLocalizedMessage());
            url = Define.ERROR_PAGE;
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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
