# sonos-doorbell
HTTP driven doorbell chime for a Sonos system. 

Sonos doorbell uses the SoCo python package to drive a doorbell chime from an HTTP Web request. It is a fully contained python
service that can be paired with out IoT devices or smart doorbells to play an audio file on a set of Sonos devices.

The sonos-doorbell project launches a simple HTTP server that both receives the incoming doorbell requests and hosts the MP3 files to be used by the doorbell ring. 

### Launch local
1. Install python3
1. Edit `main.sh` to specify the Zone name and port you want the server to be hosted on
1. Run `main.sh`

### Launch in Docker

##### Build Image

`docker build . -t sonos-doorbell`

##### Run Image

Only works on Linux, due to requirment of docker host networking  
`docker run -d -e PORT=8888 -e ROOM=Kitchen --name sonos-doorbell --network host --restart always sonos-doorbell`

### Test
http://{hostname:port}/doorbell_press?ringtone=dingdong1&volume=45 

### Doorbird Systems
1. Setup an HTTP call with the doorbell_press url you verified above
1. Setup the doorbell press schedule to trigger the HTTP Relay
