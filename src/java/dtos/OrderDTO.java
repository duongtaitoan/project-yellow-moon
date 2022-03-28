/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.io.Serializable;
import java.util.ArrayList;

public class OrderDTO implements Serializable {

    private int orderID;
    private String userID;
    private float totalPrice;
    private String date;
    private String phoneNumber;
    private String fullName;
    private String paymentMethod;
    private String paymentStatus;
    private String shippingAddress;
    private ArrayList<CakeDTO> listOfCake;

    public OrderDTO() {
    }

    public OrderDTO(int orderID, String userID, float totalPrice, String date, String phoneNumber, String fullName, String paymentMethod, String paymentStatus, String shippingAddress, ArrayList<CakeDTO> listOfCake) {
        this.orderID = orderID;
        this.userID = userID;
        this.totalPrice = totalPrice;
        this.date = date;
        this.phoneNumber = phoneNumber;
        this.fullName = fullName;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.shippingAddress = shippingAddress;
        this.listOfCake = listOfCake;
    }

    public ArrayList<CakeDTO> getListOfCake() {
        return listOfCake;
    }

    public void setListOfCake(ArrayList<CakeDTO> listOfCake) {
        this.listOfCake = listOfCake;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "OrderDTO{" + "orderID=" + orderID + ", userID=" + userID + ", totalPrice=" + totalPrice + ", date=" + date + ", phoneNumber=" + phoneNumber + ", fullName=" + fullName + ", paymentMethod=" + paymentMethod + ", paymentStatus=" + paymentStatus + ", shippingAddress=" + shippingAddress + ", listOfCake=" + listOfCake + '}';
    }

}
