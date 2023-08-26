#!/bin/bash

#Variables de conexión a la base de datos
DB_HOST="localhost"
DB_NAME="bikerentalshop"
DB_USER="postgres"
DB_PASSWORD="alexander1212"

#Funcion para consultas
consultTable() {
    echo "Consultemos una tabla"
    echo "Selecciona la tabla que quieres consultar: bike, rent, clients"
    read tableName
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "SELECT * FROM $tableName;"
    
}

#Funcion para agregar registros en la tabla de bicicleta
addBike() {
    echo "Agregemos una bicicleta"
    echo "Cual es el modelo: "
    read model
    echo "Cual es la marca: "
    read brand
    echo "Cual es el tipo de bicicleta: "
    read type
    echo "Cual es el color de la bicicleta: "
    read color
    echo "Cual es el precio: "
    read price
    price=$(expr "$price" + 0)
    echo "La bicicleta tiene disponibilidad: "
    read available
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "INSERT INTO Bike (model, brand, type, color, price, available) VALUES ('"$model"', '"$brand"', '"$type"', '"$color"', $price, $available);"
    
}

#Funcion para agregar registros en la tabla de rentas
addRent() {
    echo "Rentemos una bicicleta"
    echo "Cual es tu id: "
    read client
    echo "Cual es el id de la bicicleta: "
    read bike
    echo "Fecha de inicio: "
    read sdate
    echo "Fecha de finalizacion: "
    read edate
    echo "Precio pagado: "
    read pprice
    pprice=$(expr "$pprice" + 0)
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "INSERT INTO Rent (client, bike, rentdate, returndate, totalamount) VALUES ('"$client"', '"$bike"', '"$sdate"', '"$edate"', $pprice);"
    
    
}

#Funcion para agregar registros en la tabla de clientes
addClient() {
    echo "Registremonos"
    echo "Cual es tu nombre: "
    read name
    echo "Cual es tu mail: "
    read mail
    echo "Cual es tu numero: "
    read number
    number=$(expr "$number" + 0)
    echo "Cual es tu ciudad: "
    read city
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "INSERT INTO Clients (name, mail, cellphonenumber, country) VALUES ('"$name"', '"$mail"', $number, '"$city"');"
    
}

#Funcion para agregar registros
addRegister() {
    echo "Que tabla quieres editar:"
    opciones=("bike" "rent" "client" "exit")
    select opt in "${opciones[@]}"
    do
        case $opt in
            "bike")
                addBike; break
            ;;
            
            "rent")
                addRent; break
            ;;
            
            "client")
                addClient; break
            ;;
            "exit") break 2
            ;;
            *) echo "Opcion no válida."
        esac
    done
}

#Funcion para alterar registros
alterRegister() {
    echo "Editemos los registros"
    echo "Selecciona una tabla: bike, rent, clients"
    read tableName
    echo "Ingresa el ID del registro que deseas editar: "
    read recordId

    if [[ "$tableName" == "bike" ]]; then
        echo "Elige el campo que deseas editar: model, brand, type, color, price, available"
        read field

        echo "Ingresa el nuevo valor: "
        read newValue
    elif [[ "$tableName" == "rent" ]]; then  
        echo "Elige el campo que deseas editar: rentdate, returndate, totalamount"
        read field

        echo "Ingresa el nuevo valor: "
        read newValue
    elif [[ "$tableName" == "clients" ]]; then 
        echo "Elige el campo que deseas editar: name, mail, cellphonenumber, country"
        read field

        echo "Ingresa el nuevo valor: "
        read newValue
    fi

    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "UPDATE $tableName SET $field = '$newValue' WHERE id = $recordId;"
}


#Funcion para la eliminacion de registros
deleteRegister() {
    echo "Elimimenos registros"
    echo "Selecciona una tabla: bike, rent, clients"
    read tableName
    echo "Ingresa el ID del registro que deseas eliminar: "
    read recordId
    
    psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "DELETE FROM $tableName WHERE id = $recordId;"
}

#Menu
echo "╲╲╭┻┻┻┻┻┻┻┻┻┻╮╱╱
╲╲┃╱▔▔╲┊┊╱▔▔╲┃╱╱
╭━┫▏╭╮▕┊┊▏╭╮▕┣━╮
┃╭┫╲┻┻╱┊┊╲┻┻╱┣╮┃
┃╰╮╱▔▔╱◼◼╲▔▔╲╭╯┃
╰━┓▏┏┳┳┳┳┳┳┓▕┏━╯
╱╱┃▏╰┻┻┻┻┻┻╯▕┃╲╲"

echo "Hola, mi nombre es Baymax, tu asisente de terminal personal, en que te puedo ayudar: "

opciones=("consultar una tabla" "agregar registros" "alterar registros" "eliminar registros" "salir")
select opt in "${opciones[@]}"
do
    case $opt in
        "consultar una tabla")
            consultTable; break
        ;;
        
        "agregar registros")
            addRegister; break
        ;;
        
        "alterar registros")
            alterRegister; break
        ;;
        
        "eliminar registros")
            deleteRegister; break
        ;;
        
        "salir") break 2
        ;;
        *) echo "Opcion no válida."
    esac
done
