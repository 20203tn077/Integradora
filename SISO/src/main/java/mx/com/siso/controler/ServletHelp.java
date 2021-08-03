package mx.com.siso.controler;

import mx.com.siso.model.records.DaoRecords;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.model.users.DaoUsers;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ServletHelp", urlPatterns = {"/Login"})
public class ServletHelp extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
        switch (redirect) {
            case "login":
                request.getSession().removeAttribute("sessionRole");
                request.getSession().removeAttribute("sessionId");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        switch (action) {
            case "access":
                int[] result = new int[2];
                String loginUsername = request.getParameter("usernameInput") != null ? request.getParameter("usernameInput") : "";
                String loginPassword = request.getParameter("passwordInput") != null ? request.getParameter("passwordInput") : "";

                BeanUsers loginBeanUser = new BeanUsers(0, loginUsername, loginPassword, "", "", "", "", 0, "", null, null, null);
                try {
                    result = new DaoUsers().login(loginBeanUser);
                    if (result[1] >= 1 && result[1] <= 4) {
                        System.out.println("Tipo de usuario: " + result[1]);
                        System.out.println("Id de usuario: " + result[0]);
                        request.setAttribute("access", true);
                    }
                    switch (result[1]) {
                        case 1:
                            request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(result[0], (byte)1));
                            request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(result[0], (byte)1));
                            request.getRequestDispatcher("/views/assistant/record_list.jsp").forward(request, response);
                            break;
                        case 2:
                            break;
                        case 3:
                            break;
                        case 4:
                            break;
                        default:
                            //Aquí va el código para aumentar los intentos fallidos
                            request.setAttribute("messageType", 1); //Tipo de mensaje, varia el color y el ícono
                            request.setAttribute("message", ""); //Mensaje
                            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
                    }
                    /*if(result[1] == 1){
                        request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(result[0]));
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
                    }*/
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                request.setAttribute("sessionRole", result[1]);
                request.setAttribute("sessionId", result[0]);
                break;

        }
    }
}
