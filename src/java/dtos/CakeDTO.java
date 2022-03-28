/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.io.Serializable;

public class CakeDTO implements Serializable {

    private int cakeID;
    private String cakeName;
    private float price;
    private String image;
    private int categoryID;
    private int quantity;
    private String category;
    private String createDate;
    private String expirationDate;
    private String description;
    private boolean status;

    public CakeDTO() {
    }

    public CakeDTO(int cakeID, String cakeName, String image) {
        this.cakeID = cakeID;
        this.cakeName = cakeName;
        this.image = image;
    }

    public CakeDTO(int cakeID, String cakeName, float price, String image, int categoryID, int quantity, String category, String createDate, String expirationDate, String description, boolean status) {
        this.cakeID = cakeID;
        this.cakeName = cakeName;
        this.price = price;
        this.image = image;
        this.categoryID = categoryID;
        this.quantity = quantity;
        this.category = category;
        this.createDate = createDate;
        this.expirationDate = expirationDate;
        this.description = description;
        this.status = status;
    }

    public int getCakeID() {
        return cakeID;
    }

    public void setCakeID(int cakeID) {
        this.cakeID = cakeID;
    }

    public String getCakeName() {
        return cakeName;
    }

    public void setCakeName(String cakeName) {
        this.cakeName = cakeName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
