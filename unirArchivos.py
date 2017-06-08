# Permite unir hojas de diferentes libros de trabajo de excel, en un solo libro

## Cargar las librerias a utilizar 
# Es necesario instalarlas previamente, con los siguientes pasos:
# 2. Instalar el pip de python: https://pip.pypa.io/en/stable/installing/#do-i-need-to-install-pip
# 1. instalar las librerias necesarias, ejemplo: pip install <Nombre de la libreria>

import fnmatch
import os
import xlwt
from xlwt import Workbook
import win32com.client
 
#### Obtener la lista de archivos, filtrar los archivos xlsx y almacenar los nombre en una lista
dirArchivos = raw_input('\nEscribe el nombre directorio que contiene los archivos: ')
nuevoArchivo = raw_input('\nEscribe el nombre del archivo que se va a crear: ')
extension = '.xlsx'

dirname = os.getcwd()
directorioExcel = dirname + '\\' + dirArchivos
archivosDirectorio = os.listdir(directorioExcel)

lista = list()

count = 0 
for archivo in archivosDirectorio:
	if fnmatch.fnmatch(archivo, '*.xlsx'):
		print archivo
	else:
		continue
	lista.append(archivo)
#print lista


count2 = 1

## Crear un nuevo libro de trabajo en el cual se copiara la hoja de calculo obtenida		
xlApp = win32com.client.DispatchEx('Excel.Application')
nwb = xlApp.Workbooks.Add()
print '\n El nuevo archivo se llama es: ',nwb
		
for libro in lista:
	print "___________"
	libro = libro.rstrip()
	print libro
	
	ruta = directorioExcel + '\\' + libro
	print "La ruta es: ", ruta
	# Abrir el archivo 
	xlwb = xlApp.Workbooks.Open(directorioExcel + '\\' + libro)
	print 'Name of file: ', xlwb
	
	# Contar el numero de hojas que tiene el archivo
	count = xlwb.Sheets.Count
	
	while count > 1:
		
		## Extraer la hoja de calculo y almacenarla en una variable
		sheet = xlwb.Worksheets(count)
		print 'Reading:',sheet
		
		# Obtener el nombre de la hoja
		nombreSheet = sheet.Name
		nombreSheet = nombreSheet.rstrip()
		print "El nombre de la hojas es: ", nombreSheet
		
		## Copiar la hoja de trabajo obtenida
		sheet.Copy(nwb.Worksheets(count2))
		print 'Sheet was copieded...'
		
		count = count -1
		count2 = count2 + 1
		print "Count 2: ", count2
	xlwb.Close(True)

## Cerrar los procesos de excel
# Guardar la nueva hoja
nwb.SaveAs(dirname + '\\' + nuevoArchivo + extension)
nwb.Close(True)
xlApp.Quit()