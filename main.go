package main

import (
	"database/sql"
	"log"

	"github.com/cocryv/simplebank/api"
	db "github.com/cocryv/simplebank/db/sqlc"
	"github.com/cocryv/simplebank/util"
	_ "github.com/lib/pq" // blind import pour que postgre fonctionne
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config")
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db :", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot start srv :", err)
	}

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start serv")
	}

}
