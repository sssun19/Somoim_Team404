package test.com.moim.socket;


import org.apache.tools.ant.util.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import test.com.moim.Interceptor.SessionNames;
import test.com.moim.userinfo.model.UserinfoVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReplyEchoHandler extends TextWebSocketHandler {

//    List<WebSocketSession> sessions = new ArrayList<>();
    Map<String, WebSocketSession> userSessions = new HashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception { //connection 이 연결 됐을 때
        System.out.println("afterConnectionEstablished:" + session);
        String senderId = getId(session);

        userSessions.put(senderId, session);

    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { //socket에 message를 보냈을 때
        System.out.println("handleTextMessage:" + session + " : " + message);
        String senderId = getId(session);
//        for (WebSocketSession sess: sessions) {
//            sess.sendMessage(new TextMessage(senderId+": "+ message.getPayload()));
//        }
        //protocol : cmd, 댓글 작성자, 게시글 작성자, wnum (reply, user2, user1, 121)
        String msg = message.getPayload();
        //if (StringUtils.hasText(msg)) {
            String[] strs = msg.split(",");
            if (strs!=null && strs.length==4){
                String cmd = strs[0];
                String replyWriter = strs[1];
                String boardWriter = strs[2];
                String wnum = strs[3];

                WebSocketSession boardWriterSession = userSessions.get(boardWriter);
                if ("reply".equals(cmd) && boardWriterSession != null){
                    TextMessage tmpMsg = new TextMessage(replyWriter+" 님이 "+ wnum+"번 게시글에 댓글을 달았습니다.");
                    boardWriterSession.sendMessage(tmpMsg);
                }
            }
        //}
    }

    private String getId(WebSocketSession session) {
        Map<String, Object> httpSession = session.getAttributes();
        UserinfoVO loginUser = (UserinfoVO) httpSession.get(SessionNames.LOGIN);
        if (loginUser == null){
            return session.getId();
        } else
            return loginUser.getUser_id();
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception { //connection close 됐을 때
        System.out.println("afterConnectionClosed:" + session + " : " + status);

    }
}
