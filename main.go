package main

import "fmt"

var (
	Version   string
	GitCommit string
)

func main() {
	fmt.Printf("release-it: %s, commit: %s\n", Version, GitCommit)
}
