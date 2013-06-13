<%-- 
    Document   : index
    Created on : May 19, 2012, 10:55:29 AM
    Author     : Quest
--%>


<%@page import="java.util.HashMap"%>
<%@page import="com.qaccess.net.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login | Quest</title>
        <%
         String name=request.getParameter("username");
         String pass=request.getParameter("pass");
         String loginStatus=doWebLogin(request, name, pass); 
         if(loginStatus!=null && loginStatus.equals("loginsuccess")){
           // out.println("<a href=service.jsp>Service</a>");
            response.sendRedirect("service.jsp");
         }       

         %>
         
         <%!
        public static String doWebLogin( HttpServletRequest request,  String name, String pass){
         String rHost=request.getRemoteHost();
         HttpSession ses= request.getSession(true);
         Object attr= ses.getAttribute("client");
          Client anonClient=null;
           if(name!=null && pass!=null){
              if(attr==null){
                 try{
                   anonClient=new Client("localhost",1720);
                   request.getSession(true).setAttribute("client", anonClient);
                   }
                 catch(Exception e){
                     
                 }
                 
                 }
                else{
                 anonClient=(Client)ses.getAttribute("client");
                 }
             HashMap props=new HashMap();
             props.put("username", name);
             props.put("password",pass);
             props.put("clientip", rHost);
             try{
             anonClient.send(new Response(props,"login"));
             Response res=anonClient.getServerResponse();
               return res.getResponse().toString();
                }
             catch(Exception e){
                 try{
                 anonClient=new Client("localhost",1720);
                 request.getSession(true).setAttribute("client", anonClient);
                 anonClient.send(new Response(props,"login"));
                 Response res=anonClient.getServerResponse();
                 return res.getResponse().toString();
                 }
                 catch(Exception ex){
                   
                 }
              }
            
           }
          return null;
         
        }
    

         
     
       public static void doWebLogout(HttpServletRequest request,  String name){
           HttpSession ses=request.getSession();
            Client client=(Client)ses.getAttribute("client");
             client.disconnect();   
       }



       %>
        
    </head> 
    <body>
        <form method=GET action="index.jsp">
            UserName: <input type="text"   name="username"/>
            <br>
            <br>
           PassWord: <input type="text"   name="pass"/>
           <br>
            <input type="submit" value="Login"/>
        </form>
        
    </body>
</html>
 