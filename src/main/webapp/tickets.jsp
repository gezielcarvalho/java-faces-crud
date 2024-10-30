<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="info.gezielcarvalho.entity.Ticket" %>
<%@ page import="info.gezielcarvalho.entity.Status" %>
<%@ page import="info.gezielcarvalho.service.TicketService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Helpdesk Tickets 4</title>
</head>
<body>
    <h1>Helpdesk Ticket List</h1>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Created Date</th>
        </tr>
        <%
            TicketService ticketService = new TicketService();
            List<Ticket> tickets = ticketService.getAllTickets();
            for (Ticket ticket : tickets) {
        %>
        <tr>
            <td><%= ticket.getId() %></td>
            <td><%= ticket.getTitle() %></td>
            <td><%= ticket.getDescription() %></td>
            <td><%= ticket.getStatus() %></td>
            <td><%= ticket.getCreatedDate() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
