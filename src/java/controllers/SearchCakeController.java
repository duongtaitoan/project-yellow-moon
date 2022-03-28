/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import daos.CakeDAO;
import daos.CategoryDAO;
import define.Define;
import dtos.CakeDTO;
import dtos.CategoryDTO;
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
public class SearchCakeController extends HttpServlet {

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
        HttpSession session = request.getSession();
        try {
            String action = request.getParameter("btnAction");
            ArrayList<CakeDTO> listCake = new ArrayList<>();
            CakeDAO cakeDAO = new CakeDAO();

            if (action != null && !action.equals("")) {
                if (!action.equalsIgnoreCase("Search Cake")) {
                    String cakeName = (String) session.getAttribute("searchedCakeName");
                    int categoryID = (int) session.getAttribute("searchedCategoryID");
                    String txtPriceFrom = (String) request.getAttribute("searchedPriceFrom");
                    String txtPriceTo = (String) request.getAttribute("searchedPriceTo");

                    Float priceFrom = null;
                    if (txtPriceFrom != null && txtPriceFrom != "") {
                        priceFrom = Float.parseFloat(txtPriceFrom);
                    }
                    Float priceTo = null;
                    if (txtPriceTo != null && txtPriceTo != "") {
                        priceTo = Float.parseFloat(txtPriceTo);
                    }

                    listCake = cakeDAO.getCakesByParam(cakeName, categoryID, priceFrom, priceTo);
                    request.setAttribute("LIST_CAKE", listCake);
                } else {
                    String txtCakeName = new String(request.getParameter("txtCakeName").getBytes("iso-8859-1"), "UTF-8");
                    int categoryId = Integer.parseInt(request.getParameter("selectCategory"));
                    String txtPriceFrom = request.getParameter("txtPriceFrom");
                    String txtPriceTo = request.getParameter("txtPriceTo");

                    Float priceFrom = null;
                    if (txtPriceFrom != null && txtPriceFrom != "") {
                        priceFrom = Float.parseFloat(txtPriceFrom);
                    }
                    Float priceTo = null;
                    if (txtPriceTo != null && txtPriceTo != "") {
                        priceTo = Float.parseFloat(txtPriceTo);
                    }

                    session.setAttribute("searchedCakeName", txtCakeName);
                    session.setAttribute("searchedCategoryID", categoryId);
                    session.setAttribute("searchedPriceFrom", txtPriceFrom);
                    session.setAttribute("searchedPriceTo", txtPriceTo);

                    listCake = cakeDAO.getCakesByParam(txtCakeName, categoryId, priceFrom, priceTo);
                    request.setAttribute("LIST_CAKE", listCake);
                }
            }
            CategoryDAO categoryDAO = new CategoryDAO();
            ArrayList<CategoryDTO> listCategory = categoryDAO.getAll();
            request.setAttribute("LIST_CATEGORY", listCategory);
        } catch (Exception e) {
            log("Error At Search Cake Controller " + e.getLocalizedMessage());
            request.setAttribute("Error ", e.getLocalizedMessage());
//            url = Define.ERROR_PAGE;
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
