<%-- 
    Document   : service
    Created on : May 25, 2012, 9:32:14 AM
    Author     : Quest
--%>

<%@page import="java.util.Properties"%>
<%@page import="com.qaccess.net.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="index.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quest | Service</title>
        <%
         String key=request.getParameter("key");
         Properties prop=null;
         if(key!=null){
           if(key.equals("1")){
            String searchText= request.getParameter("search");
              if("".equals(searchText) || searchText==null){
                 
                    }
                   else{
               Client client=(Client)request.getSession().getAttribute("client");
               client.send(new Request("dataAccess","search",searchText));
               out.println("Search data "+searchText+" sent");
               Response res=client.getServerResponse();
               prop= (Properties)res.getResponse();
              }
           }
                     
            else if(key.equals("2")){
                String name= request.getParameter("name");
                String age= request.getParameter("age");
                String email= request.getParameter("email");
                String website= request.getParameter("website"); 
                String city= request.getParameter("city"); 
                if(name.equals("") || name.equals(null)){
                    out.println("Fill all the fields");
                    return;
                }
                if(age.equals("") || age.equals(null)){
                    out.println("Fill all the fields");
                    return;
                }
                if(email.equals("") || email.equals(null)){
                    out.println("Fill all the fields");
                    return;
                }
                if(website.equals("") || website.equals(null)){
                    out.println("Fill all the fields");
                    return;
                }
                if(city.equals("") || city.equals(null)){
                    out.println("Fill all the fields");
                    return;
                }
                prop=new Properties();
                prop.setProperty("name", name);
                prop.setProperty("age", age);
                prop.setProperty("email", email);
                prop.setProperty("website",website);
                prop.setProperty("city",city);
                Client client=(Client)session.getAttribute("client");
                client.send(new Request("dataAccess","update",prop));
                out.println("Update data sent successfully");
                Response res=client.getServerResponse();
                String msg=res.getMessage();
                 if(msg.equals("success")){
                 out.println("Client successfully created");
                  } 
                  else if(msg.equals("exists")){
                    out.println("Client already exists"); 
                  }
                                   
                     }
                     else if(key.equals("3")){
                       Client client=(Client)session.getAttribute("client");
                       client.send(new Request("logoutclient"));
                 }
           }
         %>
    </head>
    <body>
        <hr>
    <h>Search | Quest</h>
        <form METHOD="GET" action="service.jsp">
          <input type="text" name="search"/> 
          <input type="hidden" name="key" value="1"/> 
          <input type="submit" value="Search"/>
          <%
           if(prop!=null){
              out.println("<table width=20% height=20% border=0>") ;
               out.println("<tr><td>Age: </td><td>"+prop.getProperty("age") +"</td></tr>");
               out.println("<tr><td>City: </td><td>"+prop.getProperty("city") +"</td></tr>");
               out.println("<tr><td>Website: </td><td>"+prop.getProperty("website") +"</td></tr>");
               out.println("<tr><td>Email: </td><td>"+prop.getProperty("email") +"</td></tr>");
             }
          %>
        </form>
        
        <br>
        <br>
        <hr>
        <form METHOD="GET" action="service.jsp">
            <table width="30%" height="50%" cellspacing="0" border="0">
                <tr>
                    <td> Name:</td><td> <input type="text" name="name"/> </td> 
            </tr>
            <br>
            <tr>
                <td> Age:</td><td> <input type="text" name="age"/></td>
            </tr>
             <br>
             
             <tr>
                 <td>Email:</td><td> <input type="text" name="email"/> </td> 
             </tr>
             <br>
             
             <tr>
                 <td>Website:</td><td> <input type="text" name="website"/></td>
             </tr>
           <br>
           <tr>
               <td>City:</td><td> <input type="text" name="city"/></td>
           </tr>
           <br>
           <input type="hidden" name="key" value="2"/> 
            </table>
           <input type="submit" value="Update"/>
         </form>
        
       <form action="service.jsp">
     <input type="hidden" name="key" value="3"/>
     <input type="submit" value="Log out"/>
      </form>                   
    </body>
</html>
