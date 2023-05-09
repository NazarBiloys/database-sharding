package main

import (
	"fmt"
	"github.com/NazarBiloys/database-sharding/internal/service"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Start process of making user...")
	err := service.MakeUser()
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("User was stored.")
}

func main() {
	http.HandleFunc("/date_of_birth", handlerDateOfBirth)
	http.HandleFunc("/lastname", handlerLastname)
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":90", nil))
}

func handlerLastname(writer http.ResponseWriter, request *http.Request) {
	err := service.FindUserByLastname()
	if err != nil {
		fmt.Println(err)
	}
}

func handlerDateOfBirth(writer http.ResponseWriter, request *http.Request) {
	err := service.FindUserByDateOfBirth()
	if err != nil {
		fmt.Println(err)
	}
}
