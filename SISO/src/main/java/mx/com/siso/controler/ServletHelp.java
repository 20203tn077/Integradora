package mx.com.siso.controler;

import com.google.gson.Gson;
import mx.com.siso.model.records.DaoRecords;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.model.users.DaoUsers;
import mx.com.siso.tool.Email;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;

@WebServlet(name = "ServletHelp", urlPatterns = {"/Inicio_de_Sesión", "/Inicio", "/Restablecer_Contraseña"})
public class ServletHelp extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String redirect = request.getParameter("redirect") != "" ? request.getParameter("redirect") : "";
        switch (redirect) {
            case "login":
                request.getSession().removeAttribute("sessionRole");
                request.getSession().removeAttribute("sessionId");
                redirect(request,response,"/views/common/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") != "" ? request.getParameter("action") : "";
        switch (action) {
            case "access":
                int resultado2[] = new int[2];
                int result[] = new int[4];

                String loginUsername = request.getParameter("usernameInput") != "" ? request.getParameter("usernameInput") : "";
                String loginPassword = request.getParameter("passwordInput") != "" ? request.getParameter("passwordInput") : "";
                int idUser2 = new DaoUsers().findIdByUsername(loginUsername);

                BeanUsers loginBeanUser = new BeanUsers();
                loginBeanUser.setNameUser(loginUsername);
                loginBeanUser.setPasswordUser(loginPassword);

                if (idUser2 != 0 && idUser2 != -1){
                    resultado2 = new DaoUsers().findAttempts(idUser2);
                    if (resultado2[0] == 3 && resultado2[1] > 30){
                        new DaoUsers().restartAttempts(idUser2);
                    }
                    resultado2 = new DaoUsers().findAttempts(idUser2);
                    if (resultado2[0] < 3 && resultado2[1] == -1){
                        try {
                            result = new DaoUsers().login(loginBeanUser);
                            System.out.println("Id de usuario: " + result[0]);
                            System.out.println("Tipo de usuario: " + result[1]);
                            if (result[3] != 0){
                                new DaoUsers().increaseAttempts(result[0]);
                                redirect(request,response,"/views/common/login.jsp", (byte)3, "Contraseña incorrecta, " + (3 - (resultado2[0] + 1)) + " intentos restantes.");
                            }else {
                                new DaoUsers().restartAttempts(result[0]);
                                System.out.println("Contraseña correcta");
                                System.out.println("Tipo de usuario: " + result[1]);
                                System.out.println("Id de usuario: " + result[0]);

                                switch (result[1]) {
                                    case 1:
                                        request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(result[0], (byte)1));
                                        request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(result[0], (byte)2));
                                        redirect(request,response,"/views/assistant/record_list.jsp");
                                        break;
                                    case 2:
                                        request.setAttribute("recordList1", new DaoRecords().findAllRecordsByManager(result[0], (byte)1));
                                        request.setAttribute("recordList2", new DaoRecords().findAllRecordsByManager(result[0], (byte)2));
                                        request.setAttribute("recordList3", new DaoRecords().findAllRecordsByManager(result[0], (byte)3));
                                        redirect(request,response,"/views/manager/record_list.jsp");
                                        break;
                                    case 3:
                                        request.setAttribute("recordList1", new DaoRecords().findAllRecords(result[0], (byte)1));
                                        request.setAttribute("recordList2", new DaoRecords().findAllRecords(result[0], (byte)2));
                                        redirect(request,response,"/views/oficialia/record_list.jsp");
                                    default:
                                }
                                request.getSession().setAttribute("sessionRole", result[1]);
                                request.getSession().setAttribute("sessionId", result[0]);
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }else if (resultado2[0] == 3 && resultado2[1] >= 0 && resultado2[1] < 31){
                        redirect(request,response,"/views/common/login.jsp", (byte)4, "Su cuenta ha sido bloqueada temporalmente.");
                    }
                } else if (idUser2 == -1) {
                    try {
                        result = new DaoUsers().login(loginBeanUser);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (result[3] != 0){
                        System.out.println("Contraseña incorrecta");
                        redirect(request,response,"/views/common/login.jsp", (byte)3, "Contraseña incorrecta.");
                    }else {
                        request.setAttribute("userList", new DaoUsers().findAllUsers());
                        redirect(request,response,"/views/admin/user_list.jsp");
                        request.getSession().setAttribute("sessionRole", result[1]);
                    }
                } else {
                    redirect(request,response,"/views/common/login.jsp", (byte)3, "El usuario ingresado no es válido.");
                }
                break;
            case "newPasswordRequest":
                int longitud = 10;
                String alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                StringBuilder token = new StringBuilder();
                Random rnd = new Random();

                for (int i = 0; i < longitud; i++)
                {
                    int indice = rnd.nextInt(alfabeto.length());
                    token.append(alfabeto.charAt(indice));
                }
                String parseToken = String.valueOf(token);
                String correo = request.getParameter("emailInput") != "" ? request.getParameter("emailInput") : "";
                BeanUsers beanUsers = new BeanUsers();
                beanUsers.setEmail(correo);
                beanUsers.setToken(parseToken);
                int recoveryId = new DaoUsers().checkEmail(beanUsers);
                if(recoveryId != -1) {
                    request.setAttribute("email", correo);
                    request.setAttribute("id", recoveryId);
                    request.getSession().setAttribute("recoveryId", recoveryId);
                    redirect(request,response,"/views/common/pswd_recover.jsp");
                    ArrayList<String> emails = new ArrayList<String>();
                    emails.add(correo);
                    new Email(emails, "Código de recuperación", "Ha solicitado restablecer su contraseña, utilice el siguente código para continuar con el proceso: " + parseToken + ". El código es válido durante los siguientes 30 minutos.").start();
                }else{
                    System.out.println("El correo no es valido");
                    redirect(request,response,"/views/common/pswd_request.jsp", (byte)3, "El correo ingresado no es válido.");
                }
                break;
            case "tokenValidation":
                String recoveryToken = request.getParameter("tokenInput") != "" ? request.getParameter("tokenInput") : "";
                String recoveryEmail= request.getParameter("recoveryEmail") != "" ? request.getParameter("recoveryEmail") : "";
                int recoveryId2 = request.getParameter("recoveryId") != "" ? Integer.parseInt(request.getParameter("recoveryId")) : -1;
                BeanUsers beanUsers1 = new BeanUsers();
                beanUsers1.setId_user(recoveryId2);
                beanUsers1.setToken(recoveryToken);

                if(new DaoUsers().checkToken(beanUsers1)){
                    System.out.println("Token coincide con Id");
                    request.setAttribute("id", recoveryId2);
                    redirect(request,response,"/views/common/pswd_new.jsp");
                }else{
                    System.out.println("Token no coincide");
                    request.setAttribute("email", recoveryEmail);
                    request.setAttribute("id", recoveryId2);
                    redirect(request,response,"/views/common/pswd_recover.jsp", (byte)3, "El código ingresado no es válido.");
                }
                break;
            case "passwordChange":
                int recoveryId3 = request.getParameter("recoveryId") != "" ? Integer.parseInt(request.getParameter("recoveryId")) : -1;
                String recoveryPassword = request.getParameter("passwordInput") != "" ? request.getParameter("passwordInput") : "";
                if (Integer.parseInt(String.valueOf(request.getSession().getAttribute("recoveryId"))) == recoveryId3) {
                    BeanUsers passwordChangeUser = new DaoUsers().findUserById(recoveryId3);
                    passwordChangeUser.setPasswordUser(recoveryPassword);

                        if (new DaoUsers().update(passwordChangeUser)[0] == 1) {
                            new DaoUsers().restartAttempts(recoveryId3);
                            request.getSession().removeAttribute("recoveryId");
                            redirect(request,response,"/views/common/login.jsp", (byte)2, "Su contraseña ha sido actualizada exitosamente.");
                        }
                } else {
                    //No coincide el token recibido con el que se intentaba cambiar
                    redirect(request,response,"/views/common/login.jsp");
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
}
