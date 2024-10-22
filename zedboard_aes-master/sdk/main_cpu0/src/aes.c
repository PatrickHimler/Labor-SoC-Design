/*
 * aes.c
 *
 *  Created on: Apr 3, 2018
 *      Author: jrtsang
 */

#include "common.h"

/******************************* Definitions *********************************/

XGpio gpioSwitches;
/*****************************************************************************/

/*****************************************************************************/
/**
*
* Setting AES 128-bit key and encryption or decryption mode to IP block
*
* @param    const uint8_t* key        : 128-bit cipher key
*           enum AESMODE mode         : Cipher mode
*
* @return   true if successful, false otherwise
*
* @note     None
*
**/
/*****************************************************************************/
bool aes_process_init(const uint8_t *key, enum AESMODE mode)
{
    uint32_t *aesProcessAddress = (uint32_t*)XPAR_AES_PROCESS_0_S00_AXI_BASEADDR;

    // Set Key (first 4 registers (0-3))
    *(aesProcessAddress+0) =  key[0] << 24 |  key[1] << 16 |  key[2] << 8 |  key[3];
    *(aesProcessAddress+1) =  key[4] << 24 |  key[5] << 16 |  key[6] << 8 |  key[7];
    *(aesProcessAddress+2) =  key[8] << 24 |  key[9] << 16 | key[10] << 8 | key[11];
    *(aesProcessAddress+3) = key[12] << 24 | key[13] << 16 | key[14] << 8 | key[15];

    // Set Mode (last register (9))
    switch(mode) {
        case ENCRYPTION:
            *(aesProcessAddress+8) = 0x00000000;
            break;
        case DECRYPTION:
            *(aesProcessAddress+8) = 0xFFFFFFFF;
            break;
        default:
            return false;
            break;
    };

    return true;
}

/*****************************************************************************/
/**
*
* Setting AES 128-bit key and encryption or decryption mode to IP block
*
* @param    const uint8_t* key        : 128-bit cipher key
*           enum AESMODE mode         : Cipher mode
*
* @return   true if successful, false otherwise
*
* @note     None
*
**/
/*****************************************************************************/
void _getKeyValue(XGpio *gpioSwitches, uint8_t *switchKey) {
    // Fixed key lookup table, DO NOT MODIFY
    const uint8_t keys[] = {
            0x72, 0x42, 0xf8, 0xeb, 0xe2, 0xca, 0x6c, 0x20, 0x6c, 0xd8, 0xdf, 0x1a, 0xcd, 0xe3, 0xfd, 0xe7,
            0x89, 0xb3, 0x6e, 0xae, 0x31, 0xa4, 0x73, 0x7a, 0xda, 0x5c, 0x4a, 0x41, 0x63, 0x33, 0x11, 0xbd,
            0xf3, 0x52, 0x2a, 0x20, 0x1a, 0xfd, 0x97, 0x3e, 0x13, 0x7a, 0xec, 0x26, 0x3f, 0x8d, 0xeb, 0xdf,
            0x18, 0x6e, 0xb8, 0x08, 0x46, 0x4a, 0xd0, 0x15, 0xbf, 0x81, 0xb7, 0xa2, 0x3b, 0x78, 0xc2, 0x44,
            0xdc, 0x4c, 0x81, 0x75, 0x22, 0x74, 0x07, 0xae, 0x75, 0x8c, 0x65, 0xd0, 0x89, 0x25, 0x72, 0x67,
            0xa3, 0x02, 0x2d, 0xdd, 0xdf, 0x45, 0x0d, 0x3c, 0xa3, 0x44, 0x49, 0x4a, 0xe4, 0x09, 0x15, 0x2c,
            0x36, 0xe4, 0xb2, 0x70, 0xcd, 0x70, 0xc2, 0x06, 0x8c, 0xf2, 0xf9, 0x95, 0x83, 0x0e, 0x92, 0xb3,
            0x4d, 0xe1, 0xab, 0x84, 0x86, 0x2e, 0x41, 0x1a, 0x31, 0x83, 0xf6, 0xbe, 0x6e, 0x5d, 0x25, 0xa6,
            0x4d, 0x43, 0xf6, 0x9b, 0x72, 0xe7, 0xb0, 0xeb, 0x7c, 0xd4, 0xbb, 0x5a, 0xa3, 0xd1, 0x3e, 0xac,
            0xa9, 0x30, 0x9b, 0x17, 0x1b, 0x53, 0xf6, 0x78, 0x41, 0xf8, 0xef, 0x79, 0x78, 0xe5, 0x5b, 0x0b,
            0x06, 0x79, 0x72, 0x9a, 0x0d, 0xa1, 0x45, 0xa1, 0xda, 0x79, 0x17, 0x33, 0x78, 0x33, 0xbf, 0x84,
            0xfe, 0xa8, 0x1a, 0x4b, 0x7c, 0xb0, 0x79, 0xa0, 0x64, 0x0f, 0xf3, 0x3d, 0xe6, 0x72, 0xf3, 0x1d,
            0x89, 0x30, 0xa1, 0x0e, 0x41, 0xb6, 0xd8, 0x6d, 0x95, 0xfd, 0xd7, 0x79, 0xf9, 0xfb, 0xc9, 0x39,
            0xd1, 0x9f, 0x1c, 0x99, 0x88, 0x3a, 0x1a, 0xcf, 0xc1, 0xbf, 0x93, 0x01, 0x26, 0xe2, 0x40, 0x17,
            0xc9, 0x10, 0x64, 0x5d, 0x1c, 0xc8, 0x39, 0xec, 0x9d, 0x9e, 0x1e, 0xff, 0x4a, 0xe1, 0xe8, 0xc7,
            0x16, 0xbe, 0xc2, 0xc3, 0x77, 0x15, 0x36, 0xc2, 0x8b, 0x29, 0xea, 0x73, 0x5b, 0x58, 0x25, 0x20,
            0xd7, 0xac, 0x69, 0x1d, 0xbb, 0x86, 0xb3, 0x47, 0xf8, 0xf1, 0x58, 0x12, 0xd1, 0x57, 0xec, 0x83,
            0xbc, 0x8a, 0x7e, 0xe9, 0x69, 0xf6, 0x2c, 0x86, 0x13, 0x0e, 0x13, 0x1c, 0xf4, 0x0d, 0xe6, 0x08,
            0xdd, 0xc9, 0xf7, 0xc0, 0x3c, 0xab, 0x0e, 0x11, 0x7c, 0x57, 0x8e, 0x36, 0x4c, 0x57, 0xbc, 0x1f,
            0x7c, 0xfe, 0x0a, 0x61, 0x57, 0x53, 0x83, 0x88, 0x7c, 0x70, 0x71, 0xe8, 0x5b, 0x5b, 0x0a, 0x67,
            0xfb, 0x47, 0xcf, 0x9a, 0x7d, 0x0e, 0x9c, 0x94, 0x52, 0x54, 0xaa, 0x3a, 0xf6, 0x82, 0xd2, 0xa8,
            0x44, 0xfa, 0x2d, 0x2d, 0x14, 0x56, 0x06, 0xcf, 0x21, 0x47, 0x75, 0xb2, 0x7c, 0x0a, 0xd7, 0x2c,
            0x96, 0xe4, 0x38, 0xec, 0xba, 0xcc, 0x69, 0x79, 0x80, 0xc3, 0x52, 0xab, 0x5c, 0x9e, 0x0f, 0x09,
            0xd2, 0x50, 0x4f, 0xe5, 0x86, 0xf1, 0xe9, 0xec, 0x39, 0x4b, 0x61, 0x93, 0xb6, 0x6e, 0x62, 0xc0,
            0x09, 0x49, 0x49, 0x0b, 0x53, 0xfb, 0x11, 0xb2, 0xe7, 0xf9, 0x0b, 0xe5, 0xff, 0xfb, 0x9c, 0x28,
            0x2f, 0xef, 0x79, 0x24, 0x38, 0x0f, 0xc7, 0x75, 0x92, 0x01, 0xf2, 0xa8, 0x14, 0xab, 0x4b, 0xd4,
            0xc2, 0x38, 0xed, 0xfa, 0x29, 0x27, 0xb9, 0xa5, 0x27, 0x3d, 0x14, 0x1a, 0xe5, 0xb7, 0x46, 0x84,
            0xf7, 0x39, 0x04, 0x23, 0x93, 0x19, 0x17, 0x47, 0x28, 0xea, 0x4c, 0x06, 0x35, 0xaf, 0x91, 0x0b,
            0xc7, 0x65, 0x89, 0xf1, 0xf0, 0x87, 0xc7, 0xfe, 0x71, 0x2f, 0x75, 0x99, 0xcc, 0x9f, 0x9b, 0x4a,
            0xd1, 0x2c, 0x1c, 0x5a, 0x80, 0x6c, 0x8c, 0x53, 0x84, 0xf2, 0x88, 0x99, 0x8b, 0xf5, 0x24, 0x8c,
            0xeb, 0xf3, 0x03, 0xe5, 0x61, 0x25, 0x34, 0xbd, 0xe3, 0x29, 0x27, 0x26, 0x9f, 0x41, 0x96, 0x74,
    };
    uint8_t dipValue;
    int i;

    // Convert dipValue to switchKey from table above
    dipValue = XGpio_DiscreteRead(gpioSwitches, 1);
    for (i = 0; i < 16; i++) {
        switchKey[i] = keys[dipValue+i*16];
    }
}

/*****************************************************************************/
/**
*
* Initialize DMA streaming and toggle switches for key
*
* @param    None
*
* @return   None
*
* @note     None
*
**/
/*****************************************************************************/
void aes_init(void) {

    if(XST_SUCCESS != XGpio_Initialize(&gpioSwitches, XPAR_SW_LED_GPIO_AXI_DEVICE_ID)) {
#if UART_PRINT
        printf("UH OH: GPIO SWS initialization failed\r\n");
#endif
    };
    // Set the direction of the bits in the GPIO
    // The lower (LSB) 8 bits of the GPIO are for the DIP Switches (inputs)
    // The upper (MSB) 8 bits of the GPIO are for the LEDs (outputs)
    XGpio_SetDataDirection(&gpioSwitches, 1, 0x00FF);
}

/*****************************************************************************/
/**
*
* XOR two states
*
* @param    uint8_t* buf              : Pointer to AES state block
*           uint8_t* Iv               : Pointer to initialzation vector/
*                                        state block to XOR with
*
* @return   None
*
* @note     None
*
**/
/*****************************************************************************/
void _aes_cbc_xor(uint8_t* buf, uint8_t* Iv)
{
  uint8_t i;
  for (i = 0; i < AES_BLOCKLEN; ++i)
  {
    buf[i] ^= Iv[i];
  }
}

/*****************************************************************************/
/**
*
* Processing system for CBC mode cipher
*
* @param    XAxiDma *axiDma           : Pointer to DMA
*           uint32_t *inputBuf        : Pointer to input memory
*           uint32_t *outputBuf       : Pointer to output memory
*           int fileSize              : Size of file
*           enum AESMODE mode         : Cipher mode
*
* @return   enum STATUS
*
* @note     None
*
**/
/*****************************************************************************/
enum STATUS _aes_cbc_run(XAxiDma *axiDma, uint32_t *inputBuf, uint32_t *outputBuf, int fileSize, enum AESMODE mode)
{
    int i;
    const uint8_t iv_key[] =  { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
    uint8_t *previousState  = malloc(AES_BLOCKLEN * sizeof(uint8_t));

    memcpy(previousState, iv_key, AES_BLOCKLEN);

    cancelFlag = false;
    if(mode == ENCRYPTION) {
        for(i = 0; i < fileSize; i += AES_BLOCKLEN) {
            _aes_cbc_xor((uint8_t *)inputBuf, previousState);
            dma_aes_process_transfer(axiDma, inputBuf, outputBuf);
            dma_aes_process_transfer(axiDma, inputBuf, outputBuf); // Workaround for caching issue
            memcpy(previousState, (uint8_t *)outputBuf, AES_BLOCKLEN);

            inputBuf += AES_BLOCKLEN/4;
            outputBuf += AES_BLOCKLEN/4;
            // Cancel interrupt flag
            if (cancelFlag) {
                COMM_VAL = 0;
                free(previousState);
                return CANCELLED;
            }
        }
    }

    if(mode == DECRYPTION) {
        for(i = 0; i < fileSize; i += AES_BLOCKLEN) {
            dma_aes_process_transfer(axiDma, inputBuf, outputBuf);
            dma_aes_process_transfer(axiDma, inputBuf, outputBuf);
            _aes_cbc_xor((uint8_t *)outputBuf, previousState);
            memcpy(previousState, inputBuf, AES_BLOCKLEN);

            inputBuf += AES_BLOCKLEN/4;
            outputBuf += AES_BLOCKLEN/4;
            // Cancel interrupt flag
            if (cancelFlag) {
                COMM_VAL = 0;
                free(previousState);
                return CANCELLED;
            }
        }
    }

    free(previousState);
    return DONE;
}

/*****************************************************************************/
/**
*
* Processing system for ECB mode cipher
*
* @param    XAxiDma *axiDma           : Pointer to DMA
*           uint32_t *inputBuf        : Pointer to input memory
*           uint32_t *outputBuf       : Pointer to output memory
*           int fileSize              : Size of file
*
* @return   enum STATUS
*
* @note     None
*
**/
/*****************************************************************************/
enum STATUS _aes_ecb_run(XAxiDma *axiDma, uint32_t *inputBuf, uint32_t *outputBuf, int fileSize)
{
    int i;
    cancelFlag = false;
    // Loop till entire file is done
    for(i = 0; i < fileSize; i += AES_BLOCKLEN)
    {
        // Stream state to AES_PROCESS IP
        dma_aes_process_transfer(axiDma, inputBuf, outputBuf);
        inputBuf += AES_BLOCKLEN/4;
        outputBuf += AES_BLOCKLEN/4;
        // Cancel interrupt flag
        if (cancelFlag) {
            COMM_VAL = 0;
            return CANCELLED;
        }
    }
    return DONE;
}

/*****************************************************************************/
/**
*
* Main processing system for AES cipher for SD card
*
* @param    enum AESMODE mode         : Cipher mode
*
* @return   enum STATUS
*
* @note     None
*
**/
/*****************************************************************************/
enum STATUS aes_sd_process_run(enum AESTYPE type, enum AESMODE mode, XAxiDma *axiDma)
{
    char* keyConfirmation[] =     {"  Please enter  ",
                                   " AES key using  ",
                                   "  the switches  ",
                                   "Click < to abort"};

    char* encryptConfirmation[] = {" File will now  ",
                                   "  be encrypted  ",
                                   " Are you sure?  ",
                                   "Click < to abort"};

    char* decryptConfirmation[] = {" File will now  ",
                                   "  be decrypted  ",
                                   " Are you sure?  ",
                                   "Click < to abort"};

    char* processingScreen[] =    {"                ",
                                   "  Loading file  ",
                                   "      ....      ",
                                   "                "};

    // SD variables
    char **fileList;
    char **fileListMenu;
    int numOfFiles;
    uint32_t fileSizeRead;

    // Key variables
    uint8_t switchKey[16];

    // DMA variables
    uint32_t *outputBuf = (u32*)RX_BUFFER_BASE;
    uint32_t *inputBuf = (u32*)TX_BUFFER_BASE;

    int choice;

    // Padding Variables
    int bytesToPad;

    // Get file list from SD and create menu format
    fileList = sd_list_all_files(&numOfFiles);
    fileListMenu = oled_format_fileList(fileList, numOfFiles); // numOfFiles offset by 1

    // File selection screen
aes_sd_process_run_files:
    choice = oled_selection_screen(fileListMenu, numOfFiles+1);
    if(choice > 0) {

aes_sd_process_run_key:
        // Key selection screen
        if(!oled_confirmation_screen(keyConfirmation)) {
            goto aes_sd_process_run_files;
        } else {
            // Get key value
            _getKeyValue(&gpioSwitches, switchKey);
        }

        // Confirmation screen
        switch(mode) {
            case ENCRYPTION:
                if(!oled_confirmation_screen(encryptConfirmation)) {
                    goto aes_sd_process_run_key;
                }
                break;
            case DECRYPTION:
                if(!oled_confirmation_screen(decryptConfirmation)) {
                    goto aes_sd_process_run_key;
                }
                break;
            default:
                free(fileList);
                free(fileListMenu);
                return FAILED; // Shouldn't reach here
                break;
        };

        // Temporary processing screen before CPU1 is kicked off
        oled_print_screen(processingScreen);


        // Read in file to transfer buffer
        fileSizeRead = 0;
        if(!sd_read_from_file(fileList[choice-1], (u32*)TX_BUFFER_BASE, &fileSizeRead)) {
            free(fileList);
            free(fileListMenu);
            return FAILED;
        }

        // Start CPU1 processing screen
        FILESIZE_VAL = fileSizeRead;
        COMM_VAL = 1;

        // PKCS7 Padding so encrypted data is 16 bytes aligned
        //  If already 16 bytes, add another 16 bytes
        //  bytesToPad is 0 for decryption
        bytesToPad = 0;
        if(mode == ENCRYPTION) {
            bytesToPad = 16 - fileSizeRead % 16; // Difference of remainder length in bytes

            char pad = (char)(16-fileSizeRead%16); // Character pattern used for padding
            uint8_t *inputBufEnd = (uint8_t *)TX_BUFFER_BASE;
            for(int i = 0; i < bytesToPad ; i++) {
                *(inputBufEnd+fileSizeRead+i) = pad;
            }
        }

        // Init registers in AES_PROCESS IP
        aes_process_init(switchKey, mode);

        switch(type) {
            case ECB:
                 if(CANCELLED == _aes_ecb_run(axiDma, inputBuf, outputBuf, fileSizeRead+bytesToPad-1)) {
                     return CANCELLED;
                 }
                break;
            case CBC:
                 if(CANCELLED == _aes_cbc_run(axiDma, inputBuf, outputBuf, fileSizeRead+bytesToPad-1, mode)) {
                     return CANCELLED;
                 }
                break;
            default:
                free(fileList);
                free(fileListMenu);
                return FAILED; // Shouldn't reach here
                break;
        }


        // Remove padding if decryption by adjusting the fileSizeRead
        if(mode == DECRYPTION) {
            int newFileSize = fileSizeRead;
            uint8_t *outputBufEnd = (uint8_t *)RX_BUFFER_BASE;
            for(int i = fileSizeRead; i > fileSizeRead-16-1; i--) {
                if(*(outputBufEnd+fileSizeRead-1) == *(outputBufEnd+i-2)) {
                    newFileSize-=1; // If last padding character matches previous, decrease file size
                }
            }
            newFileSize-=1; // Remove original last one used for comparison
            fileSizeRead = newFileSize;
        }

        // Create output file from return buffer
        sd_write_to_file(fileList[choice-1], (u32*)RX_BUFFER_BASE, fileSizeRead+bytesToPad);

        // Stop CPU1 processing screen
        COMM_VAL = 0;
        free(fileList);
        free(fileListMenu);
        return DONE;
    } else {
        // Back one menu if not file selection
        free(fileList);
        free(fileListMenu);
        return BACK;
    }
}
