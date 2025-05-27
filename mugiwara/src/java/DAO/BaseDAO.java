package DAO;

/**
 *
 * @author bayus
 */

import java.util.List;

/**
 * Base interface for all DAO operations
 * @param <T> The entity type
 * @param <ID> The primary key type
 */
public interface BaseDAO<T, ID> {
    
    /**
     * Save an entity to the database
     * @param entity The entity to save
     * @return true if successful, false otherwise
     */
    boolean save(T entity);
    
    /**
     * Update an existing entity
     * @param entity The entity to update
     * @return true if successful, false otherwise
     */
    boolean update(T entity);
    
    /**
     * Delete an entity by ID
     * @param id The ID of the entity to delete
     * @return true if successful, false otherwise
     */
    boolean delete(ID id);
    
    /**
     * Find an entity by ID
     * @param id The ID of the entity to find
     * @return The entity if found, null otherwise
     */
    T findById(ID id);
    
    /**
     * Get all entities
     * @return A list of all entities
     */
    List<T> findAll();
}
