<img 
  align="center" 
  height="240em" 
  width="100%" 
  src="https://media.istockphoto.com/photos/code-on-computer-monitor-with-database-and-server-room-background-of-picture-id1399945048?b=1&k=20&m=1399945048&s=170667a&w=0&h=OQnLuxWQpiXkxw-8udoPjmfrnprejmV4nMm-npHxT0U="
/>

# SQLWorkbench-

I mistyped "-" on the repository name

## SELECT <> FROM WHERE

## SQL JOINS 

## VIEWS

## SUB SELECTS

## AGRUPMENTS

## IF STATEMENT

## CASE WHEN 

## FUNCTIONS
```
DELIMITER $$
CREATE FUNCTION function_name (parameters_names types)
RETURNS type
DETERMINISTIC                             /* Needs this if declare variables */
  BEGIN 
    DECLARE variable_name type;
    ...
    RETURN variable_name;
  END $$
DELIMITER ;
```

## STORED PROCEDURES
```
DELIMITER $$
CREATE PROCEDURE procedure_name(
  IN parameter_name type_parameter,       /* Those are the input parameters, what will be passed to call the procedure */
  OUT parameter_name type_parameter       /* Those are the output parameters, what will be returned after the procedure */
) BEGIN
    ...
  END $$
DELIMITER ;
```

## TRIGGERS
```
DELIMITER $$
  CREATE TRIGGER tr_name() operation_time
  ON table_name
  FOR EACH ROW
    BEGIN 
      ...
    END $$
DELIMITER ;
```

### Calling and Deleting Triggers & Procedures
```
/* Calling */
  CALL procedure_name(in_parameters, @out_parameter)
  SELECT @out_parameter
  
  Triggers don't need to be called
  
/* Deleting */
  DROP PROCEDURE procedure_name
  DROP TRIGGER trigger_name
```
