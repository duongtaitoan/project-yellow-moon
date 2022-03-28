/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import daos.CategoryDAO;
import daos.UserDAO;
import define.Define;
import dtos.CategoryDTO;
import dtos.GooglePojo;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.GoogleUtils;

/**
 *
 * @author toan
 */
public class LoginGoogleController extends HttpServlet {

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
        String code = request.getParameter("code");
        HttpSession session = request.getSession();
        try {
            if (code == null) {
                url = Define.LOGIN_PAGE;
                request.setAttribute("LOGIN_MSG", "Your account is invalid");
            } else {
                GoogleUtils googleUtils = new GoogleUtils();
                String accessToken = googleUtils.getToken(code);

                GooglePojo googlePojo = new GooglePojo();
                googlePojo = googleUtils.getUserInfo(accessToken);

                UserDAO userDAO = new UserDAO();
                String role = userDAO.loginWithGoogle(googlePojo.getEmail());

                if (role != null && role.length() != 0) {
                    session.setAttribute("ROLE", role);
                    session.setAttribute("USER", googlePojo.getEmail());
                    url = Define.INDEX_PAGE;
                } else {
                    boolean isSuccess = userDAO.inserGoogleUser(googlePojo);
                    if (isSuccess) {
                        session.setAttribute("ROLE", role);
                        session.setAttribute("USER", googlePojo.getEmail());
                        url = Define.INDEX_PAGE;
                    }
                }
            }

            if (url.equalsIgnoreCase(Define.INDEX_PAGE)) {
                CategoryDAO categoryDAO = new CategoryDAO();
                ArrayList<CategoryDTO> listCategory = categoryDAO.getAll();
                request.setAttribute("LIST_CATEGORY", listCategory);
            }
        } catch (Exception e) {
            log("Error at Login with Google Controller " + e.getLocalizedMessage());
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
