package main

import (
	"fmt"
	"log"
	"os"

	"github.com/bitfield/script"
)

func main() {
	pwd, err := os.Getwd()
	if err != nil {
		log.Fatalf("wtf: %v", err)
	}
	tmp, err := os.CreateTemp(os.TempDir(), "lfcd")
	if err != nil {
		log.Fatalf("failed to create temporary file: %v", err)
	}
	tmp.Close()
	script.Exec(fmt.Sprintf(`lf -last-dir-path="%s"`, tmp.Name())).Stdout()
	dir, err := os.ReadFile(tmp.Name())
	if err != nil {
		log.Fatalf("failed to read temporary file: %v", err)
	}

	newDir := string(dir)
	if pwd != newDir {
		fmt.Println(newDir)
	}

	os.Remove(tmp.Name())
}
