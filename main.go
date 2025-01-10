package main

import (
	"authentication-app/cmd"

	"github.com/rs/zerolog/log"
)

func main() {
	if err := cmd.NewRootCommand().Execute(); err != nil {
		log.Fatal().Msgf("Failed runn app: %s", err.Error())
	}
}
