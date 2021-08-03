package mx.com.siso.controler;

import mx.com.siso.model.department.DaoDepartment;
import mx.com.siso.model.records.DaoRecords;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.model.users.DaoUsers;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "Servlet", urlPatterns = {"/Gestión_de_Oficios", "/Gestión_de_Usuarios", "/Gestión_de_Auxiliares", "/Gestión_de_Departamentos", "/Modificar_Oficio", "/Modificar_Usuario", "/Modificar_Auxiliar", "/Modificar_Departamento", "/Nuevo_Oficio", "/Nuevo_Usuario", "/Nuevo_Auxiliar", "/Nuevo_Departamento", "/Perfil", "/Modificar_Datos", "/Canalizar_Oficio", "/Asignar_Oficio", "/Atender_Oficio"})
public class Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        /* El método get se usa para redirecciones que no necesiten ningún dato de la vista,
        las redirecciones posibles cambian en función del rol para evitar que se acceda a vistas que no corresponden al usuario */
        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
        byte sessionRole = Byte.parseByte(String.valueOf(request.getSession().getAttribute("sessionRole") != null ? request.getSession().getAttribute("sessionRole") : "0"));

        System.out.println(redirect);
        System.out.println(sessionRole);
        //División de acciones disponibles en función del rol de la sesión
        switch (sessionRole) {
            case 1:
                switch (redirect) {
                    case "records":
                        request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                        request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                        request.setAttribute("access",true);
                        request.getRequestDispatcher("/views/assistant/record_list.jsp").forward(request, response);
                        break;
                    case "profile":
                        request.setAttribute("access",true);
                        request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        request.getRequestDispatcher("/views/assistant/profile.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
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
