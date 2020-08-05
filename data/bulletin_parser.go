package main

import (
    "fmt"
    "os"
    "io/ioutil"
    "log"
    "strings"
)

func main() {

    //argsWithProg := os.Args
    //argsWithoutProg := os.Args[1:]

 if len(os.Args) < 2 {
    fmt.Println("pass filename")

        os.Exit(1)
    }


    filename := os.Args[1]

    //fmt.Println(argsWithProg)
    //fmt.Println(argsWithoutProg)
    fmt.Println(filename)

    if fileExists(filename) {
        fmt.Println(filename," file exists")
    } else {
        fmt.Println(filename, " file does not exist (or is a directory)")
        os.Exit(1)

    }


content, err := ioutil.ReadFile(filename)

     if err != nil {
          log.Fatal(err)
     }

    //fmt.Println(string(content))


content_lines := strings.Split(string(content),"\n")
useful_lines := []int{}
//fmt.Println(arr)
for i, s := range content_lines {
    //fmt.Println(i, s)
    var str_lower  = strings.TrimSpace(strings.ToLower(s))
    fmt.Println(i, str_lower)
    if strings.Contains(str_lower, "death case") {
        useful_lines = append(useful_lines,i)
    }

}

fmt.Println(useful_lines)
fmt.Println(strings.Join(content_lines[useful_lines[0]:useful_lines[len(useful_lines)-1]+10],"\n"))


}






// fileExists checks if a file exists and is not a directory before we
// try using it to prevent further errors.
func fileExists(filename string) bool {
    info, err := os.Stat(filename)
    if os.IsNotExist(err) {
        return false
    }
    return !info.IsDir()
}