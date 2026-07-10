namespace my.bookshop;

entity Books {
    key ID       : Integer;
        title    : String(100);
        author   : String(100);
        price    : Decimal(9,2);
}
