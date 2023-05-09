package service

import (
	"crypto/md5"
	"database/sql"
	"encoding/hex"
	"fmt"
	_ "github.com/lib/pq"
)

func MakeUser() error {
	db, err := sql.Open("postgres", "postgres://postgres:postgres@postgresql-b:5432/postgres?sslmode=disable")

	if err != nil {
		return err
	}

	hasher := md5.New()
	hasher.Write([]byte(String(10)))

	sql := fmt.Sprintf(
		"INSERT INTO users(firstname, lastname, email, password, date_of_birth) VALUES ('%s', '%s', '%s', '%s', '%s')",
		String(10),
		String(10),
		fmt.Sprintf("%s@example.com", String(10)),
		hex.EncodeToString(hasher.Sum(nil)),
		Rundate(),
	)

	_, err = db.Exec(sql)

	defer db.Close()

	if err != nil {
		return err
	}

	return nil
}

func FindUserByDateOfBirth() error {
	db, err := sql.Open("postgres", "postgres://postgres:postgres@postgresql-b:5432/postgres?sslmode=disable")

	if err != nil {
		return err
	}

	hasher := md5.New()
	hasher.Write([]byte(String(10)))

	sql := fmt.Sprintf(
		"SELECT * from users where users.date_of_birth between '%s' and '%s'",
		"1999-01-01",
		"2000-01-01",
	)

	_, err = db.Exec(sql)

	defer db.Close()

	if err != nil {
		return err
	}

	return nil
}

func FindUserByLastname() error {
	db, err := sql.Open("postgres", "postgres://postgres:postgres@postgresql-b:5432/postgres?sslmode=disable")

	if err != nil {
		return err
	}

	hasher := md5.New()
	hasher.Write([]byte(String(10)))

	sql := fmt.Sprintf(
		"SELECT * from users where users.lastname='%s'",
		String(10),
	)

	_, err = db.Exec(sql)

	defer db.Close()

	if err != nil {
		return err
	}

	return nil
}
