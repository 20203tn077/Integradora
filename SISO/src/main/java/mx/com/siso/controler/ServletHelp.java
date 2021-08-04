package mx.com.siso.controler;

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
        String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : "";
        switch (redirect) {
            case "login":
                request.getSession().removeAttribute("sessionRole");
                request.getSession().removeAttribute("sessionId");
                request.getRequestDispatcher("/views/common/login.jsp").forward(request,response);
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
                    System.out.println("Id de usuario: " + result[0]);
                    System.out.println("Tipo de usuario: " + result[1]);
                    switch (result[1]) {
                        case 1:
                            request.setAttribute("recordList1", new DaoRecords().findRecordsByAssistant(result[0], (byte)1));
                            request.setAttribute("recordList2", new DaoRecords().findRecordsByAssistant(result[0], (byte)2));
                            request.setAttribute("access", true);
                            request.getRequestDispatcher("/views/assistant/record_list.jsp").forward(request, response);
                            break;
                        case 2:
                            request.setAttribute("recordList1", new DaoRecords().findAllRecordsByManager(result[0], (byte)1));
                            request.setAttribute("recordList2", new DaoRecords().findAllRecordsByManager(result[0], (byte)2));
                            request.setAttribute("recordList3", new DaoRecords().findAllRecordsByManager(result[0], (byte)3));
                            request.setAttribute("access", true);
                            request.getRequestDispatcher("/views/manager/record_list.jsp").forward(request, response);
                            break;
                        case 3:
                            request.setAttribute("recordList1", new DaoRecords().findAllRecords(result[0], (byte)1));
                            request.setAttribute("recordList2", new DaoRecords().findAllRecords(result[0], (byte)2));
                            request.setAttribute("access",true);
                            request.getRequestDispatcher("/views/oficialia/record_list.jsp").forward(request, response);
                            break;
                        case 4:
                            request.setAttribute("userList", new DaoUsers().findAllUsers());
                            request.setAttribute("access", true);
                            request.getRequestDispatcher("/views/admin/user_list.jsp").forward(request, response);
                            break;
                        default:
                            //Aquí va el código para aumentar los intentos fallidos
                            request.setAttribute("messageType", 3); //Tipo de mensaje, varia el color y el ícono
                            request.setAttribute("message", "El usuario ingresado no es válido"); //Mensaje
                            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                System.out.println("asdasdasd");
                request.getSession().setAttribute("sessionRole", result[1]);
                request.getSession().setAttribute("sessionId", result[0]);
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
                        request.setAttribute("access",true);
                        request.setAttribute("email", correo);
                        request.setAttribute("id", recoveryId);
                        request.getSession().setAttribute("recoveryId", recoveryId);
                        request.getRequestDispatcher("/views/common/pswd_recover.jsp").forward(request, response);
                    } catch (MessagingException me) {
                        me.printStackTrace();   //Si se produce un error
                    }
                }else{
                    System.out.println("El correo no es valido");
                    request.setAttribute("messageType", 3);
                    request.setAttribute("message", "El correo ingresado no es válido");
                    request.getRequestDispatcher("/views/common/pswd_request.jsp").forward(request, response);
                }
break;
            case "tokenValidation":
                String recoveryToken = request.getParameter("tokenInput") != null ? request.getParameter("tokenInput") : "";
                String recoveryEmail= request.getParameter("recoveryEmail") != null ? request.getParameter("recoveryEmail") : "";
                int recoveryId2 = request.getParameter("recoveryId") != null ? Integer.parseInt(request.getParameter("recoveryId")) : -1;
                BeanUsers beanUsers1 = new BeanUsers(recoveryId2,"","","","","","",0,recoveryToken,null,null,null);

                if(new DaoUsers().checkToken(beanUsers1)){
                    System.out.println("Token coincide con Id");
                    request.setAttribute("access",true);
                    request.setAttribute("id", recoveryId2);
                    request.getRequestDispatcher("/views/common/pswd_new.jsp").forward(request, response);
                }else{
                    System.out.println("Token no coincide");
                    request.setAttribute("messageType", 3);
                    request.setAttribute("message", "El token ingresado no es válido");
                    request.setAttribute("access",true);
                    request.setAttribute("email", recoveryEmail);
                    request.setAttribute("id", recoveryId2);
                    request.getRequestDispatcher("/views/common/pswd_recover.jsp").forward(request, response);
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
                            request.setAttribute("messageType", 2);
                            request.setAttribute("message", "Se ha actualizado tu contraseña, inicia sesión de nuevo.");
                            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
                        }
                    }catch (SQLException e) {
                        //No se pudo cambiar por alguna razón
                        request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
                    }
                } else {
                    //No coincide el token recibido con el que se intentaba cambiar
                    request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
                }

        }
    }
}
