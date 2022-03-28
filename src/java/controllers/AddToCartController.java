/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import daos.CakeDAO;
import define.Define;
import dtos.CakeDTO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author toan
 */
public class AddToCartController extends HttpServlet {

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
        String url = Define.SEARCH_CAKE_CONTROLLER;
        HttpSession session = request.getSession();
        try {
            int txtCakeID = Integer.parseInt(request.getParameter("txtCakeID"));
            CakeDAO cakeDAO = new CakeDAO();
            CakeDTO cakeDTO = cakeDAO.getCakeByID(txtCakeID);
            ArrayList<CakeDTO> cart = (ArrayList<CakeDTO>) session.getAttribute("CART");
            boolean isPicked = false;
            if (cart == null) {
                cart = new ArrayList<CakeDTO>();
            }
            for (int i = 0; i < cart.size(); i++) {
                if (cart.get(i).getCakeID() == txtCakeID) {
                    request.setAttribute("ADD_TO_CART_MSG", cakeDTO.getCakeName() + " is already in your cart");
                    isPicked = true;
                    break;
                }
            }

            if (isPicked == false) {
                request.setAttribute("ADD_TO_CART_MSG", cakeDTO.getCakeName() + " is added to your cart");
                cakeDTO.setQuantity(1);
                cart.add(cakeDTO);
            }
            session.setAttribute("CART", cart);
        } catch (Exception e) {
            log("Error At Add To Cart Controller " + e.getLocalizedMessage());
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
