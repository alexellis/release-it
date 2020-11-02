package main

import "fmt"

var (
	Version string
	Commit  string
)

func main() {
	fmt.Println(Version, Commit)
}
