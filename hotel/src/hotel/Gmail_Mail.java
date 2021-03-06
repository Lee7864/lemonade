package hotel;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Gmail_Mail {

	static String Sender = "bigdata8686";
	static String SenderPw = "bigdata868686";
	
	public static void send(String title, String content, String Email) {
		
		Properties p = new Properties();
		p.put("mail.smtp.user", Sender+"@gmail.com"); 
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");

		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");

		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true); 

			MimeMessage msg = new MimeMessage(session);
			String message = content;
			msg.setSubject(title);
			
			Address fromAddr = new InternetAddress(Sender+"@gmail.com"); 
			msg.setFrom(fromAddr);
			
			Address toAddr = new InternetAddress(Email); 
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			if(Email.equals(Sender+"@gmail.com"))
				msg.setContent(message, "text/plain; charset=KSC5601");
			else
				msg.setContent(message, "text/html; charset=utf-8");
			Transport.send(msg);
			
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}

	private static class SMTPAuthenticator extends Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(Sender, SenderPw);
		}
	}
}





