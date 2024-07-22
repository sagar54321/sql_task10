select * from items

select * from shop_items

alter table items add profit varchar(10) not null default 'Yet to Get'

select  sum(s.qty) * sum(i.price) as "totalSales" from shop_items as s
	inner join items as i
	on s.item_id = i.id
	where s.item_id = 1 ;

    update items set total_sales = 180 where id = 1;

    update items set profit = 'Loss' where id= 1;

-- Create a Trigger for assigning Profit or Loss based on total sales while inserting.Condition(if total sales is greater than 200 than profit otherwise loss)?

create or replace function update_profit()
RETURNS TRIGGER AS $$
DECLARE ts int;
BEGIN
	select  sum(s.qty) * sum(i.price) into ts from shop_items as s
	inner join items as i
	on s.item_id = i.id
	where s.item_id = NEW.item_id;

    IF ts>200 THEN
		update items set total_sales = ts where id = NEW.item_id;
        update items set profit = 'PROFIT' where id= NEW.item_id;

    ELSE
		update items set total_sales = ts where id = NEW.item_id;
        update items set profit = 'LOSS' where id= NEW.item_id;
		
    RETURN NEW;
END IF;
END
$$ LANGUAGE plpgsql;

create trigger trigger_update_profit
AFTER INSERT ON shop_items
FOR EACH ROW
EXECUTE FUNCTION update_profit()

insert into shop_items values(3,'s10',54,true,10,4)



