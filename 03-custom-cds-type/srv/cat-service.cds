using {com.acc.customtype as my } from '../db/schema';
service ProductService @(path:'/browse') {
    
    entity Products as projection on my.ProductEntity;
    entity PharmaProducts as projection on my.PharmProductEntity;
    entity Customers as projection on my.CustomerEntity;

}