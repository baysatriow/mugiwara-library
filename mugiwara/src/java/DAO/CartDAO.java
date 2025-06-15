/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Cart;
import Models.CartItem;
import Models.Customer;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class CartDAO extends Models<Cart> {

    private int cart_id;
    private Customer customer;
    private List<CartItem> items;

    public CartDAO() {
        this.table = "cart";
        this.primaryKey = "cart_id";
    }

    @Override
    Cart toModel(ResultSet rs) {
        Cart cart = new Cart();
        try {
            cart.setCart_id(rs.getInt("cart_id"));
            cart.setCustomer(new CustomerDAO().find(rs.getString("customer_id")));
            cart.setItems(new CartItemDAO().find(rs.getString("cart_id")));
        } catch (SQLException e) {
            setMessage("Error mapping Book: " + e.getMessage());
        }
        return cart;
    }

    // Tambah keranjang baru
    public void addCart(Cart cart) {
        this.cart_id = cart.getCart_id();
        this.customer = cart.getCustomer();
        super.insert();
        setMessage(super.getMessage());
    }

    // Hapus keranjang
    public void deleteCart(int cartId) {
        this.cart_id = cartId;
        super.delete();
        setMessage(super.getMessage());
    }

    // Hapus semua item dari keranjang
    public void clearCart(int cartId) {
        CartItemDAO itemDAO = new CartItemDAO();
        itemDAO.deleteItemsByCartId(cartId);
        setMessage(itemDAO.getMessage());
    }

    // Hitung total harga dari semua item
    public int getTotalPrice(int cartId) {
        List<CartItem> items = new CartItemDAO().getItemsByCartId(cartId);
        int total = 0;
        for (CartItem item : items) {
            total += item.getBook().getPrice() * item.getQuantity();
        }
        return total;
    }

    // Update kuantitas item
    public void updateItemQuantity(int cartItemId, int quantity) {
        CartItemDAO itemDAO = new CartItemDAO();
        itemDAO.updateQuantity(cartItemId, quantity);
        setMessage(itemDAO.getMessage());
    }

    // Hapus item tertentu dari cart
    public void removeItem(int cartItemId) {
        CartItemDAO itemDAO = new CartItemDAO();
        itemDAO.deleteItem(cartItemId);
        setMessage(itemDAO.getMessage());
    }

    // Checkout keranjang dan simpan ke tabel order (tapi masih bingung)
    public void checkout(int cartId) {
        Cart cart = this.find(String.valueOf(cartId));
        if (cart == null) {
            setMessage("Checkout gagal: Cart tidak ditemukan.");
            return;
        }

        Order order = new Order();
        order.setCustomer(cart.getCustomer());
        order.setTotalAmount(getTotalPrice(cartId));
        order.setItems(cart.getItems());

        OrderDAO orderDAO = new OrderDAO();
        orderDAO.addOrder(order);

        if (orderDAO.getMessage().startsWith("info")) {
            // Jika berhasil, kosongkan keranjang
            clearCart(cartId);
            setMessage("Checkout berhasil..");
        } else {
            setMessage("Checkout gagal: " + orderDAO.getMessage());
        }
    }
}
