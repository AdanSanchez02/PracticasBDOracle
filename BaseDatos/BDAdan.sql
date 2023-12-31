---- REALIZAR LA BASE DE DATOS QUE TIENEN EN ESTE GESTOR
-- NORMALIZADO
-- SECUENCIA
-- TIGGER
 ----------TABLA TIENDA ++ --
CREATE TABLE TIENDA(
ID NUMBER PRIMARY KEY NOT NULL,
NOMBRE NVARCHAR2(50)
);

CREATE SEQUENCE SECTIENDA
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRITIENDA
    BEFORE INSERT
    ON TIENDA
    FOR EACH ROW
    BEGIN
        SELECT SECTIENDA.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA DOMICILIO ++  --
CREATE TABLE DOMICILIO(
CP NUMBER PRIMARY KEY NOT NULL,
CIUDAD NVARCHAR2(50) NOT NULL,
COLONIA NVARCHAR2(50) NOT NULL
);

---------- TABLA UBICACION ++ --
CREATE TABLE UBICACION(
ID NUMBER PRIMARY KEY NOT NULL,
ID_DOMICILIO NUMBER NOT NULL,
TEL NUMBER NOT NULL,
FOREIGN KEY(ID_DOMICILIO) REFERENCES DOMICILIO(CP)
);

CREATE SEQUENCE SECUBICACION
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRIUBICACION
    BEFORE INSERT
    ON UBICACION
    FOR EACH ROW
    BEGIN
        SELECT SECUBICACION.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA SUCURSAL ++ --
CREATE TABLE SUCURSAL(
ID NUMBER PRIMARY KEY NOT NULL,
ID_TIENDA NUMBER NOT NULL,
NOMBRE NVARCHAR2(50),
ID_UBICACION NUMBER NOT NULL,
FOREIGN KEY(ID_TIENDA) REFERENCES TIENDA(ID),
FOREIGN KEY(ID_UBICACION) REFERENCES UBICACION(ID) 
);

CREATE SEQUENCE SECSUCURSAL
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRISUCURSAL
    BEFORE INSERT
    ON SUCURSAL
    FOR EACH ROW
    BEGIN
        SELECT SECSUCURSAL.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA PUESTOS ++ --
CREATE TABLE PUESTOS(
ID NUMBER PRIMARY KEY NOT NULL,
PUESTO NVARCHAR2(50) NOT NULL,
SALARIO NUMBER NOT NULL,
PRESTACION NVARCHAR2(50) NOT NULL
);

CREATE SEQUENCE SECPUESTO
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRIPUESTO
    BEFORE INSERT
    ON PUESTOS
    FOR EACH ROW
    BEGIN
        SELECT SECPUESTO.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA EMPLEADOS ++ --
CREATE TABLE EMPLEADOS(
ID NUMBER PRIMARY KEY NOT NULL,
ID_SUCURSAL NUMBER NOT NULL,
ID_DOMICILIO NUMBER NOT NULL,
ID_PUESTO NUMBER NOT NULL,
NOMBRE NVARCHAR2(50) NOT NULL,
TEL NUMBER NOT NULL,
NSS NUMBER NOT NULL,
CLABE NUMBER NOT NULL,
FOREIGN KEY(ID_SUCURSAL) REFERENCES SUCURSAL(ID),
FOREIGN KEY(ID_DOMICILIO) REFERENCES DOMICILIO(CP),
FOREIGN KEY(ID_PUESTO) REFERENCES PUESTOS(ID)
);

CREATE SEQUENCE SECEMPLEADOS
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRIEMPLEADOS
    BEFORE INSERT
    ON EMPLEADOS
    FOR EACH ROW
    BEGIN
        SELECT SECEMPLEADOS.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA PROVEEDORES -- ANEXAR TABLA DE PRODUCTO ++ --
CREATE TABLE PROVEEDOR(
ID NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(50) NOT NULL,
PRODUCTO NVARCHAR2(50) NOT NULL,
PRECIOU NUMBER NOT NULL,
CANTIDAD NUMBER NOT NULL
);

CREATE SEQUENCE SECPROVEEDOR
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRIPROVEEDOR
    BEFORE INSERT
    ON PROVEEDOR
    FOR EACH ROW
    BEGIN
        SELECT SECPROVEEDOR.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;


---------- TABLA ALMACEN ++ --
CREATE TABLE INVENTARIO_ALMACEN(
ID NUMBER PRIMARY KEY NOT NULL,
NOMBRE_ALMACEN NVARCHAR2(50) NOT NULL,
ID_PROVEEDOR NUMBER NOT NULL,
EXISTENCIA NUMBER NOT NULL,
BAJAS NUMBER NOT NULL,
DEVOLUCIONES NUMBER NOT NULL,
FOREIGN KEY(ID_PROVEEDOR) REFERENCES PROVEEDOR(ID)
);

CREATE SEQUENCE SECALMACEN
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRIALMACEN
    BEFORE INSERT
    ON INVENTARIO_ALMACEN
    FOR EACH ROW
    BEGIN
        SELECT SECALMACEN.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA INVENTARIO EN DEPARTAMENTO ++ --
CREATE TABLE INVENTARIO_DEPARTAMENTO(
ID NUMBER PRIMARY KEY NOT NULL,
ID_PROVEEDOR NUMBER NOT NULL,
PRODUCTO_MOSTRADOR NUMBER NOT NULL,
PRECIO_MOSTRADOR NUMBER NOT NULL,
FOREIGN KEY(ID_PROVEEDOR) REFERENCES PROVEEDOR(ID)
);

CREATE SEQUENCE SECINVDEPARTAMENTO
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRI_INVDEP
    BEFORE INSERT
    ON INVENTARIO_DEPARTAMENTO
    FOR EACH ROW
    BEGIN
        SELECT SECINVDEPARTAMENTO.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA DE DEPARTAMENTOS ++ -- 
CREATE TABLE DEPARTAMENTOS(
ID NUMBER PRIMARY KEY NOT NULL,
ID_INVDEP NUMBER NOT NULL,
ID_INVALM NUMBER NOT NULL,
ID_SUCURSAL NUMBER NOT NULL,
NOMBRE NVARCHAR2(50) NOT NULL,
ENCARGADO NVARCHAR2(50) NOT NULL,
FOREIGN KEY(ID_INVDEP) REFERENCES INVENTARIO_DEPARTAMENTO(ID),
FOREIGN KEY(ID_INVALM) REFERENCES INVENTARIO_ALMACEN(ID),
FOREIGN KEY(ID_SUCURSAL) REFERENCES SUCURSAL(ID)
);

CREATE SEQUENCE SECDEPARTAMENTOS
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRIDEPARTAMENTOS
    BEFORE INSERT
    ON DEPARTAMENTOS
    FOR EACH ROW
    BEGIN
        SELECT SECDEPARTAMENTOS.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

---------- TABLA DE VENTAS ++ -- 
CREATE TABLE VENTAS(
ID NUMBER PRIMARY KEY,
ID_DEPARTAMENTO NUMBER NOT NULL,
TOTAL_PROVEN NUMBER NOT NULL,
TOTAL_INGRED NUMBER NOT NULL,
FOREIGN KEY(ID_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(ID)
);

CREATE SEQUENCE SECVENTAS
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER TRIVENTAS
    BEFORE INSERT
    ON VENTAS
    FOR EACH ROW
    BEGIN
        SELECT SECVENTAS.NEXTVAL INTO :NEW.ID FROM DUAL;
    END;

--------------------------------- DATOS ----------------------------

--TIENDA
INSERT INTO TIENDA(NOMBRE) VALUES('CHEDRAUI');
INSERT INTO TIENDA(NOMBRE) VALUES('WALMART');
COMMIT;
SELECT * FROM TIENDA;

-- DOMICILIO
INSERT INTO DOMICILIO VALUES(72160, 'PUEBLA', 'LA PAZ');
INSERT INTO DOMICILIO VALUES(72266, 'PUEBLA', 'LOS FUERTES');
INSERT INTO DOMICILIO VALUES(74000, 'SAN MARTIN', 'OJO DE AGUA');
INSERT INTO DOMICILIO VALUES(74135, 'SAN LUCAS', 'LA COLONIA');
COMMIT;
SELECT * FROM DOMICILIO;

-- UBICACION
INSERT INTO UBICACION(ID_DOMICILIO, TEL) VALUES(72160, 2225893674);
INSERT INTO UBICACION(ID_DOMICILIO, TEL) VALUES(74000, 2481235220);
COMMIT;
SELECT * FROM UBICACION;

-- SUCURSAL
INSERT INTO SUCURSAL(ID_TIENDA, NOMBRE, ID_UBICACION) VALUES(1, 'CHEDRAUI LA PAZ', 1);
INSERT INTO SUCURSAL(ID_TIENDA, NOMBRE, ID_UBICACION) VALUES(2, 'WALMART SAN MARTIN', 2);
COMMIT;
SELECT * FROM SUCURSAL;

-- SALARIOS
INSERT INTO PUESTOS(PUESTO, SALARIO, PRESTACION) VALUES('CAJA', 8000, 'TODAS LAS PRESTACIONES');
INSERT INTO PUESTOS(PUESTO, SALARIO, PRESTACION) VALUES('MOSTRADOR', 9000, 'TODAS LAS PRESTACIONES');
INSERT INTO PUESTOS(PUESTO, SALARIO, PRESTACION) VALUES('VENDEDOR', 1000, 'TODAS LAS PRESTACIONES');
COMMIT;
SELECT * FROM PUESTOS;

-- EMPLEADOS
INSERT INTO EMPLEADOS(ID_SUCURSAL, ID_DOMICILIO, ID_SALARIO, NOMBRE, TEL, NSS, CLABE) VALUES(1, 72266, 1, 'ALFREDO', 2205698471, 2569834, 7896541569);
COMMIT;
SELECT * FROM EMPLEADOS;

-- PROVEEDOR
INSERT INTO PROVEEDOR(NOMBRE, PRODUCTO, PRECIOU, CANTIDAD) VALUES('PANADERIA', 'CONCHA', 12, 3);
COMMIT;
SELECT * FROM PROVEEDOR;

-- ALMACEN
INSERT INTO INVENTARIO_ALMACEN(NOMBRE_ALMACEN, ID_PROVEEDOR, EXISTENCIA, BAJAS, DEVOLUCIONES) VALUES('COCINA PANADERIA', 1, 5, 0, 0);
COMMIT;
SELECT * FROM INVENTARIO_ALMACEN;

-- INVENTARIO DEPARTAMENTO
INSERT INTO INVENTARIO_DEPARTAMENTO(ID_PROVEEDOR, PRODUCTO_MOSTRADOR, PRECIO_MOSTRADOR) VALUES(1, 4, 18);
COMMIT;
SELECT * FROM INVENTARIO_DEPARTAMENTO;

-- DEPARTAMENTOS
INSERT INTO DEPARTAMENTOS(ID_INVDEP, ID_INVALM, ID_SUCURSAL, NOMBRE, ENCARGADO) VALUES(1, 1, 1, 'PANADERIA CHEDRAUI', 'ALFONSO');
COMMIT;
SELECT * FROM DEPARTAMENTOS;

-- VENTAS
INSERT INTO VENTAS(ID_DEPARTAMENTO, TOTAL_PROVEN, TOTAL_INGRED) VALUES(1, 4, 72);
COMMIT;
SELECT * FROM VENTAS;