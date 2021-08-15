package mx.com.siso.controler;

import com.google.gson.Gson;
import mx.com.siso.model.administrador.BeanAdministrador;
import mx.com.siso.model.administrador.DaoAdministrator;
import mx.com.siso.model.department.BeanDepartment;
import mx.com.siso.model.department.DaoDepartment;
import mx.com.siso.model.priority.BeanPriority;
import mx.com.siso.model.priority.DaoPriority;
import mx.com.siso.model.records.BeanRecords;
import mx.com.siso.model.records.DaoRecords;
import mx.com.siso.model.response_file.BeanResponse_file;
import mx.com.siso.model.response_file.DaoResponse;
import mx.com.siso.model.user_type.BeanUser_type;
import mx.com.siso.model.user_type.DaoUser_type;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.model.users.DaoUsers;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "Servlet", urlPatterns = {"/Servlet", "/Gestión_de_Oficios", "/Gestión_de_Usuarios", "/Gestión_de_Auxiliares", "/Gestión_de_Departamentos", "/Modificar_Oficio", "/Modificar_Usuario", "/Modificar_Auxiliar", "/Modificar_Departamento", "/Nuevo_Oficio", "/Nuevo_Usuario", "/Nuevo_Auxiliar", "/Nuevo_Departamento", "/Perfil", "/Modificar_Datos", "/Canalizar_Oficio", "/Recanalizar_Oficio", "/Asignar_Oficio", "/Reasignar_Oficio", "/Atender_Oficio", "/Visualizar_Oficio", "/Visualizar_Archivo"})
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
                        BeanUsers user = new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))));
                        user.setPasswordUser(null);
                        request.setAttribute("user", user);
                        redirect(request,response,"/views/assistant/data_modify.jsp");
                        break;
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
                        BeanUsers user = new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))));
                        user.setPasswordUser(null);
                        request.setAttribute("user", user);
                        redirect(request,response,"/views/manager/data_modify.jsp");
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
                        BeanUsers user = new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))));
                        user.setPasswordUser(null);
                        request.setAttribute("user", user);
                        redirect(request,response,"/views/oficialia/data_modify.jsp");
                        break;
                    case "recordRegister":
                        request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                        request.setAttribute("priorityList", new DaoPriority().findPriority());
                        redirect(request,response,"/views/oficialia/record_register.jsp");
                        break;
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
                        BeanAdministrador beanAdministrador1 = new DaoAdministrator().findAdministrator();
                        beanAdministrador1.setPasswordAdmin(null);
                        request.setAttribute("admin", beanAdministrador1);
                        redirect(request,response,"/views/admin/profile.jsp");
                        break;
                    case "dataModify":
                        BeanAdministrador beanAdministrador2 = new DaoAdministrator().findAdministrator();
                        beanAdministrador2.setPasswordAdmin(null);
                        request.setAttribute("admin", beanAdministrador2);
                        redirect(request,response,"/views/admin/data_modify.jsp");
                        break;
                    case "userRegister":
                        request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                        request.setAttribute("roleList", new DaoUser_type().findUserType());
                        redirect(request,response,"/views/admin/user_register.jsp");
                        break;
                    case "departmentRegister":
                        redirect(request,response,"/views/admin/department_register.jsp");
                        break;
                }
                break;
            default:
                redirect(request, response, "/views/common/login.jsp", (byte)1, "La sesión ha expirado, vuelve a iniciar sesión");
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
        //División de acciones disponibles en función del rol de la sesión
        switch (sessionRole) {
            case "1":
                switch (action) {
                    case "redirect":
                        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
                        switch (redirect) {
                            case "recordAttend":
                                request.setAttribute("recordId", request.getParameter("id"));
                                redirect(request,response,"/views/assistant/record_attend.jsp");
                                break;
                        }
                        break;
                    case "attendRecord":
                        boolean flag = false;
                        int[] resultado = new int[3];
                        BeanResponse_file beanResponse_file = null;
                        int idRecord = Integer.parseInt(request.getParameter("recordId")!= null ? request.getParameter("recordId") : "");
                        String comment = request.getParameter("commentInput")!= null ? request.getParameter("commentInput") : "";
                        BeanRecords beanRecords = new BeanRecords(idRecord,null,0,null,null,null,comment,0,null,null,null);
                        beanResponse_file = new BeanResponse_file(0, "", beanRecords);
                        InputStream inputStream = null;
                        System.out.println(idRecord);
                        System.out.println(comment);
                        Collection<Part> fileParts = request.getParts().stream().filter(part -> "filesInput".equals(part.getName()) && part.getSize() > 0).collect(Collectors.toList());
                        if(fileParts.size() == 0){
                            System.out.println("En caso de que no haya ingresado un PDF pero si un comentario");
                            try {
                                resultado = new DaoResponse().createResponse(beanResponse_file, inputStream);
                                if(resultado[0] == 1){
                                    new DaoResponse().changeAttended(beanResponse_file);
                                    request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                                    request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                                    redirect(request,response,"/views/assistant/record_list.jsp", (byte)2, "El oficio se atendió correctamente");
                                }else {
                                    request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                                    request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                                    redirect(request,response,"/views/assistant/record_list.jsp", (byte)2, "El oficio no se atendió correctamente");
                                }

                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }else{
                            System.out.println("En caso de que haya ingresado un PDF y un comentario");
                            for (Part filePart : fileParts) {
                                System.out.println(filePart.getSize());
                                inputStream  = filePart.getInputStream();
                                beanResponse_file = new BeanResponse_file(0,null,beanRecords);
                                try {
                                    resultado = new DaoResponse().createResponse(beanResponse_file, inputStream);
                                    flag = true;

                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                            System.out.println(resultado[0]);
                            if (flag){
                                if(resultado[0] == 1){
                                    try {
                                        new DaoResponse().changeAttended(beanResponse_file);
                                        request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                                        request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                                        redirect(request,response,"/views/assistant/record_list.jsp", (byte)2, "El oficio se atendió correctamente");
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }

                                }else {
                                    request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                                    request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                                    redirect(request,response,"/views/assistant/record_list.jsp", (byte)2, "El oficio no se atendió correctamente");
                                }
                            }
                        }
                        break;
                }
                break;
            case "2":
                switch (action) {
                    case "redirect":
                        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
                        switch (redirect) {
                            case "recordAssign":
                                request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                                request.setAttribute("recordId", request.getParameter("id"));
                                redirect(request,response,"/views/manager/record_assign.jsp");
                                break;
                            case "recordReassign":
                                request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                                request.setAttribute("record", new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                                redirect(request,response,"/views/manager/record_reassign.jsp");
                                break;
                        }
                        break;
                    case "getAssistantDetails":
                        BeanUsers assistant = new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id")));
                        assistant.setPasswordUser(null);
                        sendJSON(response, assistant);
                        break;
                    case "deleteAssistant":
                        new DaoUsers().delete(Integer.parseInt(request.getParameter("id")));
                        request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        redirect(request, response, "/views/manager/assistant_list.jsp", (byte)2, "El auxiliar ha sido eliminado");
                        break;
                    case "assignRecord":
                        int[] resultado3 = new int[4];
                        int idAssistant = request.getParameter("assistantInput") != null ? Integer.parseInt(request.getParameter("assistantInput")) : 0;
                        int idRecord = Integer.parseInt(request.getParameter("recordId") != null ? request.getParameter("recordId") : "");
                        BeanUsers beanUsers = new BeanUsers();
                        beanUsers.setId_user(idAssistant);
                        BeanRecords beanRecords = new BeanRecords(idRecord, null, 0, null, null, null, "", 0, null, beanUsers, null);
                        try {
                            resultado3 = new DaoRecords().assignRecord(beanRecords);
                            if(resultado3[0] == 1) {
                                request.setAttribute("recordList1", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                                request.setAttribute("recordList2", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                                request.setAttribute("recordList3", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)3));
                                redirect(request,response,"/views/manager/record_list.jsp", (byte)2, "El oficio se asignó de forma correcta");
                            }else{
                                if (resultado3[1] == 1) {
                                    System.out.println("El usuario no existe");
                                }
                                if (resultado3[2] == 1){
                                    System.out.println("El oficio no existe");
                                }else {
                                    if (resultado3[3] == 1){
                                        System.out.println("El oficio ya esta asignado");
                                    }
                                }
                            }
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                        break;
                    case "registerAssistant":
                        int resultado;
                        String nameUser = request.getParameter("usernameInput") != null ? request.getParameter("usernameInput") : "";
                        String password = request.getParameter("passwordInput")!= null ? request.getParameter("passwordInput") : "";
                        String name = request.getParameter("nameInput")!= null ? request.getParameter("nameInput") : "";
                        String lastname1 = request.getParameter("lastname1Input")!= null ? request.getParameter("lastname1Input") : "";
                        String lastname2 = request.getParameter("lastname2Input")!= null ? request.getParameter("lastname2Input") : "";
                        String email = request.getParameter("emailInput")!= null ? request.getParameter("emailInput") : "";
                        BeanUser_type beanUser_type = new BeanUser_type(1, "");
                        BeanDepartment beanDepartment = new BeanDepartment(new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))).getDepartment_id().getIdDepartment(), "", "", "", 0);
                        BeanUsers beanUsers1 = new BeanUsers(0, nameUser, password, name, lastname1, lastname2, email,0, "", null,0, "", beanDepartment, beanUser_type);
                        try {
                            resultado = new DaoUsers().create(beanUsers1);
                            switch (resultado){
                                case 1:
                                    request.setAttribute("userList", new DaoUsers().findAllUsers());
                                    redirect(request,response,"/views/manager/assistant_list.jsp", (byte)2, "Se ha registrado correctamente");
                                    break;
                                case 2:
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    redirect(request,response,"/views/manager/assistant_register.jsp", (byte)3, "El nombre de usuario ya está registrado");
                                    break;
                                case 3:
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    redirect(request,response,"/views/manager/assistant_register.jsp", (byte)3, "El correo ya está registrado");
                                    break;
                                case 4:
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    redirect(request,response,"/views/manager/assistant_register.jsp", (byte)3, "El nombre de usuario y el correo ya están registrados");
                                    break;
                            }

                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                        break;
                    case "reassignRecord":
                        int[] resultado5 = new int[4];
                        int idRecord1 = Integer.parseInt(request.getParameter("id"));
                        int idAssistant1 = Integer.parseInt(request.getParameter("assistantInput"));
                        resultado5 = new DaoRecords().reassignRecord(idRecord1,idAssistant1);

                        if (resultado5[0] == 1){
                            request.setAttribute("recordList1", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                            request.setAttribute("recordList2", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                            request.setAttribute("recordList3", new DaoRecords().findAllRecordsByManager(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)3));
                            redirect(request,response,"/views/manager/record_list.jsp", (byte)2, "Se reasignó correctamente");
                        }else {
                            if (resultado5[1] == 1){
                                request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                                request.setAttribute("record", new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                                redirect(request,response,"/views/manager/record_reassign.jsp", (byte)3, "No existe el oficio");
                            } else {
                                if (resultado5[2] ==1){
                                    request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                                    request.setAttribute("record", new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                                    redirect(request,response,"/views/manager/record_reassign.jsp", (byte)3, "Ya esta atendido");
                                }
                            }
                            if (resultado5[3] == 1){
                                request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                                request.setAttribute("record", new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                                redirect(request,response,"/views/manager/record_reassign.jsp", (byte)3, "El auxiliar no existe");
                            }
                        }
                        break;
                }
                break;
            case "3":
                switch (action) {
                    case "redirect":
                        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
                        switch (redirect) {
                            case "recordAssign":
                                request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                                request.setAttribute("recordId", request.getParameter("id"));
                                redirect(request,response,"/views/manager/record_assign.jsp");
                                break;
                            case "recordRechannelling":
                                request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                request.setAttribute("record", new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                                redirect(request,response,"/views/oficialia/record_rechannelling.jsp");
                                break;
                        }
                        break;
                    case "createRecord":
                        int[] resultado2 = new int[3];
                        int department = Integer.parseInt(request.getParameter("departmentInput")!= null ? request.getParameter("departmentInput") : "0");
                        int priority = Integer.parseInt(request.getParameter("priorityInput")!= null ? request.getParameter("priorityInput") : "0");
                        BeanDepartment beanDepartment = new BeanDepartment(department, "", "","",0);
                        BeanPriority beanPriority = new BeanPriority(priority, "");
                        InputStream inputStream = null;
                        System.out.println(department);
                        System.out.println(priority);
                        try {
                            Part filePart = request.getPart("fileInput");
                            if (filePart.getSize() > 0) {
                                System.out.println(filePart.getName());
                                System.out.println(filePart.getSize());
                                System.out.println(filePart.getContentType());
                                inputStream = filePart.getInputStream();
                                BeanRecords beanRecords = new BeanRecords(0, inputStream, 0, null, null, null,"", 0, beanDepartment, null, beanPriority);
                                resultado2 = new DaoRecords().createRecord(beanRecords);
                                if(resultado2[0] == 1){
                                    request.setAttribute("recordList1", new DaoRecords().findAllRecords(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                                    request.setAttribute("recordList2", new DaoRecords().findAllRecords(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                                    redirect(request,response,"/views/oficialia/record_list.jsp", (byte)2, "El oficio se registró correctamente");
                                }else{
                                    if(resultado2[1] == 1){
                                        request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                        request.setAttribute("priorityList", new DaoPriority().findPriority());
                                        redirect(request,response,"/views/oficialia/record_register.jsp", (byte)3, "El departamento seleccionado no existe");
                                    }
                                    if(resultado2[2] == 1){
                                        request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                        request.setAttribute("priorityList", new DaoPriority().findPriority());
                                        redirect(request,response,"/views/oficialia/record_register.jsp", (byte)3, "La prioridad seleccionada no existe");
                                    }
                                    System.out.println("pruebaif");
                                }
                            }
                            System.out.println("pruebasize");
                        } catch (Exception ex) {
                            System.out.println("fichero: "+ ex.getMessage());
                        }
                        break;
                    case "rechannelRecord":
                        int idRecord = Integer.parseInt(request.getParameter("id"));
                        int idDepartment = Integer.parseInt(request.getParameter("departmentInput"));
                        if (new DaoRecords().changeDepartment(idRecord, idDepartment)){
                            request.setAttribute("recordList1", new DaoRecords().findAllRecords(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)1));
                            request.setAttribute("recordList2", new DaoRecords().findAllRecords(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))), (byte)2));
                            redirect(request,response,"/views/oficialia/record_list.jsp", (byte)2, "Se ha hecho la recanalización correctament");
                        }else {
                            request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                            request.setAttribute("record", new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                            redirect(request,response,"/views/oficialia/record_rechannelling.jsp", (byte)3, "No se realizó la recanalización");
                        }
                        break;
                }
                break;
            case "4":
                switch (action) {
                    case "redirect":
                        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
                        switch (redirect) {
                            case "recordAssign":
                                request.setAttribute("assistantList", new DaoUsers().findAllAssitant(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                                request.setAttribute("recordId", request.getParameter("id"));
                                redirect(request,response,"/views/manager/record_assign.jsp");
                                break;
                            case "userModify":
                                request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                request.setAttribute("roleList", new DaoUser_type().findUserType());
                                request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id"))));
                                redirect(request,response,"/views/admin/user_modify.jsp");
                                break;
                            case "departmentModify":
                                request.setAttribute("department", new DaoDepartment().findDepartmentById2(Long.parseLong(request.getParameter("id"))));
                                redirect(request,response,"/views/admin/department_modify.jsp");
                                break;
                        }
                        break;
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
                    case "modifyData":
                        BeanAdministrador beanAdministrador = new DaoAdministrator().findAdministrator();
                        String id = beanAdministrador.getNameAdmin();
                        beanAdministrador.setNameAdmin(request.getParameter("usernameInput"));
                        if (request.getParameter("passwordInput")!="") {
                            beanAdministrador.setPasswordAdmin(request.getParameter("passwordInput"));
                        }
                        if (new DaoAdministrator().update(beanAdministrador, id)){
                            BeanAdministrador beanAdministrador1 = new DaoAdministrator().findAdministrator();
                            beanAdministrador1.setPasswordAdmin(null);
                            request.setAttribute("admin", beanAdministrador1);
                            redirect(request,response,"/views/admin/profile.jsp",(byte)2,"Se ha actualizado correctamente");
                        }else {
                            BeanAdministrador beanAdministrador1 = new DaoAdministrator().findAdministrator();
                            beanAdministrador1.setPasswordAdmin(null);
                            request.setAttribute("admin", beanAdministrador1);
                            redirect(request,response,"/views/admin/data_modify.jsp",(byte)3,"El nombre de usuario ya está registrado");
                        }
                        break;
                    case "registerUser":
                        int resultado3;
                        String nameUser = request.getParameter("usernameInput") != null ? request.getParameter("usernameInput") : "";
                        String password = request.getParameter("passwordInput")!= null ? request.getParameter("passwordInput") : "";
                        String name = request.getParameter("nameInput")!= null ? request.getParameter("nameInput") : "";
                        String lastname1 = request.getParameter("lastname1Input")!= null ? request.getParameter("lastname1Input") : "";
                        String lastname2 = request.getParameter("lastname2Input")!= null ? request.getParameter("lastname2Input") : "";
                        int departmentId = Integer.parseInt(request.getParameter("departmentInput")!= "" ? request.getParameter("departmentInput") : "0");
                        int type = Integer.parseInt(request.getParameter("roleInput")!= null ? request.getParameter("roleInput") : "0");
                        String email = request.getParameter("emailInput")!= null ? request.getParameter("emailInput") : "";

                        BeanUser_type beanUser_type = new BeanUser_type(type, "");
                        BeanDepartment beanDepartment = new BeanDepartment(departmentId, "", "", "", 0);
                        BeanUsers beanUsers = new BeanUsers(0, nameUser, password, name, lastname1, lastname2, email,0, "", null,0, "", beanDepartment, beanUser_type);

                        try {
                            resultado3 = new DaoUsers().create(beanUsers);
                            switch (resultado3){
                                case 1:
                                    request.setAttribute("userList", new DaoUsers().findAllUsers());
                                    redirect(request,response,"/views/admin/user_list.jsp", (byte)2, "Se ha registrado correctamente");
                                    break;
                                case 2:
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    redirect(request,response,"/views/admin/user_register.jsp", (byte)3, "El nombre de usuario ya está registrado");
                                    break;
                                case 3:
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    redirect(request,response,"/views/admin/user_register.jsp", (byte)3, "El correo ya está registrado");
                                    break;
                                case 4:
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    redirect(request,response,"/views/admin/user_register.jsp", (byte)3, "El nombre de usuario y el correo ya están registrados");
                                    break;
                            }

                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                        break;
                    case "registerDepartment":
                        String nameDepartment = request.getParameter("nameInput") != null ? request.getParameter("nameInput") : "";
                        String description = request.getParameter("descriptionInput")!= null ? request.getParameter("descriptionInput") : "";
                        String telephoneNumber = request.getParameter("phoneInput")!= null ? request.getParameter("phoneInput") : "";

                        BeanDepartment beanDepartment1 = new BeanDepartment(0, nameDepartment, description, telephoneNumber, 0);

                        try {
                            if(new DaoDepartment().create(beanDepartment1)){
                                request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                redirect(request,response,"/views/admin/department_list.jsp", (byte)2, "Departamento registrado correctamente");
                                break;
                            } else {
                                redirect(request,response,"/views/admin/department_register.jsp", (byte)3, "Departamento no registrado");
                            }
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                        break;
                    case "modifyUser":
                        int[] resultado4 = new int[6];
                        int departmentId1 = Integer.parseInt(request.getParameter("departmentInput")!= null ? request.getParameter("departmentInput") : "0");
                        int type1 = Integer.parseInt(request.getParameter("roleInput")!= null ? request.getParameter("roleInput") : "0");

                        BeanUser_type beanUser_type1 = new BeanUser_type(type1, "");
                        BeanDepartment beanDepartment2 = new BeanDepartment(departmentId1, "", "", "", 0);
                        BeanUsers beanUsers1 = new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id")));
                        if (request.getParameter("passwordInput") != "") {
                            beanUsers1.setPasswordUser(request.getParameter("passwordInput"));
                        }
                        beanUsers1.setNameUser(request.getParameter("usernameInput"));
                        beanUsers1.setName(request.getParameter("nameInput"));
                        beanUsers1.setLastname1(request.getParameter("lastname1Input"));
                        beanUsers1.setLastname2(request.getParameter("lastname2Input"));
                        beanUsers1.setEmail(request.getParameter("emailInput"));
                        beanUsers1.setDepartment_id(beanDepartment2);
                        beanUsers1.setType_id(beanUser_type1);
                            resultado4 = new DaoUsers().update(beanUsers1);
                            if(resultado4[0]==1){
                                request.setAttribute("userList", new DaoUsers().findAllUsers());
                                redirect(request,response,"/views/admin/user_list.jsp", (byte)2, "La actualización se realizó correctamente");
                            }else{
                                if(resultado4[1]==1){
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id"))));
                                    redirect(request,response,"/views/admin/user_modify.jsp", (byte)3, "El usuario no es válido");
                                }else{
                                    if (resultado4[2] ==1 && resultado4[3]==1){
                                        request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                        request.setAttribute("roleList", new DaoUser_type().findUserType());
                                        request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id"))));
                                        redirect(request,response,"/views/admin/user_modify.jsp", (byte)3, "El usuario y correo ya están registrados");
                                    } else{
                                        if(resultado4[2]==1){
                                            request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                            request.setAttribute("roleList", new DaoUser_type().findUserType());
                                            request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id"))));
                                            redirect(request,response,"/views/admin/user_modify.jsp", (byte)3, "El nombre se usuario ya se encuentra registrado");
                                        }else if(resultado4[3]==1){
                                            request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                            request.setAttribute("roleList", new DaoUser_type().findUserType());
                                            request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id"))));
                                            redirect(request,response,"/views/admin/user_modify.jsp", (byte)3, "El correo ya se encuentra registrado");
                                        }
                                    }
                                }
                                if(resultado4[4]==1){
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id"))));
                                    redirect(request,response,"/views/admin/user_modify.jsp", (byte)3, "El departamento no es válido");
                                }
                                if(resultado4[5]==1){
                                    request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                    request.setAttribute("roleList", new DaoUser_type().findUserType());
                                    request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(request.getParameter("id"))));
                                    redirect(request,response,"/views/admin/user_modify.jsp", (byte)3, "El tipo de usuario no es válido");
                                }
                            }
                        break;
                    case "modifyDepartment":
                        int [] resultado2 = new int[3];
                        int idDepartment = Integer.parseInt(request.getParameter("id")!= null ? request.getParameter("id") : "");
                        String nameDepartment1 = request.getParameter("nameInput") != null ? request.getParameter("nameInput") : "";
                        String description1 = request.getParameter("descriptionInput")!= null ? request.getParameter("descriptionInput") : "";
                        String telephoneNumber1 = request.getParameter("phoneInput")!= null ? request.getParameter("phoneInput") : "";

                        BeanDepartment beanDepartment3 = new BeanDepartment(idDepartment, nameDepartment1, description1, telephoneNumber1, 0);

                        try {
                            resultado2 = new DaoDepartment().update(beanDepartment3);
                            if(resultado2[0] ==1){
                                request.setAttribute("departmentList", new DaoDepartment().findDepartment());
                                redirect(request,response,"/views/admin/department_list.jsp", (byte)2, "Se modifico correctamente");
                            }else{
                                if(resultado2[1]==1){
                                    request.setAttribute("department", new DaoDepartment().findDepartmentById2(Long.parseLong(request.getParameter("id"))));
                                    redirect(request,response,"/views/admin/department_modify.jsp", (byte)3, "El departamento no existe");
                                }else{
                                    if(resultado2[2]==1){
                                        request.setAttribute("department", new DaoDepartment().findDepartmentById2(Long.parseLong(request.getParameter("id"))));
                                        redirect(request,response,"/views/admin/department_modify.jsp", (byte)3, "El nombre ya existe");
                                    }

                                }
                            }
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                        break;
                }
                break;
            default:
                redirect(request, response, "/views/common/login.jsp", (byte)1, "La sesión ha expirado, vuelve a iniciar sesión");
        }
        if (sessionRole.equals("1") ||sessionRole.equals("2") ||sessionRole.equals("3")) {
            switch (action) {
                case "viewRecordFile":
                    response.setContentType("application/pdf");
                    int recordId = Integer.parseInt(request.getParameter("id") != null ? request.getParameter("id") : "");
                    response.getOutputStream().write(new DaoRecords().findRecordFile(recordId));
                    break;
                case "getRecordDetails":
                    sendJSON(response, new DaoRecords().findRecordById(Integer.parseInt(request.getParameter("id"))));
                    break;
                case "getResponseList":
                    sendJSON(response, new DaoResponse().findResponse(Integer.parseInt(request.getParameter("id"))));
                    break;
                case "viewResponseFile":
                    response.setContentType("application/pdf");
                    int responseId = Integer.parseInt(request.getParameter("id") != null ? request.getParameter("id") : "");
                    response.getOutputStream().write(Base64.getDecoder().decode(new DaoResponse().findResponseById(responseId)));
                    break;
                case "modifyData":
                    BeanUsers beanUsers1 = new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))));
                    if (request.getParameter("usernameInput") != null) {
                        beanUsers1.setNameUser(request.getParameter("usernameInput"));
                    }
                    if (request.getParameter("nameInput") != null) {
                        beanUsers1.setName(request.getParameter("nameInput"));
                    }
                    if (request.getParameter("lastname1Input") != null) {
                        beanUsers1.setLastname1(request.getParameter("lastname1Input"));
                    }
                    beanUsers1.setLastname2(request.getParameter("lastname2Input"));
                    if (request.getParameter("emailInput") != null) {
                        beanUsers1.setEmail(request.getParameter("emailInput"));
                    }
                    if (request.getParameter("passwordInput") != null && request.getParameter("passwordInput") != "") {
                        beanUsers1.setPasswordUser(request.getParameter("passwordInput"));
                    }
                    int[] resultado4 = new int[6];
                    resultado4 = new DaoUsers().update(beanUsers1);
                    if(resultado4[0]==1){
                        request.setAttribute("user", new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId")))));
                        redirect(request,response,"/views/assistant/profile.jsp", (byte)2, "La actualización se realizó correctamente");
                    }else{
                        if(resultado4[1]==1){
                            BeanUsers user = new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))));
                            user.setPasswordUser(null);
                            request.setAttribute("user", user);
                            redirect(request,response,"/views/assistant/data_modify.jsp", (byte)3, "El usuario no es válido");
                        }else{
                            if(resultado4[2]==1){
                                BeanUsers user = new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))));
                                user.setPasswordUser(null);
                                request.setAttribute("user", user);
                                redirect(request,response,"/views/assistant/data_modify.jsp", (byte)3, "El nombre se usuario ya se encuentra registrado");
                            }else if(resultado4[3]==1){
                                BeanUsers user = new DaoUsers().findUserById(Integer.parseInt(String.valueOf(request.getSession().getAttribute("sessionId"))));
                                user.setPasswordUser(null);
                                request.setAttribute("user", user);
                                redirect(request,response,"/views/assistant/data_modify.jsp", (byte)3, "El correo ya se encuentra registrado");
                            }
                        }
                    }
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
