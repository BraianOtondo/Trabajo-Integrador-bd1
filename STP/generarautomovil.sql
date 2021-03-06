use automotriz;
-- TERCERA ETAPA 
-- 8) dada la información de un pedido en
 -- particular, se generan los automóviles con la patente asignada al azar
DELIMITER $$
create procedure generarAutomoviles(in _id_modelo int,in id_pedido int, in _cantidad int)begin
declare i int default 0;
declare _nro_chasis int;
declare cantidadRepetida int default 0;
declare id_linea_ int default 0;
select id_linea from linea_de_montaje where modelo_id_modelo=_id_modelo into id_linea_;
simple_loop: LOOP
set i=i+1;
 IF i=_cantidad+1 THEN
            LEAVE simple_loop;
         END IF;
	select FLOOR(RAND()*(9999-1000)+1000) into _nro_chasis;
    set cantidadRepetida=0;
    select count(*) into cantidadRepetida from automovil where nro_chasis=_nro_chasis;
    while(cantidadRepetida>0)do
	select FLOOR(RAND()*(9999-1000)+1000) into _nro_chasis;
    select count(*) into cantidadRepetida from automovil where nro_chasis=_nro_chasis;
    end while;
    insert into automovil(nro_chasis, detalle_pedido_modelo_id_modelo, detalle_pedido_pedido_id_pedido, id_linea_asignada) values(_nro_chasis,_id_modelo,id_pedido,id_linea_);
   END LOOP simple_loop;

end  $$
DELIMITER ;
