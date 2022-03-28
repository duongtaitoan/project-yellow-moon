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
public class UpdateCartController extends HttpServlet {

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
        String url = Define.CART_PAGE;
        HttpSession session = request.getSession();
        try {
            ArrayList<CakeDTO> cart = (ArrayList<CakeDTO>) session.getAttribute("CART");
            CakeDAO cakeDAO = new CakeDAO();

            int txtCakeID = Integer.parseInt(request.getParameter("txtCakeID"));
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
            for (int i = 0; i < cart.size(); i++) {
                if (cart.get(i).getCakeID() == txtCakeID) {
                    cart.get(i).setQuantity(quantity);
                    break;
                }
            }

            boolean tmpQuantity = false;
            for (CakeDTO f : cart) {
                int maxQuantity = cakeDAO.getQuantity(txtCakeID);
                if (f.getQuantity() > maxQuantity) {
                    f.setQuantity(maxQuantity);
                    tmpQuantity = true;
                }
            }
            if (tmpQuantity) {
                request.setAttribute("CHECK_OUT_MSG", "Some cake is out of stock, please check the quantity");
                url = Define.CART_PAGE;
                return;
            }
            session.setAttribute("CART", cart);
        } catch (Exception e) {
            log("Error At Update Cart Controller " + e.getLocalizedMessage());
            url = Define.CART_PAGE;
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
