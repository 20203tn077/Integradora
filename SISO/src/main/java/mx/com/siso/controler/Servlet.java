package mx.com.siso.controler;

import mx.com.siso.model.records.DaoRecords;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.model.users.DaoUsers;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "Servlet", value = "/Servlet")
public class Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /* El método get se usa para redirecciones que no necesiten ningún dato de la vista,
        las redirecciones posibles cambian en función del rol para evitar que se acceda a vistas que no corresponden al usuario */
        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
        byte sessionRole = Byte.valueOf(String.valueOf(request.getSession().getAttribute("role") != null ? request.getSession().getAttribute("role") : "0"));

        //División de acciones disponibles en función del rol de la sesión
        if (sessionRole >= 1 && sessionRole <= 4) {
            request.setAttribute("access", true);
        }
        switch (sessionRole) {
            case 1:
                switch (redirect) {
                    case "records":
                        break;
                    case "profile":
                }
                break;
            case 2:
                switch (redirect) {
                    case "":
                        break;
                }
                break;
            case 3:
                switch (redirect) {
                    case "":
                        break;
                }
                break;
            case 4:
                switch (redirect) {
                    case "":
                        break;
                }
                break;
            default:

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String sessionRole = String.valueOf(request.getSession().getAttribute("role") != null ? request.getSession().getAttribute("role") : "");

        //División de acciones disponibles en función del rol de la sesión
        switch (sessionRole) {
            case "1":
                switch (action) {
                    case "":
                        break;
                }
                break;
            case "2":
                switch (action) {
                    case "":
                        break;
                }
                break;
            case "3":
                switch (action) {
                    case "":
                        break;
                }
                break;
            case "4":
                switch (action) {
                    case "":
                        break;
                }
                break;
            default:

        }

    }
}
