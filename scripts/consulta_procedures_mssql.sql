select objects.name,objects.type,
modules.definition 
 from sys.sql_modules modules
 join sys.objects objects
 on objects.object_id=modules.object_id
 WHERE modules.definition like '%Person.Address%'
 and objects.type='P'
