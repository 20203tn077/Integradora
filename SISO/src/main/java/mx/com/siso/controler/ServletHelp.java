package mx.com.siso.controler;

import com.google.gson.Gson;
import mx.com.siso.model.records.DaoRecords;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.model.users.DaoUsers;

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
import java.util.Properties;
import java.util.Random;

@WebServlet(name = "ServletHelp", urlPatterns = {"/Inicio_de_Sesión", "/Inicio", "/Restablecer_Contraseña"})
public class ServletHelp extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
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
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        switch (action) {
            case "access":
                int resultado2[] = new int[2];
                int result[] = new int[4];

                String loginUsername = request.getParameter("usernameInput") != null ? request.getParameter("usernameInput") : "";
                String loginPassword = request.getParameter("passwordInput") != null ? request.getParameter("passwordInput") : "";
                int idUser2 = new DaoUsers().findIdByUsername(loginUsername);

                BeanUsers loginBeanUser = new BeanUsers(0, loginUsername, loginPassword, "", "", "", "", 0, "", null, null, null);

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
                                redirect(request,response,"/views/common/login.jsp", (byte)3, "Contraseña incorrecta, llevas " + (resultado2[0] + 1) + " intentos fallidos");
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
                        redirect(request,response,"/views/common/login.jsp", (byte)4, "Su cuenta ha sido bloqueada temporalmente");
                    }
                } else if (idUser2 == -1) {
                    try {
                        result = new DaoUsers().login(loginBeanUser);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (result[3] != 0){
                        System.out.println("Contraseña incorrecta");
                        request.getRequestDispatcher("/views/users/login.jsp").forward(request, response);

                    }else {
                        request.setAttribute("userList", new DaoUsers().findAllUsers());
                        redirect(request,response,"/views/admin/user_list.jsp");
                        request.getSession().setAttribute("sessionRole", result[1]);
                    }
                } else {
                    redirect(request,response,"/views/common/login.jsp", (byte)3, "El usuario ingresado no existe");
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
                String correo = request.getParameter("emailInput") != null ? request.getParameter("emailInput") : "";
                BeanUsers beanUsers = new BeanUsers(0,"","","","","",correo,0,parseToken,null,null,null);
                Properties props = System.getProperties();
                int recoveryId = new DaoUsers().checkEmail(beanUsers);
                if(recoveryId != -1) {
                    props.put("mail.smtp.host", "smtp.gmail.com");  //El servidor SMTP de Google
                    props.put("mail.smtp.user", "sisowebutez@gmail.com");
                    props.put("mail.smtp.auth", "true");    //Usar autenticación mediante usuario y clave
                    props.put("mail.smtp.starttls.enable", "true"); //Para conectar de manera segura al servidor SMTP
                    props.put("mail.smtp.port", "587"); //El puerto SMTP seguro de Google

                    Session session = Session.getDefaultInstance(props);
                    MimeMessage message = new MimeMessage(session);

                    try {
                        message.setFrom(new InternetAddress("sisowebutez@gmail.com"));
                        message.addRecipients(Message.RecipientType.TO, correo);   //Se podrían añadir varios de la misma manera
                        message.setSubject("Recuperacion de Contraseña Token");
                        message.setText("Este token de recuperacion, por favor introducelo en la casilla correspondiente: " + parseToken);
                        Transport transport = session.getTransport("smtp");
                        transport.connect("smtp.gmail.com", "sisowebutez@gmail.com", "sisoutez");
                        transport.sendMessage(message, message.getAllRecipients());
                        transport.close();
                        request.setAttribute("email", correo);
                        request.setAttribute("id", recoveryId);
                        request.getSession().setAttribute("recoveryId", recoveryId);
                        redirect(request,response,"/views/common/pswd_recover.jsp");
                    } catch (MessagingException me) {
                        me.printStackTrace();   //Si se produce un error
                    }
                }else{
                    System.out.println("El correo no es valido");
                    redirect(request,response,"/views/common/pswd_request.jsp", (byte)3, "El correo ingresado no es válido");
                }
break;
            case "tokenValidation":
                String recoveryToken = request.getParameter("tokenInput") != null ? request.getParameter("tokenInput") : "";
                String recoveryEmail= request.getParameter("recoveryEmail") != null ? request.getParameter("recoveryEmail") : "";
                int recoveryId2 = request.getParameter("recoveryId") != null ? Integer.parseInt(request.getParameter("recoveryId")) : -1;
                BeanUsers beanUsers1 = new BeanUsers(recoveryId2,"","","","","","",0,recoveryToken,null,null,null);

                if(new DaoUsers().checkToken(beanUsers1)){
                    System.out.println("Token coincide con Id");
                    request.setAttribute("id", recoveryId2);
                    redirect(request,response,"/views/common/pswd_new.jsp");
                }else{
                    System.out.println("Token no coincide");
                    request.setAttribute("email", recoveryEmail);
                    request.setAttribute("id", recoveryId2);
                    redirect(request,response,"/views/common/pswd_recover.jsp", (byte)3, "El token ingresado no es válido");
                }
                break;
            case "passwordChange":
                int recoveryId3 = request.getParameter("recoveryId") != null ? Integer.parseInt(request.getParameter("recoveryId")) : -1;
                String recoveryPassword = request.getParameter("passwordInput") != null ? request.getParameter("passwordInput") : "";
                if (Integer.parseInt(String.valueOf(request.getSession().getAttribute("recoveryId"))) == recoveryId3) {
                    BeanUsers passwordChangeUser = new DaoUsers().findUserById(recoveryId3);
                    passwordChangeUser.setPasswordUser(recoveryPassword);
                    try {
                        if (new DaoUsers().update(passwordChangeUser)) {
                            request.getSession().removeAttribute("recoveryId");
                            redirect(request,response,"/views/common/login.jsp", (byte)2, "Se ha actualizado tu contraseña, inicia sesión de nuevo.");
                        }
                    }catch (SQLException e) {
                        //No se pudo cambiar por alguna razón
                        redirect(request,response,"/views/common/login.jsp");
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
