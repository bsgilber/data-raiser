package config

import (
	"fmt"

	"github.com/spf13/viper"
)

type LoggerConfig struct {
	Level string `mapstructure:"level"`
}

type Config struct {
	Logging LoggerConfig `mapstructure:"logging"`
}

func NewConfig(configFilePath string, env string) *Config {
	viper.SetConfigName(env)
	viper.SetConfigType("yaml")
	viper.AddConfigPath(configFilePath)

	err := viper.ReadInConfig()
	if err != nil {
		panic(fmt.Errorf("Fatal error config file: %s \n", err))
	}

	var config Config

	err = viper.Unmarshal(&config)
	if err != nil {
		panic(fmt.Errorf("Unable to decode Config: %s \n", err))
	}

	return &config
}
