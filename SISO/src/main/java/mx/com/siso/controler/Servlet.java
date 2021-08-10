package mx.com.siso.controler;

import com.google.gson.Gson;
import mx.com.siso.model.department.BeanDepartment;
import mx.com.siso.model.department.DaoDepartment;
import mx.com.siso.model.records.BeanRecords;
import mx.com.siso.model.records.DaoRecords;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.model.users.DaoUsers;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "Servlet", urlPatterns = {"/Servlet", "/Gestión_de_Oficios", "/Gestión_de_Usuarios", "/Gestión_de_Auxiliares", "/Gestión_de_Departamentos", "/Modificar_Oficio", "/Modificar_Usuario", "/Modificar_Auxiliar", "/Modificar_Departamento", "/Nuevo_Oficio", "/Nuevo_Usuario", "/Nuevo_Auxiliar", "/Nuevo_Departamento", "/Perfil", "/Modificar_Datos", "/Canalizar_Oficio", "/Asignar_Oficio", "/Atender_Oficio", "/Visualizar_Oficio"})
public class Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
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
                        redirect(request,response,"/views/assistant/record_list.jsp");
                        break;
                    case "profile":
                        request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        redirect(request,response,"/views/assistant/profile.jsp");
                        break;
                    case "dataModify":
                }
                break;
            case 2:
                switch (redirect) {
                    case "records":
                        request.setAttribute("recordList1", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                        request.setAttribute("recordList2", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                        request.setAttribute("recordList3", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)3));
                        redirect(request,response,"/views/manager/record_list.jsp");
                        break;
                    case "assistants":
                        request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        redirect(request,response,"/views/manager/assistant_list.jsp");
                        break;
                    case "profile":
                        request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        redirect(request,response,"/views/manager/profile.jsp");
                        break;
                    case "dataModify":
                        redirect(request,response,"/views/manager/data_modify.jsp");
                        break;
                    case "recordAssign":
                        redirect(request,response,"/views/manager/record_assign.jsp");
                        break;
                    case "recordReassign":
                        redirect(request,response,"/views/manager/record_reassign.jsp");
                        break;
                    case "assistantRegister":
                        redirect(request,response,"/views/manager/assistant_register.jsp");
                        break;
                    case "assistantModify":
                        redirect(request,response,"/views/manager/assistant_modify.jsp");
                }
                break;
            case 3:
                switch (redirect) {
                    case "records":
                        request.setAttribute("recordList1", new DaoRecords().findAllRecords(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                        request.setAttribute("recordList2", new DaoRecords().findAllRecords(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                        redirect(request,response,"/views/oficialia/record_list.jsp");
                        break;
                    case "profile":
                        request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        redirect(request,response,"/views/oficialia/profile.jsp");
                        break;
                    case "dataModify":
                        redirect(request,response,"/views/oficialia/data_modify.jsp");
                        break;
                    case "recordRegister":
                        redirect(request,response,"/views/oficialia/record_register.jsp");
                        break;
                    case "recordRechannelling":
                        redirect(request,response,"/views/oficialia/record_rechannelling.jsp");
                }
                break;
            case 4:
                switch (redirect) {
                    case "users":
                        request.setAttribute("userList", new DaoUsers().findAllUsers());
                        redirect(request,response,"/views/admin/user_list.jsp");
                        break;
                    case "departments":
                        request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                        redirect(request,response,"/views/admin/department_list.jsp");
                        break;
                    case "profile":
                        redirect(request,response,"/views/admin/profile.jsp");
                        break;
                    case "dataModify":
                        redirect(request,response,"/views/admin/data_modify.jsp");
                        break;
                    case "userRegister":
                        redirect(request,response,"/views/admin/user_register.jsp");
                        break;
                    case "userModify":
                        redirect(request,response,"/views/admin/user_modify.jsp");
                        break;
                    case "departmentRegister":
                        redirect(request,response,"/views/admin/department_register.jsp");
                        break;
                    case "departmentModify":
                        redirect(request,response,"/views/admin/department_modify.jsp");
                }
                break;
            default:

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map map = new HashMap();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        System.out.println("pruebaaa" + action);
        String sessionRole = String.valueOf(request.getSession().getAttribute("sessionRole") != null ? request.getSession().getAttribute("sessionRole") : "");
        System.out.println(sessionRole);
        //División de acciones disponibles en función del rol de la sesión
        switch (sessionRole) {
            case "1":
                switch (action) {
                    case "getRecordDetails":
                        sendJSON(response, new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                        break;
                }
                break;
            case "2":
                switch (action) {
                    case "getAssistantDetails":
                        BeanUsers assistant = new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id")));
                        assistant.setPasswordUser("");
                        sendJSON(response, assistant);
                        break;
                    case "deleteAssistant":
                        new DaoUsers().delete(Integer.parseInt(request.getParameter("id")));
                        request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        redirect(request, response, "/views/manager/assistant_list.jsp", (byte)2, "El auxiliar ha sido eliminado");
                        break;
                    case "getRecordDetails":
                        sendJSON(response, new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                        break;
                }
                break;
            case "3":
                switch (action) {
                    case "":
                        break;
                    case "getRecordDetails":
                        sendJSON(response, new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                        break;
                }
                break;
            case "4":
                switch (action) {
                    case "getUserDetails":
                        BeanUsers user = new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id")));
                        user.setPasswordUser("");
                        sendJSON(response, user);
                        break;
                    case "deleteUser":
                        new DaoUsers().delete(Integer.parseInt(request.getParameter("id")));
                        request.setAttribute("userList", new DaoUsers().findAllUsers());
                        redirect(request, response, "/views/admin/user_list.jsp", (byte)2, "El usuario ha sido eliminado");
                        break;
                    case "getDepartmentDetails":
                        sendJSON(response, new DaoDepartment().findDepartmentById(Long.parseLong(request.getParameter("id"))));
                        break;
                    case "deleteDepartment":
                        new DaoDepartment().delete(Integer.parseInt(request.getParameter("id")));
                        request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                        redirect(request, response, "/views/admin/department_list.jsp", (byte)2, "El departamento ha sido eliminado");
                        break;
                }
                break;
            default:

        }
        if (sessionRole.equals("1") ||sessionRole.equals("2") ||sessionRole.equals("3")) {
            switch (action) {
                case "viewRecordFile":
                    response.setContentType("application/pdf");
                    int recordId = Integer.parseInt(request.getParameter("id") != null ? request.getParameter("id") : "");
                    response.getOutputStream().write(new DaoRecords().findRecordFile(recordId));
                    break;
            }
        }

    }

    void redirect(HttpServletRequest request, HttpServletResponse response, String url, byte messageType, String message) throws ServletException, IOException {
        request.setAttribute("messageType", messageType);
        request.setAttribute("message", message);
        request.setAttribute("access", true);
        request.getRequestDispatcher(url).forward(request,response);
    }

    void redirect(HttpServletRequest request, HttpServletResponse response, String url) throws ServletException, IOException {
        request.setAttribute("access", true);
        request.getRequestDispatcher(url).forward(request,response);
    }

    void sendJSON (HttpServletResponse response, Object obj) throws IOException{
        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(obj));
    }
}
