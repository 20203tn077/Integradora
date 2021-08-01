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
        String sessionRole = String.valueOf(request.getSession().getAttribute("role") != null ? request.getSession().getAttribute("role") : "0");

        //División de acciones disponibles en función del rol de la sesión
        switch (sessionRole) {
            case "0":
                switch (redirect) {
                    case "login":
                        break;
                }
                break;
            case "1":
                switch (redirect) {
                    case "":
                        break;
                }
                break;
            case "2":
                switch (redirect) {
                    case "":
                        break;
                }
                break;
            case "3":
                switch (redirect) {
                    case "":
                        break;
                }
                break;
            case "4":
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
        String sessionRole = String.valueOf(request.getSession().getAttribute("role") != null ? request.getSession().getAttribute("role") : "0");

        //División de acciones disponibles en función del rol de la sesión
        switch (sessionRole) {
            case "0":
                switch (action) {
                    case "access":
                        int result[] = new int[2];
                        String loginUsername = request.getParameter("nameUser") != null ? request.getParameter("nameUser") : "";
                        String loginPassword = request.getParameter("password")!= null ? request.getParameter("password") : "";

                        BeanUsers loginBeanUser = new BeanUsers(0, loginUsername, loginPassword, "", "", "","",0, "", null, null, null);

                        try {
                            result = new DaoUsers().login(loginBeanUser);
                            System.out.println("Tipo de usuario: " + result[1]);
                            System.out.println("Id de usuario: " + result[0]);

                            switch (result[1]) {
                                case 1:
                                    request.setAttribute("recordList", new DaoRecords().findRecordsByAssistant(result[0]));
                                    request.getRequestDispatcher("/views/assistant/record_list.jsp").forward(request, response);
                                    break;
                                case 2:

                                    break;
                                case 3:
                                    break;
                                case 4:
                                    break;
                                default:
                                    //Aquí debe estar el código para aumentar los intentos fallidos
                                    request.getRequestDispatcher("/views/common/login.jsp");
                            }
                            /*
                            if ((result[1] >= 1)||(result[1] <= 4)) {
                                request.getSession().setAttribute("userType", result[1]);
                                request.getSession().setAttribute("userID", result[0]);
                            }
                            if(resultado[1] == 1){
                                request.setAttribute("listMinutes", new DaoRecords().findRecordsByAssistant(resultado[0]));
                                request.getRequestDispatcher("/views/users/mainAssistant.jsp").forward(request, response);
                                request.getSession().setAttribute("usuariom2",nameUser2);
                                request.getSession().setAttribute("contram2",password2);
                            }else if(resultado[1] == 2){
                                request.setAttribute("listMinutes", new DaoRecords().findAllRecordsByManager(resultado[0]));
                                request.getRequestDispatcher("/views/users/mainManager.jsp").forward(request, response);
                                request.getSession().setAttribute("usuariom",nameUser2);
                                request.getSession().setAttribute("contram1",password2);
                            }else if(resultado[1] == 3){
                                request.setAttribute("listMinutes", new DaoRecords().findAllRecords(resultado[0]));
                                request.getRequestDispatcher("/views/users/mainOficialia.jsp").forward(request, response);
                                request.getSession().setAttribute("usuariom",nameUser2);
                                request.getSession().setAttribute("contram",password2);
                            }else if(resultado[1] == 4){
                                request.setAttribute("listMinutes", new DaoRecords().findAllRecords(resultado[0]));
                                request.getRequestDispatcher("/views/users/mainAdmin.jsp").forward(request, response);
                            }else{
                                request.getRequestDispatcher("/views/users/login.jsp").forward(request, response);
                            }

                             */
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        break;
                }
                break;
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
