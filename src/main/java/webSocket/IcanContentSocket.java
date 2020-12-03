package webSocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/IcanContent")
public class IcanContentSocket {

	Map sessions = new HashMap();
	
	@OnOpen
	public void onOpen(Session session) {
		System.out.println("WebSocket opened: " + session.getId());
	}
	
	@OnClose
	public void onClose(CloseReason reason) {
		System.out.println("Closing a WebSocket due to " + reason.getReasonPhrase());
	}
	
	@OnMessage
	public String onMessage(String data, Session session) {
        System.out.println("Received : "+ data);
        try {
        	for (Session s: session.getOpenSessions())
			s.getBasicRemote().sendText(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
        return data;
	}
}
