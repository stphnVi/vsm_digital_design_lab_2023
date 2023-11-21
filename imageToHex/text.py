import binascii

with open('C:/Users/steph/OneDrive/Documentos/GitHub/vsm_digital_design_lab_2023/imageToHex/bratz.jpeg', 'rb') as f:
    content = f.read()
# print(binascii.hexlify(content))

hex_content = binascii.hexlify(content)

# Guardar el resultado en un archivo de texto
output_filename = 'C:/Users/steph/OneDrive/Documentos/GitHub/vsm_digital_design_lab_2023/imageToHex/image.txt'

with open(output_filename, 'w') as output_file:
    # Decodificar y escribir en el archivo
    output_file.write(hex_content.decode('utf-8'))

print(f"El resultado se ha guardado en '{output_filename}'.")
