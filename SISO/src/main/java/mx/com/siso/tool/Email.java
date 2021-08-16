package mx.com.siso.tool;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.ArrayList;
import java.util.Properties;

public class Email extends Thread{
    String subject, body;
    ArrayList<String> adresses = new ArrayList<String>();

    public Email(ArrayList<String> adresses, String subject, String body) {
        this.subject = subject;
        this.body = body;
        this.adresses = adresses;
    }

    public void run() {
        Properties props = System.getProperties();
        props.put("mail.smtp.host", "smtp.gmail.com");  //El servidor SMTP de Google
        props.put("mail.smtp.user", "sisowebutez@gmail.com");
        props.put("mail.smtp.auth", "true");    //Usar autenticación mediante usuario y clave
        props.put("mail.smtp.starttls.enable", "true"); //Para conectar de manera segura al servidor SMTP
        props.put("mail.smtp.port", "587"); //El puerto SMTP seguro de Google

        Session session = Session.getDefaultInstance(props);
        MimeMessage message = new MimeMessage(session);

        try {
            message.setFrom(new InternetAddress("sisowebutez@gmail.com"));
            for (String address : adresses) {
                message.addRecipients(Message.RecipientType.TO, address);   //Se podrían añadir varios de la misma manera
            }
            message.setSubject(subject);
            message.setText(body);
            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", "sisowebutez@gmail.com", "sisoutez");
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
        } catch (MessagingException me) {
            me.printStackTrace();   //Si se produce un error
        }
    }
}
