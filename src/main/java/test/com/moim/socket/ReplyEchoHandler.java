package test.com.moim.socket;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.List;

public class ReplyEchoHandler extends TextWebSocketHandler {

    List<WebSocketSession> sessions = new ArrayList<>();


    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception { //connection 이 연결 됐을 때
        System.out.println("afterConnectionEstablished:" + session);
        sessions.add(session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { //socket에 message를 보냈을 때
        System.out.println("handleTextMessage:" + session + " : " + message);
        String senderId = session.getId();
        for (WebSocketSession sess: sessions) {
            sess.sendMessage(new TextMessage(senderId+": "+ message.getPayload()));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception { //connection close 됐을 때
        System.out.println("afterConnectionClosed:" + session + " : " + status);

    }
}
