package info.gezielcarvalho.service;

import info.gezielcarvalho.entity.Ticket;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class TicketService {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("TicketPU");
    private static final Logger logger = LoggerFactory.getLogger(TicketService.class);

    public List<Ticket> getAllTickets() {
        logger.info("Fetching all tickets from the database");
        EntityManager em = emf.createEntityManager();
        List<Ticket> tickets = em.createQuery("SELECT t FROM Ticket t", Ticket.class).getResultList();
        em.close();
        logger.info("Fetched {} tickets", tickets.size());
        return tickets;
    }

    public void createTicket(Ticket ticket) {
        logger.info("Creating a new ticket: {}", ticket.getTitle());
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(ticket);
        em.getTransaction().commit();
        em.close();
        logger.info("Ticket created successfully with ID: {}", ticket.getId());
    }
}
