package info.gezielcarvalho.service;

import info.gezielcarvalho.entity.Ticket;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class TicketService {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("TicketPU");

    public List<Ticket> getAllTickets() {
        EntityManager em = emf.createEntityManager();
        List<Ticket> tickets = em.createQuery("SELECT t FROM Ticket t", Ticket.class).getResultList();
        em.close();
        return tickets;
    }
}
