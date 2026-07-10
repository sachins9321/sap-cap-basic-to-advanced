namespace learning.composition;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Orders : cuid, managed {

    orderNumber : String(30);
    customerName : String(100);
    orderDate : Date;
    Items : Composition of many OrderItems
            on Items.parent = $self;

}

entity OrderItems {

    key parent : Association to Orders;
    key itemNo : Integer;
    productName : String(100);
    quantity : Integer;
    price : Decimal(15,2);

}