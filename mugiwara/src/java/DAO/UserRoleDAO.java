/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author bayus
 */

import Models.UserRole;
import java.util.List;

public interface UserRoleDAO extends BaseDAO<UserRole, Integer> {
    
    /**
     * Find a role by name
     * @param roleName The role name to search for
     * @return The role if found, null otherwise
     */
    UserRole findByName(String roleName);
    
    /**
     * Get the default role
     * @return The default role
     */
    UserRole getDefaultRole();
    
    /**
     * Set a role as default
     * @param roleId The role ID
     * @return true if successful, false otherwise
     */
    boolean setAsDefault(int roleId);
}
