using my.salesorder as my from '../db/order-data-model';

service SalesOrderService @(path:'/SalesOrderService') 
{
    entity SalesOrders     as projection on my.SalesOrders;
    entity SalesOrderItems as projection on my.SalesOrderItems;
    entity Customers as projection on my.Customers;
    entity Addresses as projection on my.Addresses; 
}