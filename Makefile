DEUBG = -DXOP_DEBUG -DISVP_DEBUG 

TARGET = tts
OBJS_PATH = objs

# CROSS_COMPILE = mips-linux-gnu-
CXX   = $(CROSS_COMPILE)g++
CC    = $(CROSS_COMPILE)gcc
STRIP = $(CROSS_COMPILE)strip

INC1  = -I$(shell pwd)/src
LIB1  = -lcurl -lssl -lcrypto -ljson-c
INC = $(INC1) $(INC2) $(INC3) $(INC4) $(INC5) $(INC6) $(INC7) $(INC8) $(INC9) $(INC10)
LIB = $(LIB1) $(LIB2) $(LIB3) $(LIB4) $(LIB5) $(LIB6) $(LIB7) $(LIB8) $(LIB9) $(LIB10)

O_FLAG = 
VERSION_FLAG = -Xlinker --defsym -Xlinker __BUILD_DATE=$$(date +'%Y%m%d')
  
LD_FLAGS  = $(O_FLAG) -lrt -pthread -lpthread -ldl -lm 
CXX_FLAGS = -std=c++11 -g
C_FLAGS = -g
SRC1  = $(notdir $(wildcard ./src/*.c))		
OBJS1 = $(patsubst %.c,$(OBJS_PATH)/%.o,$(SRC1))	

all: BUILD_DIR $(TARGET)

BUILD_DATE = $$(date +'%Y-%m-%d-%H.%M.%S')

BUILD_DIR:
	@-mkdir -p $(OBJS_PATH)
	
#@-echo "#define BUILD_TIME \"$(BUILD_DATE)\"" > ./src/version.h
$(TARGET) : $(OBJS1) $(OBJS2) $(OBJS3) $(OBJS4) $(OBJS5) $(OBJS6) $(OBJS7)
	$(CC) $^ -o $@ $(CFLAGS) $(LD_FLAGS) $(LIB) $(VERSION_FLAG)
	cp $(TARGET) $(TARGET)_debug
	$(STRIP) -s $(TARGET)	
    

$(OBJS_PATH)/%.o : ./src/%.c 
	$(CC) -c $< -o  $@ $(INC1) $(C_FLAGS) 

clean: 
	-rm -rf $(OBJS_PATH) $(TARGET)

lib:
	yum install -y json-c-devel

install:
	cp tts /usr/local/bin










