{
  servers: [{
      server: "./servers/tcp"
    },
    {
      server: "./servers/udp"
    },
  ],
  backends: ["./backends/console"],
  dumpMessages: true,
  automaticConfigReload: false,
}
