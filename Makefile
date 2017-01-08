containerbin:
	go get github.com/xtracdev/tlsconfig
	GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o getclient
