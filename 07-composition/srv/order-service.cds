using {learning.composition as comp} from '../db/schema';

service OrderService {

    entity Orders as projection on comp.Orders;

}