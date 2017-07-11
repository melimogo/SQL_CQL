-- Esto nos trae la cantidad disponible del producto que se acabo de vender y
-- lo guardamos v_nmcantidad_producto
SET v_nmcantidad_producto = (SELECT nmcantidad from productos where id = new.producto_id);

-- nos trae el limite de productos que se pueden tener disponibles
SET v_preorden = (select preorden from productos where id = new.producto_id);
SET v_proveedor_id = (select persona_id from productos where id = new.producto_id);
if v_nmcantidad_producto < v_preorden then
SET v_insert_plan = (SELECT COUNT(*) FROM planes_compras WHERE producto_id = new.producto_id group by producto_id);

if v_insert_plan IS NULL then
insert into planes_compras (producto_id, persona_id) values(new.producto_id, v_proveedor_id);
elseif (v_proveedor_id <> (SELECT persona_id from planes_compras where id = new.producto_id)) then
update planes_compras
set persona_id = v_proveedor_id
where producto_id = new.producto_id;			
end if;			
end if;