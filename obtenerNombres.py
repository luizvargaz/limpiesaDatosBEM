import xlrd
import xlsxwriter

print "Leyendo el archivo..."
#wb = xlwt.Workbook()		
#book = xlrd.open_workbook(nuevoArchivo + extension) # http://stackoverflow.com/questions/3307912/question-on-python-xlrd
book = xlrd.open_workbook('nuevoArchivo.xlsx')
print "El libro se ha leido...\n"

#print "Worksheet name(s):", book.sheet_names()

nSheets = list()
for sheet in book.sheets():
	
	nSheets.append(sheet.name)
	
	print 'Se agrego a la lista...\n'

print nSheets

print '\n ------------\n'

workbook = xlsxwriter.Workbook('nombreHojas.xlsx')
worksheet = workbook.add_worksheet()
print 'Se ha creado el archivo', workbook

conteo = 0
for s in nSheets:
	print s 
	worksheet.write(conteo, 0, s)
	conteo = conteo + 1

workbook.close('nombreHojas.xlsx')


