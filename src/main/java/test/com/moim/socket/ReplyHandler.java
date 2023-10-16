package test.com.moim.socket;


import org.springframework.web.socket.WebSocketSession;
import test.com.moim.Interceptor.SessionNames;
import test.com.moim.userinfo.model.UserinfoVO;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ServerEndpoint("/replyEcho")
public class ReplyHandler {

    List<Session> sessions = new ArrayList<>();
    Map<String, Session> userSession = new HashMap<>();

    @OnOpen
    public void onOpen(Session session){
        System.out.println("websocket open...ReplyHandler.java>>> "+ session);
        String senderId = getId(session);

        userSession.put(senderId, session);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("websocket onMessage...>> "+ session.getId()+" : " + message);
        String senderId = getId(session);

        String[] strs = message.split(",");

        if (strs!=null && strs.length==4) {
            System.out.println("if 구문 들어옴");
            String cmd = strs[0];
            String replyWriter = strs[1];
            String boardWriter = strs[2];
            String wnum = strs[3];

            if ("reply".equals(cmd)){
                System.out.println("2 번째 if 구문");
                try {
                    session.getBasicRemote().sendText(replyWriter+" 님이 "+ wnum+"번 게시글에 댓글을 달았습니다.");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    private String getId(Session session) {
        Map<String, Object> httpSession = session.getUserProperties();
        UserinfoVO loginUser = (UserinfoVO) httpSession.get(SessionNames.LOGIN);

        if (loginUser == null){
            return session.getId();
        } else
            return loginUser.getUser_id();
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("afterConnectionClosed:" + session + " : ");
    }
}
