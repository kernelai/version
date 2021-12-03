package main

import (
	"fmt"
	"github.com/kernelai/version/versioninfo"
)

func main() {
	fmt.Println("hello, world!")
	printInfo()
}

func printInfo()  {
	fmt.Println("Release Version:", versioninfo.ReleaseVersion)
	fmt.Println("Git Commit Hash:", versioninfo.GitHash)
	fmt.Println("Git Branch:", versioninfo.GitBranch)
	fmt.Println("UTC Build Time: ", versioninfo.BuildTS)
}
