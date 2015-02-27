CC=g++
#CCFLAGS=-Wall -Ofast -mfpu=vfp -lpthread -g -D__Raspberry_Pi -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s
CCFLAGS=-Wall -Ofast -lpthread -g -D__Raspberry_Pi

# define all programs
PROGRAMS = MyGateway MySensor MyMessage PiEEPROM
GATEWAY  = PiGateway
GATEWAY_SERIAL = PiGatewaySerial

GATEWAY_SRCS = ${GATEWAY:=.cpp}
GATEWAY_SERIAL_SRCS = ${GATEWAY_SERIAL:=.cpp}
SOURCES = ${PROGRAMS:=.cpp}

GATEWAY_OBJS = ${GATEWAY:=.o}
GATEWAY_SERIAL_OBJS = ${GATEWAY_SERIAL:=.o}
OBJS = ${PROGRAMS:=.o}

GATEWAY_DEPS = ${GATEWAY:=.h}
GATEWAY_SERIAL_DEPS = ${GATEWAY_SERIAL:=.h}
DEPS = ${PROGRAMS:=.h}

CINCLUDE=-I. -IRF24Remote/RF24Frontend -IRF24Remote/RF24Remote -IRF24Remote/RF24


all: ${GATEWAY} ${GATEWAY_SERIAL}

%.o: %.cpp %.h ${DEPS}
	${CC} -c -o $@ $< ${CCFLAGS} ${CINCLUDE}

${GATEWAY}: ${OBJS} ${GATEWAY_OBJS}
	${CC} -o $@ ${OBJS} ${GATEWAY_OBJS} ${CCFLAGS} ${CINCLUDE} -lrf24frontend -lusb

${GATEWAY_SERIAL}: ${OBJS} ${GATEWAY_SERIAL_OBJS}
	${CC} -o $@ ${OBJS} ${GATEWAY_SERIAL_OBJS} ${CCFLAGS} ${CINCLUDE} -lrf24frontend -lutil -lusb

clean:
	rm -rf $(PROGRAMS) $(GATEWAY) $(GATEWAY_SERIAL) $(BUILDDIR)/${OBJS}

