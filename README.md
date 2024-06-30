# Dell-IDRAC-FanControl
 
Docker image that will adjust fan speed based on the exhaust temperature

Example docker-compose.yml :


```yml
version: '3'
services:
  dell-idrac-fancontrol:
    image: pdiddy973/dell-idrac-fancontrol:latest
    container_name: dell-idrac-fancontrol
    restart: unless-stopped
    environment:
      - IDRAC_HOST=
      - IDRAC_USER=
      - IDRAC_PW=
      - CHECK_INTERVAL=
```

| Environment | Function |
| :----: | --- |
| `IDRAC_HOST` | IDRAC IP Address |
| `IDRAC_USER` | IDRAC Username |
| `IDRAC_PW` | IDRAC Password |
| `CHECK_INTERVAL` | How often to check in seconds |
